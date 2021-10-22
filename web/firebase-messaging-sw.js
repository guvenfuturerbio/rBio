// console.log("")
importScripts("https://www.gstatic.com/firebasejs/8.4.3/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyDtXrBmkyb9UvBH_fU6Tz4MKfZijqDVKLo",
    authDomain: "rbio-ec8b1.firebaseapp.com",
    projectId: "rbio-ec8b1",
    storageBucket: "rbio-ec8b1.appspot.com",
    messagingSenderId: "265636530937",
    appId: "1:265636530937:web:5d18cdcf7fd03242263028",
    measurementId: "G-BYWQLYEVVW"
});
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});