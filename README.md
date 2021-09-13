# HiHome
HiHome app for home system

# build obfuscate
```bash
flutter build apk --obfuscate --split-debug-info=hihome/debug-info
```

# Firestore
Currently the proposal scheme is decrive bellow. The main objectives are:
* A unit can have multiple users
* A unit can have multiple sections
* A user can have multiple units
* A section can have subcollection of sections

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