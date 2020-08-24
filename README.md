# AECan iOS

## Project setup

### Requirements

- Xcode 11.2.1
- Ruby 2.5.3 (`.ruby-version` and `.ruby-gemset` files are provided for those who use `rvm`).

### First time configurations

- Install gems by running `bundle install`.

### Dependencies

- **Swift** dependencies are managed using CocoaPods. The pods are commited to the repo, so running `pod install` is only needed when modifying the `Podfile`.
- **Ruby** dependencies are managed using Bundler. Check the `Gemfile`.

## Schemes and environments

| Scheme                 | App Display Name | Bundle Identifier                 | Firebase Config File | Backend URL |
|------------------------|------------------|-----------------------------------|----------------------|-------------|
| Operator (Development) | AECan (Dev)      | com.inmind.AECan.operario.dev     | *Pending*            | *Pending*   |
| Operator (Staging)     | AECan (Staging)  | com.inmind.AECan.operario.staging | *Pending*            | *Pending*   |
| Operator (Development) | AECan (Dev)      | com.inmind.AECan.usuario.dev      | *Pending*            | *Pending*   |
| Operator (Staging)     | AECan (Staging)  | com.inmind.AECan.usuario.staging  | *Pending*            | *Pending*   |

## Deploy to Firebase App Distribution

### Requirements

- Install [Firebase CLI](https://firebase.google.com/docs/cli#install-cli-mac-linux).
- Login to Firebase running `firebase login`. You have to link a Google account with access to the Firebase project.
- Knowing the Apple developer account password and have access to a device to login using 2FA (this is not always requested - only the first time and then periodically).

### Building and uploading to Firebase

To upload a Development version run
```
fastlane distribute_operario_development_to_firebase
fastlane distribute_usuario_development_to_firebase
```

To upload a Staging version run
```
fastlane distribute_operario_staging_to_firebase
fastlane distribute_usuario_staging_to_firebase
```

To upload both versions, run
```
./distribute_to_firebase
```

Once the build is uploaded, you have to go to Firebase console and distribute it to some testers, this is NOT done automatically.

## Deploy to App Store

*TODO*