const API_BASE = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1' ? 'http://localhost:4000' : '';

window.onload = async function() {
    try {
        const sID = localStorage.getItem('sID') || '1';
        const response = await fetch(`${API_BASE}/purchaseOrder/${sID}`);
        if (!response.ok) {
            throw new Error('Failed to fetch data');
        }
        const data = await response.json();
        
        console.log('PurchaseOrder:', data);
        
        const tbody = document.querySelector('tbody');
        tbody.innerHTML = ''; // Clear existing rows

        if (!data || data.length === 0) {
            tbody.innerHTML = '<tr><td colspan="9" style="text-align:center;">No purchase orders found.</td></tr>';
            return;
        }
        
        // data is a flat array of purchase order objects
        data.forEach(order => {
            const row = document.createElement('tr');
            row.innerHTML = `
            <td>${order.cname}</td>
            <td>${order.bname}</td>
            <td>${order.bcity}</td>
            <td>${order.item}</td>
            <td>${order.category}</td>
            <td>${order.price}</td>
            <td>${order.quantity}</td>
            <td>${order.pstatus}</td>
            <td><button class="button button-success" onclick="markComplete('${order.cid}','${order.bname}', '${order.bcity}', '${order.item}', '${order.category}', '${order.price}', '${order.quantity}')">Completed</button></td>
            <td><button class="button button-danger" onclick="removeProduct('${order.cid}','${order.bname}', '${order.bcity}', '${order.item}')">Remove</button></td>
            `;
            tbody.appendChild(row);
        });
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};

async function removeProduct(customerID, bname, bcity, item) {
    if (!confirm('Are you sure you want to remove this purchase order?')) {
        return;
    }
    try {
        const response = await fetch(`${API_BASE}/purchaseOrder/${customerID}/${bname}/${bcity}/${item}`, {
            method: 'DELETE'
        });
        
        if (!response.ok) {
            throw new Error('Failed to delete purchase order');
        }
        
        // Display alert when customer is successfully removed
        alert('Order removed successfully!');
        location.reload();
        
    } catch (error) {
        console.error('Error removing Order:', error);
        alert('Failed to remove order: ' + error.message);
    }
}

async function markComplete(customerID, bname, bcity, item, category, price, quantity) {
    try {
        const response = await fetch(`${API_BASE}/purchaseOrder/${customerID}/${bname}/${bcity}/${item}`, {
            method: 'PATCH',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                pstatus: 'completed'
            })
        });

        if (!response.ok) {
            throw new Error('Failed to complete order');
        }

        // Assuming the request was successful, update the UI or take other actions if needed
        alert('Purchase order marked as completed successfully!');
        location.reload();
    } catch (error) {
        console.error('Error marking order as completed:', error);
        alert('Failed to mark order as completed: ' + error.message);
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
            const sID = localStorage.getItem('sID') || '1';
            // Fetch customer names
            const customersResponse = await fetch(`${API_BASE}/customerList/${sID}`);
            const customersData = await customersResponse.json();
            customersData.forEach(customer => {
                const option = document.createElement('option');
                option.textContent = customer;
                customerSelect.appendChild(option);
            });
            //Fetch brands
            const brandsResponse = await fetch(`${API_BASE}/brandsList/${sID}`);
            const brandsData = await brandsResponse.json();
            brandsData.forEach(brand => {
                const option = document.createElement('option');
                option.textContent = brand; // Adjust this based on your actual data structure
                brandSelect.appendChild(option);
            });

            // Event listener for brand select
            brandSelect.addEventListener('change', async function () {
                const selectedBrand = this.value; // Get the selected brand value

                try {
                    // Fetch cities based on the selected brand
                    const citiesResponse = await fetch(`${API_BASE}/citiesList?brand=${selectedBrand}`);
                    const citiesData = await citiesResponse.json();

                    // Clear previous options
                    citySelect.innerHTML = '<option value="">Select City</option>';

                    // Populate city options
                    citiesData.forEach(city => {
                    const option = document.createElement('option');
                    option.textContent = city; // Adjust this based on your actual data structure
                    citySelect.appendChild(option);
                    });


                    // Fetch items based on the selected brand
                    const itemsResponse = await fetch(`${API_BASE}/items?brand=${selectedBrand}`);
                    if (!itemsResponse.ok) {
                        throw new Error('Failed to fetch items');
                    }
                    const itemsData = await itemsResponse.json(); // Parse the JSON response
                    
                    // Clear previous options
                    itemSelect.innerHTML = '<option value="">Select Item</option>';
    
                    // Populate item options
                    itemsData.forEach(items => {
                        const option = document.createElement('option');
                        option.textContent = items; // Adjust this based on your actual data structure
                        itemSelect.appendChild(option);
                        
                    });
                   
                
                } catch (error) {
                    console.error('Error fetching items:', error);
                }
            });

            // Event listener for item select
            itemSelect.addEventListener('change', async function () {
                const selectedItem = this.value; // Get the selected brand value

                try {
                    // Fetch category based on the selected brand
                    const categoryResponse = await fetch(`${API_BASE}/categoryList?item=${selectedItem}`);
                    const categoryData = await categoryResponse.json();

                    // Clear previous options
                    categorySelect.innerHTML = '<option value=""></option>';
    
                    // Populate item options
                    categoryData.forEach(category => {
                        const option = document.createElement('option');
                        option.textContent = category; // Adjust this based on your actual data structure
                        categorySelect.appendChild(option);
                    });

                    // Fetch category based on the selected brand
                    const priceResponse = await fetch(`${API_BASE}/priceData?item=${selectedItem}`);
                    const priceData = await priceResponse.json();

                    // Clear previous options
                    priceInput.innerHTML = '<option value=""></option>';
    
                    // Populate item options
                    priceData.forEach(price => {
                        const option = document.createElement('option');
                        option.textContent = price; // Adjust this based on your actual data structure
                        priceInput.appendChild(option);
                    });
                   
                
                } catch (error) {
                    console.error('Error fetching items:', error);
                }
                });


        } catch (error) {
            console.error('Error fetching data:', error);
            // Handle error, show error message or retry logic
        }
    });

    // Function to close the modal when the close button is clicked
    document.getElementsByClassName('close')[0].addEventListener('click', function () {
        console.log('Modal closed');
        document.getElementById('modal').style.display = 'none'; // Hide the modal
    });

    // Function to close the modal when clicking outside of it
    window.onclick = function (event) {
        const modal = document.getElementById('modal');
        if (event.target == modal) {
            modal.style.display = "none"; // Hide the modal
        }
    };

    // Function to handle form submission
    document.getElementById('submit').addEventListener('click', async function (event) {
        event.preventDefault(); // Prevent default form submission
        console.log('Submit button clicked');
    
        // Get form data
        const customerName = document.getElementById('customerName').value;
        const brandName = document.getElementById('brandName').value;
        const city = document.getElementById('city').value;
        const item = document.getElementById('item').value;
        const category = document.getElementById('category').textContent;
        const price = document.getElementById('price').textContent;
        const quantity = document.getElementById('quantity').value;
    
        console.log("Form data:", customerName, brandName, city, item, category, price, quantity);
    
        // Create purchase order object
        const purchaseOrder = {
            cname: customerName,
            bname: brandName,
            bcity: city,
            item: item,
            category: category,
            price: price,
            quantity: quantity
        };
    
        // Send data to the server
        try {
            const response = await fetch(`${API_BASE}/purchaseOrder`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(purchaseOrder)
            });
    
            if (!response.ok) {
                throw new Error('Failed to add purchase order');
            }
    
            alert('Purchase order added successfully!');
            document.getElementById('modal').style.display = 'none'; // Close the modal
            location.reload(); // Reload the page to update the purchase order list
        } catch (error) {
            console.error('Error adding purchase order:', error);
        }
    });
    

});
