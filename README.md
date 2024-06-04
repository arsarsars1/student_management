# Student Management App using Flutter BLoC & Hive

This Flutter application demonstrates the use of the BLoC (Business Logic Component) pattern for state management and Hive for local data storage. The application includes features such as user authentication, batch management, contact selection, and scheduling.

## Features

1. **User Authentication**:
    - Login with email and password.
    - Logout functionality.
    - Persistent login state across app restarts.

2. **Batch Management**:
    - Add new batches with details such as batch name, course, subject, admission fee, fees, status, email, and students.
    - List existing batches from local storage.
    - View batch details.

3. **Contact Selection**:
    - Load contacts from the device.
    - Search and select contacts to add to a batch.

4. **Schedule Management**:
    - Add schedules for batches with start and end times for each day of the week.
    - Ensure the start time is before the end time.

## Dependencies

The project uses the following dependencies:

- [flutter_bloc](https://pub.dev/packages/flutter_bloc): State management library.
- [hive](https://pub.dev/packages/hive): Lightweight and blazing fast key-value database.
- [hive_flutter](https://pub.dev/packages/hive_flutter): Flutter adapters for Hive.
- [contacts_service](https://pub.dev/packages/contacts_service): A Flutter plugin to access and manage contacts.
- [permission_handler](https://pub.dev/packages/permission_handler): A Flutter plugin for handling permissions.

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter

### Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/flutter-bloc-hive-example.git
   cd flutter-bloc-hive-example
   ```

2. Install dependencies:
   ```sh
   flutter pub get
   ```

3. Generate Hive adapters:
   ```sh
   flutter packages pub run build_runner build
   ```

4. Run the application:
   ```sh
   flutter run
   ```

## Project Structure

- `lib/`
    - `blocs/`: Contains BLoC files for managing the state of different features.
        - `auth/`: Authentication BLoC.
        - `batch/`: Batch management BLoC.
    - `models/`: Data models used in the application.
    - `repositories/`: Repository classes for interacting with Hive database.
    - `screens/`: UI screens for the application.
    - `utils/`: Utility files including dependency injection setup.
    - `widgets/`: Reusable widgets.

## Key Files

### Authentication

- `auth_bloc.dart`
- `auth_event.dart`
- `auth_state.dart`
- `auth_repository.dart`

### Batch Management

- `batch_bloc.dart`
- `batch_event.dart`
- `batch_state.dart`
- `batch_repository.dart`

### UI Screens

- `login_screen.dart`: Login screen.
- `home_screen.dart`: Home screen with navigation to other features.
- `batch_list_screen.dart`: List of batches.
- `add_batch_screen.dart`: Form to add a new batch.
- `add_contacts_screen.dart`: Screen to add contacts to a batch.

### Widgets

- `contact_widget.dart`: Widget to display selected contacts.

## Usage

### Authentication

- On app startup, the authentication state is checked.
- If the user is authenticated, they are navigated to the home screen.
- If not, they are taken to the login screen.
- The user can log out from the home screen, which will take them back to the login screen.

### Batch Management

- The home screen displays options to manage batches.
- Users can add a new batch, which involves filling out a form with batch details.
- Users can view existing batches and their details.

### Contact Selection

- While adding a new batch, users can select contacts from their device.
- The selected contacts are displayed and can be added to the batch.

### Schedule Management

- Users can add a schedule for each day of the week while adding a batch.
- The schedule ensures the start time is before the end time.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
