const API_BASE = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1' ? 'http://localhost:4000' : '';

window.onload = async function() {
    try {
        const sID = localStorage.getItem('sID') || '1';
        const response = await fetch(`${API_BASE}/linkedBrand/${sID}`);
        if (!response.ok) throw new Error('Failed to fetch data');
        const data = await response.json();
        console.log('Data:', data);

        const tbody = document.querySelector('tbody');
        tbody.innerHTML = '';

        if (!data || data.length === 0) {
            tbody.innerHTML = '<tr><td colspan="3" style="text-align:center;">No associated brands yet. Click "Add Brand" to link one.</td></tr>';
        } else {
            data.forEach(brand => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${brand.bname}</td>
                    <td>${brand.bcity}</td>
                    <td><button class="button button-danger" onclick="removeBrand('${sID}','${brand.bname}','${brand.bcity}')">Remove</button></td>`;
                tbody.appendChild(row);
            });
        }
    } catch (error) {
        console.error('Error fetching data:', error);
    }
};

document.addEventListener('DOMContentLoaded', function () {
    const addButton = document.getElementById('addButton');
    const modal = document.getElementById('modal');
    const brandSelect = document.getElementById('brandName');
    const citySelect = document.getElementById('brandCity');
    const form = document.getElementById('addBrandForm');

    // Open modal and populate brands
    addButton.addEventListener('click', async function () {
        modal.style.display = 'block';
        brandSelect.innerHTML = '<option value="">Select Brand</option>';
        citySelect.innerHTML = '<option value="">Select City</option>';

        try {
            const res = await fetch(`${API_BASE}/brands`);
            const brands = await res.json();
            const uniqueBrands = [...new Set(brands.map(b => b.bname))];
            uniqueBrands.forEach(name => {
                const opt = document.createElement('option');
                opt.value = name;
                opt.textContent = name;
                brandSelect.appendChild(opt);
            });

            // When brand is selected, populate cities
            brandSelect.addEventListener('change', function () {
                const selected = this.value;
                citySelect.innerHTML = '<option value="">Select City</option>';
                brands.filter(b => b.bname === selected).forEach(b => {
                    const opt = document.createElement('option');
                    opt.value = b.bcity;
                    opt.textContent = b.bcity;
                    citySelect.appendChild(opt);
                });
            });
        } catch (err) {
            console.error('Error loading brands:', err);
        }
    });

    // Submit form
    form.addEventListener('submit', async function (e) {
        e.preventDefault();
        const sID = localStorage.getItem('sID') || '1';
        const bname = brandSelect.value;
        const bcity = citySelect.value;

        if (!bname || !bcity) {
            alert('Please select both a brand and a city.');
            return;
        }

        try {
            const res = await fetch(`${API_BASE}/linkedbrand`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ sId: sID, bname, bcity })
            });

            if (res.status === 409) {
                alert('This brand is already associated!');
                return;
            }
            if (!res.ok) throw new Error('Failed to add brand');

            alert('Brand associated successfully!');
            modal.style.display = 'none';
            location.reload();
        } catch (err) {
            console.error('Error adding brand:', err);
            alert('Failed to associate brand.');
        }
    });

    // Close modal on outside click
    window.addEventListener('click', e => {
        if (e.target === modal) modal.style.display = 'none';
    });
});

async function removeBrand(sID, bname, bcity) {
    if (!confirm('Are you sure you want to remove this associated brand?')) return;
    try {
        const response = await fetch(`${API_BASE}/linkedBrand/${sID}/${bname}/${bcity}`, {
            method: 'DELETE',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ sID, bname, bcity })
        });
        if (!response.ok) throw new Error('Failed to remove brand');
        alert('Brand removed successfully!');
        location.reload();
    } catch (error) {
        console.error('Error removing brand:', error);
    }
}