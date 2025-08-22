# Flutter Starter Kit

A production-ready Flutter starter template designed to kickstart your next mobile application. This template includes essential configurations, best practices, and a well-structured architecture to help you build scalable and maintainable Flutter applications.

## 🚀 Features

- 🏗️ Clean Architecture implementation
- 🧩 BLoC pattern for state management
- 🌐 Internationalization (i18n) support
- 🎨 Custom theming with light/dark mode
- 🧪 Unit and widget testing setup
- 🏷️ Form validation with Formz
- 🎯 GoRouter for navigation
- 📱 Responsive design
- 📊 Shimmer loading effects
- 🎨 Custom fonts and icons


## 🛠️ Tech Stack

- **Framework**: Flutter 3.16+
- **State Management**: flutter_bloc & hydrated_bloc
- **Navigation**: GoRouter
- **Dependency Injection**: GetIt
- **UI**: Material Design 3, Fluent UI Icons
- **Localization**: Flutter Intl
- **Testing**: Mocktail, bloc_test

## 📦 Dependencies

Key packages included:
- `flutter_bloc` & `hydrated_bloc` - State management
- `go_router` - Declarative routing
- `get_it` - Service locator
- `formz` - Form validation
- `shimmer` - Loading placeholders
- `google_fonts` - Custom typography

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.16.0 or higher)
- Dart SDK (3.6.0 or higher)
- Android Studio / Xcode (for mobile development)
- VS Code or Android Studio (recommended IDEs)

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd my_users_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run code generation (if needed):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## 🏗 Project Structure

```
lib/
├── app/                 # Application layer
│   ├── app.dart         # Main app widget
│   ├── app_router.dart  # App routing configuration
│   └── theme/           # App theming
├── config/              # Configuration files
├── core/                # Core functionality
│   ├── constants/       # App constants
│   ├── errors/          # Error handling
│   ├── services/        # Core services
│   └── utils/           # Utility functions
├── features/            # Feature modules
│   ├── auth/            # Authentication feature
│   ├── home/            # Home feature
│   └── ...              # Other features
├── l10n/                # Localization files
└── main.dart            # App entry point
```

## 🧪 Testing

Run tests using the following commands:

- Run all tests:
  ```bash
  flutter test
  ```

- Run integration tests:
  ```bash
  flutter test integration_test/
  ```

## 🔧 Code Generation

This project uses `build_runner` for code generation. After modifying any files that require code generation, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please read our [contributing guidelines](.github/CONTRIBUTING.md) to get started.
---

Built with ❤️ using Flutter