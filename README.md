# HiHome
HiHome app for home system

# build obfuscate
```bash
flutter build apk --obfuscate --split-debug-info=hihome/debug-info
```

# Firestore 🧡
Currently, the proposed scheme is described below. The main objectives are:
* An unit has many users
* An unit has many sections
* An user has many units
* A section has many subcollections of sections

![firestore scheme](/README/scheme.png)

# Firebase installation
* Put **google-services.json** inside *android/app*

## Web
* Create a **firebaseConfig.js** file besides the **index.html** with the content of the pai key
```js
var firebaseConfigMap = {
    apiKey: "xxxxx",
    authDomain: "xxxx",
    projectId: "xxxx",
    storageBucket: "xxx",
    messagingSenderId: "xxxx",
    appId: "xxxx",
    measurementId: "xxxx"
  }
```

## Contributors
Thanks to:
* [@caiovini64](https://github.com/caiovini64) - for setting up the draggable use of devices. Well done, body.
