window.onload = async function() {
    try {
        const response = await fetch(`${API_BASE}/purchaseOrder`);
        if (!response.ok) {
            throw new Error('Failed to fetch data');
        }
        const data = await response.json(); // Array of arrays
        
        console.log('PurchaseOrder:', data);
        
        const tbody = document.querySelector('tbody');
        tbody.innerHTML = ''; // Clear existing rows
        
        // Iterate over each array of brand objects
        data.forEach(brandArray => {
            // Iterate over each brand object in the array
            brandArray.forEach(data => {
                const row = document.createElement('tr');
                row.innerHTML = `
                <td>${data.cname}</td>
                <td>${data.bname}</td>
                <td>${data.bcity}</td>
                <td>${data.item}</td>
                <td>${data.category}</td>
                <td>${data.price}</td>
                <td>${data.quantity}</td>
                <td>${data.pstatus}</td>
                <td><button class="button" onclick="markComplete('1','${data.bname}', '${data.bcity}', '${data.item}', '${data.category}', '${data.price}', '${data.quantity}')">Completed</button></td>
                <td><button class="button" onclick="removeProduct('1','${data.bname}', '${data.bcity}', '${data.item}')">Remove</button></td
                `;
                tbody.appendChild(row);
            });
        });
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};

async function removeProduct(customerID, bname, bcity, item) {
    try {
        const response = await fetch(`${API_BASE}/purchaseOrder/${customerID}`, {
            method: 'DELETE'
        });
        
        alert('Order removed successfully!');
        location.reload();
        
    } catch (error) {
        console.alert('Error removing Order:', error);
    }
}

async function markComplete(customerID, bname, bcity, item, category, price, quantity) {
    try {
        const response = await fetch(`${API_BASE}/purchaseOrder/${customerID}`, {
            method: 'PATCH',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                bname: bname,
                bcity: bcity,
                item: item,
                category: category,
                price: price,
                quantity: quantity,
                pstatus: 'completed'
            })
        });

        alert('Purchase order marked as completed successfully!');
        location.reload();
    } catch (error) {
        console.error('Error marking order as completed:', error);
    }
}

document.addEventListener('DOMContentLoaded', async function () {
    // Function to open the modal when the "Add" button is clicked
    document.getElementById('addButton').addEventListener('click', async function () {
        document.getElementById('modal').style.display = 'block'; // Display the modal

        const customerSelect = document.getElementById('customerName');
        const brandSelect = document.getElementById('brandName');
        const citySelect = document.getElementById('city');
        const itemSelect = document.getElementById('item');
        const categorySelect = document.getElementById('category');
        const priceInput = document.getElementById('price');

        try {
            // Fetch customer names
            const customersResponse = await fetch(`${API_BASE}/customerList`);
            const customersData = await customersResponse.json();
            customersData.forEach(customer => {
                const option = document.createElement('option');
                option.textContent = customer;
                customerSelect.appendChild(option);
            });
            // Fetch brands
            const brandsResponse = await fetch(`${API_BASE}/brandsList`);
            const brandsData = await brandsResponse.json();
            brandsData.forEach(brand => {
                const option = document.createElement('option');
                option.textContent = brand;
                brandSelect.appendChild(option);
            });

            // Event listener for brand select
            brandSelect.addEventListener('change', async function () {
                const selectedBrand = this.value;

                try {
                    // Fetch cities based on the selected brand
                    const citiesResponse = await fetch(`${API_BASE}/citiesList?brand=${selectedBrand}`);
                    const citiesData = await citiesResponse.json();

                    citySelect.innerHTML = '<option value="">Select City</option>';
                    citiesData.forEach(city => {
                        const option = document.createElement('option');
                        option.textContent = city;
                        citySelect.appendChild(option);
                    });

                    // Fetch items based on the selected brand
                    const itemsResponse = await fetch(`${API_BASE}/items?brand=${selectedBrand}`);
                    if (!itemsResponse.ok) {
                        throw new Error('Failed to fetch items');
                    }
                    const itemsData = await itemsResponse.json();
                    
                    itemSelect.innerHTML = '<option value="">Select Item</option>';
                    itemsData.forEach(items => {
                        const option = document.createElement('option');
                        option.textContent = items;
                        itemSelect.appendChild(option);
                    });
                   
                } catch (error) {
                    console.error('Error fetching items:', error);
                }
            });

            // Event listener for item select
            itemSelect.addEventListener('change', async function () {
                const selectedItem = this.value;

                try {
                    // Fetch category based on the selected item
                    const categoryResponse = await fetch(`${API_BASE}/categoryList?item=${selectedItem}`);
                    const categoryData = await categoryResponse.json();

                    categorySelect.innerHTML = '<option value=""></option>';
                    categoryData.forEach(category => {
                        const option = document.createElement('option');
                        option.textContent = category;
                        categorySelect.appendChild(option);
                    });

                    // Fetch price based on the selected item
                    const priceResponse = await fetch(`${API_BASE}/priceData?item=${selectedItem}`);
                    const priceData = await priceResponse.json();

                    priceInput.innerHTML = '<option value=""></option>';
                    priceData.forEach(price => {
                        const option = document.createElement('option');
                        option.textContent = price;
                        priceInput.appendChild(option);
                    });
                   
                } catch (error) {
                    console.error('Error fetching items:', error);
                }
            });

        } catch (error) {
            console.error('Error fetching data:', error);
        }
    });

    // Function to close the modal when the close button is clicked
    document.getElementsByClassName('close')[0].addEventListener('click', function () {
        console.log('Modal closed');
        document.getElementById('modal').style.display = 'none';
    });

    // Function to close the modal when clicking outside of it
    window.onclick = function (event) {
        const modal = document.getElementById('modal');
        if (event.target == modal) {
            modal.style.display = "none";
        }
    };
});
