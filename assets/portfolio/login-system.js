document.addEventListener('DOMContentLoaded', () => {
    // --- 1. REGISTRATION PAGE LOGIC ---
    const registerForm = document.getElementById('register-form');
    
    if (registerForm) {
        registerForm.addEventListener('submit', (e) => {
            e.preventDefault(); // Stop page from refreshing

            // Collect User Data
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const email = document.getElementById('email').value;

            // Check if user already exists
            if (localStorage.getItem(username)) {
                alert("This username is already taken. Try another one!");
                return;
            }

            // Create User Object
            const userData = {
                username: username,
                password: password,
                email: email,
                createdAt: new Date().toISOString()
            };

            // Save to "Database" (Local Storage)
            localStorage.setItem(username, JSON.stringify(userData));

            // Feedback and AUTOMATIC REDIRECT
            alert("Account created successfully! Redirecting you to login...");
            
            // This is the line that makes it automatic
            window.location.href = "../portfolio/profile-login.html"; 
        });
    }

    // --- 2. LOGIN PAGE LOGIC ---
    const loginForm = document.getElementById('login-form');
    
    if (loginForm) {
        loginForm.addEventListener('submit', (e) => {
            e.preventDefault();

            const usernameInput = document.getElementById('username').value;
            const passwordInput = document.getElementById('password').value;

            // Fetch user from storage
            const storedUser = localStorage.getItem(usernameInput);

            if (storedUser) {
                const user = JSON.parse(storedUser);

                // Verify Password
                if (user.password === passwordInput) {
                    // Start a Session
                    sessionStorage.setItem('isLoggedIn', 'true');
                    sessionStorage.setItem('currentUser', user.username);

                    alert("Welcome, " + user.username + "!");
                    window.location.href = "../../index.html"; // Go to main landing page
                } else {
                    alert("Incorrect password. Please try again.");
                }
            } else {
                alert("Account not found. Please sign up first.");
            }
        });
    }
});
