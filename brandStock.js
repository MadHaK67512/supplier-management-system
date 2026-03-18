window.onload = async function() {
    try {
        const response = await fetch(`${API_BASE}/brandStock`);
        if (!response.ok) {
            throw new Error('Failed to fetch data');
        }
        const data = await response.json(); // Array of arrays
        
        console.log('BrandStock:', data);
        
        const tbody = document.querySelector('tbody');
        tbody.innerHTML = ''; // Clear existing rows
        
        // Iterate over each array of brand objects
        data.forEach(brandArray => {
            // Iterate over each brand object in the array
            brandArray.forEach(data => {
                const row = document.createElement('tr');
                row.innerHTML = `
                <td>${data.bname}</td>
                <td>${data.bcity}</td>
                <td>${data.item}</td>
                <td>${data.category}</td>
                <td>${data.price}</td>
                <td>${data.quantity}</td>
                <td><button class="button" onclick="addProduct('2','${data.bname}', '${data.bcity}', '${data.item}', '${data.category}', '${data.price}', '${data.quantity}')">Add</button></td>
                `;
                tbody.appendChild(row);
            });
        });
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};

async function addProduct(id, bname, bcity, item, category, price, quantity) {
    try {
        const response = await fetch(`${API_BASE}/brandStock/`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ id, bname, bcity, item, category, price, quantity })
        });

        if (response.status === 409) {
            alert('Product already exists!');
            return; // Exit the function
        }
        
        if (!response.ok) {
            throw new alert('Failed to add product');
        }
        
        alert('Product added successfully!');
        location.reload();
    } catch (error) {
        console.error('Error adding product:', error);
    }
}
