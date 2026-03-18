window.onload = async function() {
    try {
        const response = await fetch(`${API_BASE}/brands`);
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
                <td>${brand.country}</td>
                <td><button class="button" onclick="addBrand('${brand.bname}', '${brand.bcity}')">Add</button></td>            `;
            tbody.appendChild(row); // Append the new row to the tbody
        });
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};

async function addBrand(bname, bcity) {
    try {
        const id = 1;
        const response = await fetch(`${API_BASE}/linkedbrand`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ id, bname, bcity})
        });

        if (response.status === 409) {
            alert('Brand already exists!');
            return; // Exit the function
        }
        
        if (!response.ok) {
            throw new alert('Failed to add brand');
        }
        
        alert('Brand added successfully!');
        location.reload();
    } catch (error) {
        console.error('Error adding brand:', error);
    }
}
