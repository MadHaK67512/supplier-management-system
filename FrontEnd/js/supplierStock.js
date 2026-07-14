window.onload = async function() {
    try {
        const sID = localStorage.getItem('sID') || '1';
        const API_BASE = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1' ? 'http://localhost:4000' : '';
        const response = await fetch(`${API_BASE}/supplierStock/${sID}`);
        if (!response.ok) {
            throw new Error('Failed to fetch data');
        }
        const data = await response.json(); // Array of arrays
        
        console.log('supplierStock:', data);
        
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
                <td><button class="button button-danger" onclick="removeProduct('${sID}','${data.bname}', '${data.bcity}', '${data.item}')">Remove</button></td>
                `;
                tbody.appendChild(row);
            });
        });
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};

async function removeProduct(sID, bname, bcity, item) {
    if (!confirm('Are you sure you want to remove this product from supplier stock?')) {
        return;
    }
    try {
        const API_BASE = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1' ? 'http://localhost:4000' : '';
        const response = await fetch(`${API_BASE}/supplierStock/${sID}/${bname}/${bcity}/${item}`, {
            method: 'DELETE'
        });
        
        // Display alert when customer is successfully removed
        alert('Order removed successfully!');
        
        location.reload();
        
    } catch (error) {
        console.alert('Error removing Order:', error);
    }
}
