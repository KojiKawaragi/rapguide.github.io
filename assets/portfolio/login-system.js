// Utility: Show toast notifications (uses your CSS classes)
function showToast(message, type) {
    const toast = document.getElementById('notification');
    toast.textContent = message;
    toast.className = `toast ${type} show`;
    setTimeout(() => toast.classList.remove('show'), 3000); // Auto-hide after 3 seconds
}

// Utility: Get users from localStorage (simulates database)
function getUsers() {
    return JSON.parse(localStorage.getItem('users')) || {};
}

// Utility: Save users to localStorage
function saveUsers(users) {
    localStorage.setItem('users', JSON.stringify(users));
}

// Handle login form submission (for profile-login.html)
if (document.getElementById('login-form')) {
    document.getElementById('login-form').addEventListener('submit', function(e) {
        e.preventDefault();
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value;
        const users = getUsers();

        if (users[username] && users[username].password === password) {
            showToast('Login successful! Redirecting...', 'success');
            // Simulate redirect (replace with your actual dashboard URL, e.g., '../dashboard.html')
            setTimeout(() => window.location.href = '../dashboard.html', 1000);
        } else {
            showToast('Invalid username or password.', 'error');
        }
    });
}

// Handle register form submission (for profile-register.html)
if (document.getElementById('register-form')) {
    document.getElementById('register-form').addEventListener('submit', function(e) {
        e.preventDefault();
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value;
        const email = document.getElementById('email').value.trim();
        const users = getUsers();

        // Basic validation
        if (!username || !password || !email) {
            showToast('Please fill in all fields.', 'error');
            return;
        }
        if (users[username]) {
            showToast('Username already exists. Try a different one.', 'error');
            return;
        }
        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            showToast('Please enter a valid email.', 'error');
            return;
        }

        // Register user
        users[username] = { password, email };
        saveUsers(users);
        showToast('Registration successful! You can now log in.', 'success');
        // Optional: Auto-redirect to login page
        setTimeout(() => window.location.href = '../portfolio/profile-login.html', 1000);
    });
}
