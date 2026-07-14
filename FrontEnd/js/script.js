const sideMenu = document.querySelector('aside');
const menuBtn = document.querySelector('#menu_bar');
const closeBtn = document.querySelector('#close_btn');

const themeToggler = document.querySelector('.theme-toggler');

menuBtn.addEventListener('click',()=>{
  sideMenu.classList.add('show');
})
closeBtn.addEventListener('click',()=>{
  sideMenu.classList.remove('show');
})

themeToggler.addEventListener('click', () => {
  document.body.classList.toggle('dark-theme-variables');
  const isDarkMode = document.body.classList.contains('dark-theme-variables');
  localStorage.setItem('dark-theme-variables', isDarkMode); // Store dark mode preference
  themeToggler.querySelector('span:nth-child(1)').classList.toggle('active');
  themeToggler.querySelector('span:nth-child(2)').classList.toggle('active');

});
// Apply dark mode if it was enabled before
const isDarkMode = localStorage.getItem('dark-theme-variables') === 'true';
if (isDarkMode) {
  document.body.classList.add('dark-theme-variables');
  themeToggler.querySelector('span:nth-child(1)').classList.add('active');
}

// Fetch recent orders to show on dashboard updates
const initDashboard = async () => {
    try {
        const sID = localStorage.getItem('sID') || '1';
        const API_BASE = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1' ? 'http://localhost:4000' : '';
        const response = await fetch(`${API_BASE}/purchaseOrder/${sID}`);
        if (!response.ok) {
            throw new Error('Failed to fetch orders');
        }
        const data = await response.json(); // Array of arrays [[orders], [metadata]]
        const orders = data[0] || [];
        
        const updatesContainer = document.querySelector('.recent_updates .updates');
        if (updatesContainer) {
            updatesContainer.innerHTML = ''; // Clear hardcoded dummy list
            
            // Limit to 4 recent orders
            const recentOrders = orders.slice(-4).reverse(); // Get latest orders
            
            if (recentOrders.length === 0) {
                updatesContainer.innerHTML = `
                    <div class="empty-updates">
                        <span class="material-symbols-outlined">info</span>
                        <p>No recent purchase orders</p>
                    </div>
                `;
                return;
            }

            recentOrders.forEach(order => {
                const updateDiv = document.createElement('div');
                updateDiv.className = 'update';
                
                // Set appropriate message format based on status
                let messageHtml = '';
                if (order.pstatus === 'completed') {
                    messageHtml = `<p><b>${order.cname}</b>'s order of ${order.quantity}x ${order.item} is completed.</p>`;
                } else {
                    messageHtml = `<p><b>${order.cname}</b> ordered ${order.quantity}x ${order.item} (${order.pstatus}).</p>`;
                }

                updateDiv.innerHTML = `
                    <div class="profile-photo">
                        <img src="images/profile-2.jpg" alt="${order.cname}" />
                    </div>
                    <div class="message">
                        ${messageHtml}
                    </div>
                `;
                updatesContainer.appendChild(updateDiv);
            });
        }
    } catch (error) {
        console.error('Error loading recent updates:', error);
    }

    // User Profile Modal Controls
    const profileModal = document.getElementById('profileModal');
    const profileTrigger = document.querySelector('.profile');
    const closeProfileBtn = document.getElementById('closeProfileModal');
    
    if (profileTrigger && profileModal) {
        profileTrigger.addEventListener('click', () => {
            const username = localStorage.getItem('username') || 'Guest';
            const profileUsernameEl = document.getElementById('profileUsername');
            if (profileUsernameEl) {
                profileUsernameEl.textContent = username;
            }
            profileModal.style.display = 'block';
        });
    }
    
    if (closeProfileBtn && profileModal) {
        closeProfileBtn.addEventListener('click', () => {
            profileModal.style.display = 'none';
        });
    }
    
    // Close modal when clicking outside of it
    window.addEventListener('click', (event) => {
        if (event.target === profileModal) {
            profileModal.style.display = 'none';
        }
    });
};
initDashboard();