window.onload = async function() {
    try {
        const sID = localStorage.getItem('sID') || '1';
        const API_BASE = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1' ? 'http://localhost:4000' : '';
        const response = await fetch(`${API_BASE}/linkedBrand/${sID}`);
        if (!response.ok) {
            throw new Error('Failed to fetch data');
        }
        const data = await response.json();
        console.log('Data:', data);
        
        const tbody = document.querySelector('tbody');
        tbody.innerHTML = ''; // Clear existing rows

        data.forEach(brand => {
            const row = document.createElement('tr'); // Create a new table row
            row.innerHTML = `
                <td>${brand.bname}</td>
                <td>${brand.bcity}</td>
                <td><button class="button button-danger" onclick="removeBrand('${sID}','${brand.bname}', '${brand.bcity}')">Remove</button></td>            `;
            tbody.appendChild(row); // Append the new row to the tbody
        });
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};

async function removeBrand(sID,bname, bcity) {
    if (!confirm('Are you sure you want to remove this associated brand?')) {
        return;
    }
    try {
        const API_BASE = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1' ? 'http://localhost:4000' : '';
        const response = await fetch(`${API_BASE}/linkedBrand/${sID}/${bname}/${bcity}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ sID, bname, bcity})
        });
        if (!response.ok) {
            throw new alert('Failed to remove brand');
        }
        
        alert('Brand removed successfully!');
        location.reload();
        // You may want to update the UI or take other actions upon successful addition
    } catch (error) {
        console.error('Error removing brand:', error);
    }
}