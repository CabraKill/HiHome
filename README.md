# HiHome
HiHome app for home system

# build obfuscate
```bash
flutter build apk --obfuscate --split-debug-info=hihome/debug-info
```

# Firebase installation
* Put **google-services.json** inside *android/app*

## Web
* Create a firebaseConfig.js file besides the *index.html* with the content of the pai key
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
