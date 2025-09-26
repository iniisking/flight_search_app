# Flight Search App

A modern Flutter application for searching and exploring flight information with an intuitive user interface. This app integrates with the Aviation Stack API to provide real-time flight data and offers a seamless flight search experience.

## Screenshots & Demo

### Onboarding Experience

![Onboarding](assets/demo/onboarding1.gif)
_Smooth onboarding screens introducing the app features_

### Flight Search & Results

![Flight Search](assets/demo/onboarding2.gif)
_Search flights and browse through results with filter options_

### Flight Details

![Flight Details](assets/demo/onboarding3.gif)
_Detailed flight information with airline logos and schedules_

## Features

- **Modern UI/UX**: Clean and intuitive interface built with Material Design 3
- **Onboarding Flow**: Engaging introduction screens for new users
- **Flight Search**: Search flights between different airports
- **Real-time Data**: Integration with Aviation Stack API for live flight information
- **Flight Details**: Comprehensive flight information including:
  - Departure and arrival times
  - Airlines and flight numbers
  - Aircraft information
  - Flight duration
  - Airport details
- **Filter Options**: Filter flights by various criteria
- **Responsive Design**: Optimized for different screen sizes using ScreenUtil
- **State Management**: Efficient state management using Riverpod
- **Clean Architecture**: Well-structured codebase following clean architecture principles

## Tech Stack

- **Framework**: Flutter 3.9.2+
- **Language**: Dart
- **State Management**: Riverpod
- **Architecture**: Clean Architecture (Domain, Data, Presentation layers)
- **API Integration**: Aviation Stack API
- **UI Components**: Material Design 3
- **Responsive Design**: Flutter ScreenUtil
- **Icons & Images**: Flutter SVG, Cached Network Image
- **Environment Management**: Flutter Dotenv
- **Asset Generation**: Flutter Gen

## Prerequisites

Before running this project, make sure you have:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.9.2 or higher)
- [Dart SDK](https://dart.dev/get-dart) (3.0.0 or higher)
- An IDE (VS Code, Android Studio, or IntelliJ IDEA)
- Android Studio (for Android development)
- Xcode (for iOS development, macOS only)
- A valid Aviation Stack API key

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/iniisking/flight_search_app.git
cd flight_search_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Environment Setup

1. **Copy the environment template:**

   ```bash
   cp .env.example .env
   ```

2. **Get your Aviation Stack API key:**

   - Visit [Aviation Stack](https://aviationstack.com/)
   - Sign up for a free account
   - Get your API key from the dashboard

3. **Update the `.env` file:**
   ```env
   AVIATION_STACK_API_KEY=your_actual_api_key_here
   AVIATION_STACK_BASE_URL=http://api.aviationstack.com/v1
   ```

### 4. Generate Assets

Generate asset references and other build files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

For automatic rebuilding when assets change:

```bash
dart run build_runner watch
```

### 5. Run the App

```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── core/                             # Core functionality
│   ├── constants/                    # App constants
│   ├── errors/                       # Error handling
│   ├── network/                      # Network layer (DioClient)
│   ├── utils/                        # Utility functions
│   └── widgets/                      # Reusable widgets
├── features/
│   └── flight search/               # Flight search feature
│       ├── data/                    # Data layer
│       │   ├── models/              # Data models
│       │   └── repositories/        # Repository implementations
│       ├── domain/                  # Domain layer
│       │   ├── entities/            # Business entities
│       │   ├── repositories/        # Repository interfaces
│       │   └── use_cases/           # Business logic
│       └── presentation/            # Presentation layer
│           ├── pages/               # App screens
│           ├── providers/           # Riverpod providers
│           ├── state/               # State management
│           └── widgets/             # UI components
└── gen/                             # Generated files
    └── assets.gen.dart              # Asset references
```

## 🔧 Development

### Running Tests

```bash
flutter test
```

### Building for Production

**Android:**

```bash
flutter build apk --release
```

**iOS:**

```bash
flutter build ios --release
```

### Code Generation

When adding new assets or making changes that require code generation:

```bash
flutter packages pub run build_runner build
```

## Dependencies

### Main Dependencies

- `flutter`: Flutter framework
- `flutter_riverpod`: State management
- `http`: HTTP client for API calls
- `flutter_dotenv`: Environment variable management
- `flutter_screenutil`: Responsive design
- `flutter_svg`: SVG support
- `cached_network_image`: Image caching
- `intl`: Internationalization
- `shared_preferences`: Local storage

### Dev Dependencies

- `flutter_test`: Testing framework
- `flutter_lints`: Linting rules
- `build_runner`: Code generation
- `flutter_gen_runner`: Asset generation

## 🔐 Security Notes

- The `.env` file containing API keys is excluded from version control
- Never commit sensitive information like API keys to the repository
- Use the `.env.example` file as a template for required environment variables

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you have any questions or need help with the project, please:

1. Check the [Issues](https://github.com/iniisking/flight_search_app/issues) page
2. Create a new issue if your problem isn't already addressed
3. Provide detailed information about your problem including:
   - Flutter version
   - Device/platform information
   - Steps to reproduce the issue

## Acknowledgments

- [Aviation Stack API](https://aviationstack.com/) for providing flight data
- [Flutter](https://flutter.dev/) team for the amazing framework
- [Riverpod](https://riverpod.dev/) for state management solution

---

Made with ❤️ by [iniisking](https://github.com/iniisking)
