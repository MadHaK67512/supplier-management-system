const API_BASE = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1' ? 'http://localhost:4000' : '';

window.onload = async function() {
    try {
        const sID = localStorage.getItem('sID') || '1';
        const response = await fetch(`${API_BASE}/supplierStock/${sID}`);
        if (!response.ok) throw new Error('Failed to fetch data');
        const data = await response.json();
        console.log('supplierStock:', data);

        const tbody = document.querySelector('tbody');
        tbody.innerHTML = '';

        if (!data || data.length === 0) {
            tbody.innerHTML = '<tr><td colspan="7" style="text-align:center;">No stock yet. Click "Add Stock" to add items.</td></tr>';
            return;
        }

        // Fix: data is a flat array, not array of arrays
        data.forEach(item => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${item.bname}</td>
                <td>${item.bcity}</td>
                <td>${item.item}</td>
                <td>${item.category}</td>
                <td>${item.price}</td>
                <td>${item.quantity}</td>
                <td><button class="button button-danger" onclick="removeProduct('${sID}','${item.bname}','${item.bcity}','${item.item}')">Remove</button></td>`;
            tbody.appendChild(row);
        });
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};

document.addEventListener('DOMContentLoaded', function () {
    const addButton = document.getElementById('addButton');
    const modal = document.getElementById('modal');
    const brandSelect = document.getElementById('brandName');
    const citySelect = document.getElementById('brandCity');
    const itemSelect = document.getElementById('itemName');
    const form = document.getElementById('addStockForm');
    let allBrands = [];

    addButton.addEventListener('click', async function () {
        modal.style.display = 'block';
        brandSelect.innerHTML = '<option value="">Select Brand</option>';
        citySelect.innerHTML = '<option value="">Select City</option>';
        itemSelect.innerHTML = '<option value="">Select Item</option>';

        try {
            const res = await fetch(`${API_BASE}/brands`);
            allBrands = await res.json();
            const uniqueBrands = [...new Set(allBrands.map(b => b.bname))];
            uniqueBrands.forEach(name => {
                const opt = document.createElement('option');
                opt.value = name;
                opt.textContent = name;
                brandSelect.appendChild(opt);
            });
        } catch (err) {
            console.error('Error loading brands:', err);
        }
    });

    // When brand changes, populate cities
    brandSelect.addEventListener('change', async function () {
        const selected = this.value;
        citySelect.innerHTML = '<option value="">Select City</option>';
        itemSelect.innerHTML = '<option value="">Select Item</option>';
        allBrands.filter(b => b.bname === selected).forEach(b => {
            const opt = document.createElement('option');
            opt.value = b.bcity;
            opt.textContent = b.bcity;
            citySelect.appendChild(opt);
        });

        // Fetch items for this brand
        try {
            const res = await fetch(`${API_BASE}/items?brand=${selected}`);
            const items = await res.json();
            items.forEach(item => {
                const opt = document.createElement('option');
                opt.value = item;
                opt.textContent = item;
                itemSelect.appendChild(opt);
            });
        } catch (err) {
            console.error('Error loading items:', err);
        }
    });

    // Submit form
    form.addEventListener('submit', async function (e) {
        e.preventDefault();
        const sID = localStorage.getItem('sID') || '1';
        const bname = brandSelect.value;
        const bcity = citySelect.value;
        const item = itemSelect.value;
        const quantity = document.getElementById('quantity').value;

        if (!bname || !bcity || !item || !quantity) {
            alert('Please fill in all fields.');
            return;
        }

        try {
            const res = await fetch(`${API_BASE}/brandStock`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ id: sID, bname, bcity, item, quantity })
            });

            if (res.status === 409) {
                alert('This stock item already exists!');
                return;
            }
            if (!res.ok) throw new Error('Failed to add stock');

            alert('Stock added successfully!');
            modal.style.display = 'none';
            location.reload();
        } catch (err) {
            console.error('Error adding stock:', err);
            alert('Failed to add stock.');
        }
    });

    // Close modal on outside click
    window.addEventListener('click', e => {
        if (e.target === modal) modal.style.display = 'none';
    });
});

async function removeProduct(sID, bname, bcity, item) {
    if (!confirm('Are you sure you want to remove this stock item?')) return;
    try {
        const response = await fetch(`${API_BASE}/supplierStock/${sID}/${bname}/${bcity}/${item}`, {
            method: 'DELETE'
        });
        alert('Stock item removed successfully!');
        location.reload();
    } catch (error) {
        console.error('Error removing stock:', error);
    }
}
