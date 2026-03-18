window.onload = async function() {
    try {
        const response = await fetch(`${API_BASE}/supplierStock`);
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
                <td><button class="button" onclick="removeProduct('1','${data.bname}', '${data.bcity}', '${data.item}')">Remove</button></td>
                `;
                tbody.appendChild(row);
            });
        });
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};

async function removeProduct(sID, bname, bcity, item) {
    try {
        const response = await fetch(`${API_BASE}/supplierStock/${sID}/${bname}/${bcity}/${item}`, {
            method: 'DELETE'
        });
        
        // Display alert when successfully removed
        alert('Order removed successfully!');
        location.reload();
        
    } catch (error) {
        console.alert('Error removing Order:', error);
    }
}
