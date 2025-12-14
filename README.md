# Pizza Panic 🍕

Pizza delivery tracking app for **Mamma Mia's Pizza Palace** - helping save their delivery operations from chaos!

> **Built for**: Flutter Technical Assessment  
> **Time Budget**: 3-4 hours  
> **Completion Time**: ~3.5 hours

## 📱 About

A Flutter mobile app that helps track pizza orders in real-time, grouped by delivery status (Preparing → On the Way → Delivered). Built to demonstrate clean architecture, modern Flutter practices, and efficient state management.

---

## ✨ Features Implemented

### Core Requirements ✅

-   ✅ **Order Management Screen**

    -   List of pizza orders with network images
    -   Grouped by status: 🟠 Preparing, 🔵 On the Way, 🟢 Delivered
    -   Display order ID, customer name, pizza types, and status
    -   Pull-to-refresh functionality
    -   Order count badges per status

-   ✅ **Order Details**

    -   Hero pizza image with gradient overlay
    -   Visual delivery stepper (4 stages with animations)
    -   Tap any order to view full details
    -   Update status to next stage with confirmation
    -   Immediate optimistic UI updates
    -   Success feedback with SnackBar

-   ✅ **Technical Excellence**
    -   Riverpod for state management (with built-in DI)
    -   Loading states with CircularProgressIndicator
    -   Error states with retry functionality
    -   Implicit animations (AnimatedContainer, AnimatedSwitcher, AnimatedDefaultTextStyle)
    -   Clean, maintainable code structure

### Bonus Features ✅

-   ✅ **Material 3 Design System**
    -   ColorScheme with seed colors
    -   Proper elevation and surface tints
    -   Theme-aware components
-   ✅ **Advanced Riverpod Patterns**

    -   StateNotifier for complex state
    -   FutureProvider.family for single items
    -   Provider.family for filtered data
    -   Optimistic UI updates
    -   Provider invalidation for refresh

-   ✅ **Modern Dart Features**

    -   Enhanced enums with methods (OrderStatus, PizzaSize)
    -   Extension methods (DateTime formatting)
    -   Null safety throughout
    -   Immutable entities

-   ✅ **Project Hygiene**
    -   Comprehensive linting rules
    -   `.gitignore` for generated files
    -   Feature-first architecture
    -   Consistent code formatting

### Extra Polish ✨

-   🌙 **Dark mode support** with theme toggle
-   🖼️ **Network pizza images** with loading/error states
-   🎨 **Hero image** in details view with custom AppBar
-   📱 **iOS & Android** permissions configured
-   ⚡ **Optimistic updates** for smooth UX
-   🎭 **Empty states** for better UX

---

## 🏗️ Architecture & Design Decisions

### Architecture Pattern

**Feature-First + Clean Architecture** (simplified for time constraint)

```
lib/
├── core/                    # App-wide configuration
│   ├── constants/          # Colors, spacing, app constants
│   └── theme/              # Material 3 themes, theme provider
├── features/               # Feature modules (orders)
│   └── orders/
│       ├── data/           # Data layer (models, datasources, repos)
│       ├── domain/         # Business logic (entities, repo interfaces)
│       └── presentation/   # UI layer (screens, widgets, providers)
├── shared/                 # Shared utilities
│   ├── extensions/         # Dart extensions (DateTime)
│   └── widgets/            # Reusable widgets (loading, error)
└── main.dart               # App entry point
```

### Implementation Highlights

**Riverpod State Management**  
Single source of truth for state across the app. StateNotifier for complex order state, FutureProvider.family for individual orders, Provider.family for filtered views. Optimistic updates with provider invalidation.

**Feature-First Structure**  
Each feature is self-contained with data, domain, and presentation layers. Easy to navigate, test, and extend. Clear boundaries between features.

**Type-Safe Everything**  
Enhanced enums with methods, immutable entities, null safety throughout. Compile-time safety prevents runtime errors. Extension methods add functionality cleanly.

**Material 3 Design**  
ColorScheme.fromSeed for automatic color generation. Theme-aware components adapt to light/dark mode. Proper elevation and surface tints. No hardcoded colors or text styles.

**Efficient Data Flow**  
JSON → Model → Entity separation. Clean conversion at boundaries. In-memory caching for performance. Repository interface allows easy backend integration.

**Professional Polish**  
Smooth implicit animations throughout. Loading and error states handled gracefully. Empty states with helpful messaging. Pull-to-refresh functionality. Network images with fallbacks.

---

## 🚀 Getting Started

### Prerequisites

-   Flutter SDK **3.6.0** or higher
-   Dart SDK **3.0.0** or higher
-   iOS/Android device or emulator

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/RiyaPatel7102/pizza_panic.git
cd pizza_panic
```

2. **Get dependencies**

```bash
flutter pub get
```

3. **Run the app**

```bash
# Development
flutter run

# Release mode
flutter run --release
```

### Quick Test

```bash
# Pull down to refresh orders
# Tap any order to see details
# Tap "Mark as [Next Status]" to update
# Toggle theme with switch in AppBar
```

---

## 📦 Build & Deploy

### Debug APK

```bash
flutter build apk --debug
# Output: build/app/outputs/flutter-apk/app-debug.apk
```

### Release APK

```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS Build

```bash
flutter build ios --release
```

---

## ⏱️ Time Breakdown

**Total Time: ~3.5 hours**

| Phase                    | Time    | Details                                            |
| ------------------------ | ------- | -------------------------------------------------- |
| **Setup & Architecture** | 30 min  | Project structure, dependencies, core files        |
| **Core Features**        | 2 hours | Orders list, details, state management, data layer |
| **UI/UX Polish**         | 45 min  | Animations, stepper, Material 3 theming, images    |
| **Quality Assurance**    | 15 min  | Manual validation, bug fixes, polish               |

---

## 🎯 Technical Decisions & Assumptions

### Architecture Decisions

**Riverpod for Everything**  
Unified state management and dependency injection. Type-safe, compile-time checked, eliminates service locator pattern complexity. Single system provides DI, state management, and caching.

**Pragmatic Clean Architecture**  
Repository pattern with direct business logic. Clean separation of concerns without use case layer overhead. Maintains testability and scalability while optimizing for development speed.

**Type-Safe Domain Model**  
Enhanced enums (OrderStatus, PizzaSize) with helper methods. Immutable entities prevent bugs. Extension methods (DateTime) add functionality without cluttering models.

**Local-First Data**  
In-memory caching with mock JSON. Fast loading, realistic data flow. Repository interface supports easy swap to remote API or local database.

**Implicit Animations**  
Flutter's built-in animated widgets (AnimatedContainer, AnimatedSwitcher, AnimatedDefaultTextStyle). Professional feel without custom animation controllers. Smooth transitions with minimal code.

**Manual Model Management**  
Explicit model definitions and conversions. Full control over serialization. Clear, readable code without code generation complexity.

**Material 3 Design System**  
Theme-based styling throughout. ColorScheme with seed colors, proper elevation. Automatic dark mode support. Professional appearance with consistency.

### Project Assumptions

1. **Linear Order Flow** - Orders progress sequentially (Preparing → On the Way → Delivered)
2. **Single Restaurant Context** - All orders managed from one location
3. **Network Connectivity** - Internet available for pizza images (graceful fallbacks included)
4. **Demo Data** - Fixed timestamps and customer data for demonstration
5. **Open Access** - No authentication layer (focus on core functionality)
6. **Forward-Only Updates** - Orders can only advance, not reverse status

---

## 📚 Dependencies

### Production

-   `flutter_riverpod: ^2.4.9` - State management + DI
-   `intl: ^0.19.0` - Date/time formatting
-   `cupertino_icons: ^1.0.8` - iOS-style icons

### Development

-   `flutter_lints: ^5.0.0` - Strict linting rules

**Total**: 3 production deps (minimal, intentional)

---

## 🎨 Design System

### Color Palette

-   **Primary**: Orange/Coral (#FF6B35) - Pizza theme!
-   **Success**: Green (#4CAF50) - Delivered
-   **Warning**: Orange (#FF9800) - Preparing
-   **Info**: Blue (#2196F3) - On the way

### Typography

-   Material 3 text styles throughout
-   No hardcoded font sizes
-   Theme-aware for dark mode

### Spacing Scale

```dart
xs: 4px, sm: 8px, md: 16px, lg: 24px, xl: 32px, xxl: 40px
```

---

## 🎯 Project Scope

This prototype focuses on core order tracking functionality:

-   ✅ Real-time order status management with optimistic updates
-   ✅ Visual delivery progress tracking with animated stepper
-   ✅ Clean, maintainable architecture with clear separation
-   ✅ Material 3 design implementation with dark mode
-   ✅ Network images with loading/error states
-   ✅ Smooth animations and professional polish
-   ✅ Pull-to-refresh and empty state handling

Built as a **working prototype** demonstrating production-ready patterns and practices.

---

## 🚀 Scalability & Extension Points

The architecture supports future enhancements:

**Search & Filtering**  
Provider pattern ready for search state. OrdersNotifier already supports filtering by status - extensible to any criteria.

**Real-time Updates**  
Repository interface designed for backend swap. Can easily integrate WebSocket, Firebase, or GraphQL subscriptions.

**Push Notifications**  
State management handles background updates. Provider invalidation triggers UI refresh when notifications arrive.

**Offline Support**  
Data layer structured for persistence. Repository pattern abstracts storage - can add Hive, SQLite, or shared preferences.

**Multi-tenant**  
Feature-first structure scales to multiple restaurants. Add restaurant ID filtering without restructuring.

**Analytics Integration**  
Provider pattern allows easy interceptor addition. Track order views, status changes, and user interactions.

**Authentication**  
Add auth provider to Riverpod tree. Protect routes with auth guards. Repository can inject auth tokens.

_Architecture designed for growth while keeping current scope focused._

---

## 📄 Code Quality

### Linting

-   ✅ Strict analysis_options.yaml
-   ✅ All lints passing
-   ✅ Consistent formatting

### Best Practices

-   ✅ Immutable entities
-   ✅ Const constructors where possible
-   ✅ Proper error handling
-   ✅ Type safety throughout
-   ✅ Single Responsibility Principle
-   ✅ DRY (Don't Repeat Yourself)

---

## 📝 Git Workflow

Followed **Git Flow** with feature branches:

```
main (production)
  ├─ development (integration)
     ├─ feature/project-setup
     ├─ feature/mock-data-json
     ├─ feature/core-theme
     ├─ feature/order-data-layer
     ├─ feature/riverpod-providers
     ├─ feature/orders-list-screen
     └─ feature/order-details-polish
```

Clean commit history with conventional commits.

---

## 🤝 Deliverables Checklist

-   ✅ Public GitHub repository
-   ✅ Clean commit history (feature branches)
-   ✅ README.md with all required sections
-   ✅ Release APK (`build/app/outputs/flutter-apk/`)
-   ✅ Working features within time constraint
-   ✅ Clean, documented code
-   ✅ Material 3 design system
-   ✅ Advanced Riverpod patterns
-   ✅ Manually tested and verified

---

## 👤 Author

Riya Patel  
Email: riya.patel.flutter@gmail.com  
GitHub: [@RiyaPatel7102](https://github.com/RiyaPatel7102)

---

## 📧 Submission

**Submitted to**: teams@flysoft.eu  
**Date**: December 14, 2025  
**Repository**: https://github.com/RiyaPatel7102/pizza_panic  
**APK**: [Link to APK or included in release]

---

## 🙏 Acknowledgments

Built as part of a technical assessment for demonstrating:

-   Flutter expertise
-   Clean architecture
-   State management mastery
-   UI/UX attention to detail
-   Time management
-   Problem-solving approach

---

**Thank you for reviewing! 🍕✨**

_"Making pizza delivery chaos a thing of the past, one order at a time!"_
