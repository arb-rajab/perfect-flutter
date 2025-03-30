// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyBZ4oob3Pbcdf-OHFYxdCqi91T9hZqYZYM",
    authDomain: "perfect-1ef4e.firebaseapp.com",
    projectId: "perfect-1ef4e",
    storageBucket: "perfect-1ef4e.firebasestorage.app",
    messagingSenderId: "188356388614",
    appId: "1:188356388614:web:054a2a33726e6882392087",
    measurementId: "G-CR0FH5KXBZ"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});