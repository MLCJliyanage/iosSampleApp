function sendName() {
    try {
        webkit.messageHandlers.loginAction.postMessage(
            document.getElementById("name").value
        );
    } catch(err) {
        console.log('Error');
    }
}

function getUsers() {
    try {
        webkit.messageHandlers.getUsers.postMessage(
            "button pressed"
        );
    } catch(err) {
        console.log('Error');
    }
}


function mobileHeader() {
    document.querySelector('h1').innerHTML = "WKWebView";
}
