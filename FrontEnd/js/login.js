document.addEventListener('DOMContentLoaded', () => {
    const loginForm = document.getElementById('login-form');

    loginForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        const username = document.getElementById('your_name').value.trim();
        const password = document.getElementById('your_pass').value;

        if (!username || !password) {
            alert('Please enter username and password.');
            return;
        }

        try {
            const API_BASE = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1' ? 'http://localhost:4000' : '';
            const response = await fetch(`${API_BASE}/api/login`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ username, password })
            });

            const data = await response.json();

            if (!response.ok) {
                throw new Error(data.error || 'Login failed.');
            }

            // Save user session details in localStorage
            localStorage.setItem('username', data.username);
            localStorage.setItem('sID', data.sID);
            
            alert('Login successful!');
            window.location.href = 'index.html';
        } catch (error) {
            alert(error.message);
            console.error('Login error:', error);
        }
    });
});
