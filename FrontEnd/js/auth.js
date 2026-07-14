(function() {
    const username = localStorage.getItem('username');
    const currentPage = window.location.pathname.split('/').pop();

    // Check if user is logged in. Redirect to login.html if not.
    if (!username && currentPage !== 'login.html' && currentPage !== 'Signup.html') {
        window.location.href = 'login.html';
        return;
    }

    // Set up logout button handler and dynamic username
    document.addEventListener('DOMContentLoaded', () => {
        const logoutLinks = document.querySelectorAll('a[href="login.html"]');
        logoutLinks.forEach(link => {
            link.addEventListener('click', () => {
                localStorage.removeItem('username');
            });
        });

        const profileNameEl = document.querySelector('.profile .info p b');
        if (profileNameEl && username) {
            profileNameEl.textContent = username;
        }
    });
})();
