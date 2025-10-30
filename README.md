# Pockey Mon

> A comprehensive Pokémon encyclopedia app built with Flutter, featuring authentication, search, and detailed Pokémon information.

![Build Status](https://img.shields.io/badge/build-passing-brightgreen) ![License](https://img.shields.io/badge/license-MIT-blue) ![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter) ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)



## Objective

The main objective of the Pockey Mon app is to provide a simple and intuitive interface for users to browse, search, and view details about Pokémon. The app also includes user authentication to provide a personalized experience.

### Key Features:
- **Browse Pokémon**: Access a comprehensive list of Pokémon with smooth scrolling
- **Search Functionality**: Quickly find your favorite Pokémon
- **Detail View**: View comprehensive information about each Pokémon
- **User Authentication**: Secure login and registration system
- **Offline Support**: Access cached data even without internet connectivity
- **Animated UI**: Engaging animations powered by Lottie for enhanced user experience

## Logic

The application follows a structured user flow:

1. **Firebase Initialization**: The app starts by initializing Firebase services for authentication and data storage
2. **Authentication Check**: The system verifies if a user is currently logged in
3. **User Flow - Authenticated**: If logged in, users are directed to the `HomeScreen` displaying the Pokémon list
4. **User Flow - Unauthenticated**: If not logged in, users see the `LoginScreen` with options to sign in or register
5. **Registration Process**: New users can create an account through the `RegistrationScreen`
6. **Navigation**: From the `HomeScreen`, users can tap any Pokémon to navigate to the `PokemonDetailScreen` for detailed information
7. **Session Management**: Firebase handles user sessions and maintains authentication state across app launches

## Features

- **Pokémon List View**: Comprehensive grid/list view of all available Pokémon
- **Search Bar**: Real-time search filtering to quickly locate specific Pokémon
- **Animated Transitions**: Smooth, engaging animations using Lottie for page transitions and UI elements
- **Favorites System**: Mark and save your favorite Pokémon for quick access
- **Firestore Integration**: Real-time database synchronization for user data and preferences
- **Secure Login**: Firebase Authentication with email/password support
- **Custom Error Handling**: User-friendly error messages and graceful failure handling
- **Image Caching**: Optimized image loading with cached_network_image for better performance
- **Responsive Design**: Adaptive UI that works seamlessly across different screen sizes and orientations

## Code Structure

The code is organized into `screens`, `widgets`, and `tests` directories following a modular component architecture.

- `lib/main.dart`: The entry point of the application
- `lib/screens`: Contains the different screens of the application
    - `home_screen.dart`: Displays the list of Pokémon
    - `login_screen.dart`: Handles user login
    - `registration_screen.dart`: Handles user registration
    - `pokemon_detail_screen.dart`: Displays the details of a selected Pokémon
- `lib/widgets`: Contains reusable widgets following modular component architecture
    - `button.dart`: A custom button widget
- `test/`: Contains unit tests, widget tests, and integration tests for ensuring code quality

## Packages Used

- **cupertino_icons: ^1.0.8** - Provides iOS-style icons for a native look and feel
- **lottie: ^3.3.2** - Enables beautiful, performant animations from Adobe After Effects
- **cloud_firestore: ^6.0.3** - Real-time NoSQL database for storing user data and preferences
- **firebase_auth: ^6.1.1** - Handles secure user authentication and session management
- **firebase_core: ^4.2.0** - Core Firebase SDK required for all Firebase services
- **fluttertoast: ^9.0.0** - Displays non-intrusive toast notifications for user feedback
- **http: ^1.5.0** - Makes HTTP requests to fetch Pokémon data from external APIs
- **cached_network_image: ^3.4.1** - Efficiently caches and displays network images for optimal performance

## Screenshots


https://github.com/user-attachments/assets/f35afd2b-3ffe-41a4-b15e-c09580513abc




* <img width="704" height="1472" alt="poke3" src="https://github.com/user-attachments/assets/bf9445e7-524d-4cad-8c41-975de93f547a" />

  <img width="1440" height="3040" alt="Screenshot_20251018_211830" src="https://github.com/user-attachments/assets/3c626c3c-a2d9-4b48-984d-02b1fe541145" />

  <img width="1440" height="3040" alt="Screenshot_20251018_211805" src="https://github.com/user-attachments/assets/80b22c8f-a55b-4204-a023-8ca5bcea3043" />
.*

## Getting Started

### Prerequisites

- Flutter SDK: 3.0.0 or higher
- Dart SDK: 2.17.0 or higher
- Firebase account with a configured project
- Android Studio / Xcode for platform-specific development

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/AADHIX/pockeypedia.git
   ```

2. Navigate to the project directory:
   ```bash
   cd pockeypedia
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Configure Firebase:
   - Add your `google-services.json` (Android) to `android/app/`
   - Add your `GoogleService-Info.plist` (iOS) to `ios/Runner/`

### Running the Application

1. Ensure a device is connected or an emulator is running:
   ```bash
   flutter devices
   ```

2. Run the application:
   ```bash
   flutter run
   ```

3. For release build:
   ```bash
   flutter build apk --release  # For Android
   flutter build ios --release  # For iOS
   ```

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Contribution Guidelines

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

### Best Practices:

- Write clean, readable code following Dart style guidelines
- Add comments for complex logic
- Write unit tests for new features
- Update documentation for any API changes
- Follow the existing code structure and patterns
- Ensure your code passes all existing tests before submitting

### How to Contribute:

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

For bug reports and feature requests, please visit our [Issues page](https://github.com/AADHIX/pockeypedia/issues).

## Contact & Support

**Developer**: ADARSH AJAY 
- **GitHub**: [@AADHIX](https://github.com/AADHIX)
- **Email**: aadhiadarsh192001@gmail.com
- **Project Link**: [https://github.com/AADHIX/pockeypedia](https://github.com/AADHIX/pockeypedia)

### Getting Help:

- **Bug Reports**: Open an issue with the `bug` label on our [Issues page](https://github.com/AADHIX/pockeypedia/issues)
- **Feature Requests**: Submit an issue with the `enhancement` label
- **Questions**: Use the `question` label for general inquiries
- **Documentation**: Check our [Wiki](https://github.com/AADHIX/pockeypedia/wiki) for detailed guides

## License

This project is licensed under the MIT License - see the LICENSE file for details.
