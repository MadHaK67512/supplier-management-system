document.addEventListener('DOMContentLoaded', () => {
    const registerForm = document.getElementById('register-form');

    registerForm.addEventListener('submit', async (event) => {
        event.preventDefault();

        const username = document.getElementById('name').value.trim();
        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('pass').value;
        const rePassword = document.getElementById('re_pass').value;
        const agreeTerm = document.getElementById('agree-term').checked;

        if (!username || !email || !password || !rePassword) {
            alert('Please fill in all fields.');
            return;
        }

        if (password !== rePassword) {
            alert('Passwords do not match.');
            return;
        }

        if (!agreeTerm) {
            alert('You must agree to the Terms of Service.');
            return;
        }

        try {
            const response = await fetch('http://localhost:4000/api/signup', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ username, email, password })
            });

            const data = await response.json();

            if (!response.ok) {
                throw new Error(data.error || 'Registration failed.');
            }

            alert('Registration successful! You can now log in.');
            window.location.href = 'login.html';
        } catch (error) {
            alert(error.message);
            console.error('Registration error:', error);
        }
    });
});
