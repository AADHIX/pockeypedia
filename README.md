# Pockey Mon

A new Flutter project.

<img width="1024" height="1024" alt="poke2" src="https://github.com/user-attachments/assets/ac225b76-4183-4809-9c5b-aacd681538ee" />

## Objective

The main objective of the Pockey Mon app is to provide a simple and intuitive interface for users to browse, search, and view details about Pokémon. The app also includes user authentication to provide a personalized experience.

## Logic

The application starts by initializing Firebase. It then checks if a user is currently logged in.

- If a user is logged in, it displays the `HomeScreen`, which shows a list of Pokémon.
- If no user is logged in, it displays the `LoginScreen`, where the user can log in or navigate to the registration screen.
- The `RegistrationScreen` allows new users to create an account.
- From the `HomeScreen`, users can tap on a Pokémon to view its details on the `PokemonDetailScreen`.

## Code Structure

The code is organized into `screens` and `widgets` directories.

- `lib/main.dart`: The entry point of the application.
- `lib/screens`: Contains the different screens of the application.
    - `home_screen.dart`: Displays the list of Pokémon.
    - `login_screen.dart`: Handles user login.
    - `registration_screen.dart`: Handles user registration.
    - `pokemon_detail_screen.dart`: Displays the details of a selected Pokémon.
- `lib/widgets`: Contains reusable widgets.
    - `button.dart`: A custom button widget.

## Packages Used

- cupertino_icons: ^1.0.8
- lottie: ^3.3.2
- cloud_firestore: ^6.0.3
- firebase_auth: ^6.1.1
- firebase_core: ^4.2.0
- fluttertoast: ^9.0.0
- http: ^1.5.0
- cached_network_image: ^3.4.1

## Screenshots

*Add screenshots here*

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Installation

1. Clone the repository: `git clone https://github.com/your_username/pockey_mon.git`
2. Navigate to the project directory: `cd pockey_mon`
3. Install dependencies: `flutter pub get`

## Usage

1. Run the app: `flutter run`

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m '''Add some AmazingFeature'''`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is not licensed.

## Contact

Your Name - your.email@example.com

Project Link: [https://github.com/your_username/pockey_mon](https://github.com/your_username/pockey_mon)
