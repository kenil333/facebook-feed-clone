# Facebook Feed Clone

This Flutter Project was created with Flutter version 3.16.0.

## Getting Started

1. Clone this repository.
2. Install Flutter and Dart if you haven't already. (3.16.0)
3. Open the project in your preferred IDE or code editor.
4. Run `flutter pub get` to install dependencies.

### To run the project there is a two way:

1. Use an IDE like Android Studio or Visual Studio Code, IDEs provides the direct run mechanism.
2. You can run the `flutter run` command in the terminal of the project.


## Clean Architecture

The project follows a clean architecture pattern for better organization and scalability. The architecture comprises layers such as:

1. Presentation: UI components and business logic (Provider).
2. Domain: Repositories.
3. Data: Data sources, external APIs, Firebase Helpers.


## Firebase Condiguration

This project is pre-configured with Firebase for backend functionalities such as Firebase Real Time Database and Firebase Storage. Firebase setup files for both Android and iOS platforms are included.

### Configuration Files

- **Android**: The Firebase configuration file for Android `google-service.json` is already integrated into the project setup.
- **iOS**: The necessary `google-service-info.plist` file is placed within the runner folder for iOS. In Xcode, locate and add the `google-service-info.plist` file to the project directory.

### Note

- Android configuration is preset and requires no additional steps for Firebase setup.
- For iOS, the `google-service-info.plist` file is critical for Firebase functionality. Reference it correctly in the Xcode project to ensure proper integration with the `runner`.