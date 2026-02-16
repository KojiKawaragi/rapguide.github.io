// Login/Download State Update
function handleDownload(event) {
    event.preventDefault();

    // Login Status
    const isLoggedIn = localStorage.getItem("loggedIn");
    if (isLoggedIn === "true") {

        alert("The app isn't ready yet. Please wait for the announcement/update.");
    } else {
        // User not logged In
        alert("Please login first before downloading.");
        window.location.href = "assets/portfolio/profile-login.html";
    }
}