window.onload = async function() {
    try {
        const sID = localStorage.getItem('sID') || '1';
        const API_BASE = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1' ? 'http://localhost:4000' : '';
        const response = await fetch(`${API_BASE}/brandStock`);
        if (!response.ok) {
            throw new Error('Failed to fetch data');
        }
        const data = await response.json();
        
        console.log('BrandStock:', data);
        
        const tbody = document.querySelector('tbody');
        tbody.innerHTML = ''; // Clear existing rows

        if (!data || data.length === 0) {
            tbody.innerHTML = '<tr><td colspan="7" style="text-align:center;">No brand stock found.</td></tr>';
            return;
        }
        
        data.forEach(item => {
            const row = document.createElement('tr');
            row.innerHTML = `
            <td>${item.bname}</td>
            <td>${item.bcity}</td>
            <td>${item.item}</td>
            <td>${item.category}</td>
            <td>${item.price}</td>
            <td>${item.quantity}</td>
            <td><button class="button button-success" onclick="addProduct('${sID}','${item.bname}', '${item.bcity}', '${item.item}', '${item.category}', '${item.price}', '${item.quantity}')">Add</button></td>
            `;
            tbody.appendChild(row);
        });
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};

async function addProduct(id, bname, bcity, item, category, price, quantity) {
    try {
        const API_BASE = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1' ? 'http://localhost:4000' : '';
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
        // You may want to update the UI or take other actions upon successful addition
    } catch (error) {
        console.error('Error adding product:', error);
    }
}
