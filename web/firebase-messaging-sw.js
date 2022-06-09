// console.log("")
importScripts("https://www.gstatic.com/firebasejs/8.4.3/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "SOe1_hZy43VIzKiAD5lN3jrQ0o",
    authDomain: "guven-mobile-7c512.firebaseapp.com",
    databaseURL: "https://guven-mobile-7c512.firebaseio.com",
    projectId: "guven-mobile-7c512",
    storageBucket: "guven-mobile-7c512.appspot.com",
    messagingSenderId:  "647411760545",
    appId: "1:647411760545:web:20b622784c0cb600259fe0",
    measurementId: "G-GPMMZ6Y733"
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