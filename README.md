# Pizza Panic 🍕

Pizza delivery tracking app for Mamma Mia's Pizza Palace.

## 📱 About

A Flutter mobile app that helps track pizza orders in real-time, grouped by delivery status. Built as part of a technical assessment showcasing clean architecture and modern Flutter practices.

## ✨ Features

-   📋 Order list with status grouping (Preparing, On the Way, Delivered)
-   🔍 Detailed order view
-   🚀 Status update with visual stepper
-   🔄 Pull-to-refresh functionality
-   🎨 Material 3 design system
-   🌙 Dark mode support

## 🏗️ Architecture

-   **Pattern**: Feature-First + Clean Architecture
-   **State Management**: Riverpod (with built-in DI)
-   **Design System**: Material 3

### Project Structure

```
lib/
├── core/           # App-wide configuration
├── features/       # Feature modules
├── shared/         # Shared widgets/utilities
└── main.dart       # Entry point
```

## 🚀 Getting Started

### Prerequisites

-   Flutter SDK 3.6.0 or higher
-   Dart SDK 3.0.0 or higher

### Installation

1. Clone the repository

```bash
git clone <repository-url>
cd pizza_panic
```

2. Get dependencies

```bash
flutter pub get
```

3. Run the app

```bash
flutter run
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## 📦 Build

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release
```

## 🏛️ Architecture Decisions

See [rules.md](rules.md) for detailed architecture guidelines.

### Key Decisions:

1. **Riverpod-only DI** - Simplified dependency injection without GetIt/Injectable
2. **No use cases layer** - Repository contains business logic (pragmatic for 3-4 hours)
3. **Simple error handling** - No Dartz/Either, using try-catch
4. **Mock JSON data** - Local data source for prototype

## ⏱️ Time Spent

-   Setup & Architecture: [X] minutes
-   Core Features: [X] minutes
-   UI/UX Polish: [X] minutes
-   Testing: [X] minutes
-   **Total**: [X] hours

## 🔄 Trade-offs Made

1. **Simplified architecture** - Skipped use cases layer to save time
2. **Basic testing** - Focused on provider/notifier tests only
3. **Mock data only** - No remote API integration
4. **Limited animations** - Focused on implicit animations for time efficiency

## 📄 License

This project is for assessment purposes.

## 👤 Author

[Your Name]
