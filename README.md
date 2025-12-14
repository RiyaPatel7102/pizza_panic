# Pizza Panic 🍕

Pizza delivery tracking app for **Mamma Mia's Pizza Palace** - helping save their delivery operations from chaos!

> **Built for**: Flutter Technical Assessment  
> **Time Budget**: 3-4 hours  
> **Completion Time**: ~3.5 hours

## 📱 About

A Flutter mobile app that helps track pizza orders in real-time with an intuitive tabbed interface. Features Material 3 design, smooth animations, and efficient state management with Riverpod.

---

## ✨ Features Implemented

### Core Requirements ✅

-   ✅ **Modern Tabbed Interface**

    -   Three tabs for order statuses: 🟠 Preparing, 🔵 On the Way, 🟢 Delivered
    -   Color-coded tab indicators matching status chips
    -   Order count badges per tab
    -   Smooth tab transitions with animations
    -   Independent pull-to-refresh per tab

-   ✅ **Beautiful Order Cards**

    -   Large hero pizza image at top (180px height)
    -   Order ID as primary title (bold, prominent)
    -   Pizza name as subtitle with smart pluralization
    -   Three info badges: Customer, Pizza Count, Address
    -   Status chip overlay with semi-transparent background
    -   Elevated cards with theme-aware borders and shadows

-   ✅ **Order Details Screen**

    -   Full-screen hero pizza image with gradient overlay
    -   Interactive delivery stepper (4 stages with animations)
    -   Tap any order to view complete details
    -   Update status to next stage with one tap
    -   Optimistic UI updates for instant feedback
    -   Success confirmation with themed SnackBar

-   ✅ **Technical Excellence**
    -   Riverpod for state management with built-in DI
    -   Loading states with progress indicators
    -   Error states with retry functionality
    -   Implicit animations throughout (AnimatedContainer, AnimatedSwitcher, AnimatedDefaultTextStyle)
    -   Clean, maintainable architecture

### Bonus Features ✅

-   ✅ **Material 3 Design System**

    -   ColorScheme with seed colors and automatic palette generation
    -   Proper elevation and surface tints
    -   Theme-aware components adapting to light/dark mode
    -   Consistent spacing and typography scale

-   ✅ **Advanced Riverpod Patterns**

    -   StateNotifier for complex order state management
    -   FutureProvider.family for individual order fetching
    -   Provider.family for filtered data by status
    -   Optimistic UI updates with automatic rollback
    -   Provider invalidation for pull-to-refresh

-   ✅ **Modern Dart Features**

    -   Enhanced enums with methods and helpers (OrderStatus, PizzaSize)
    -   Extension methods for clean DateTime formatting
    -   Null safety throughout the codebase
    -   Immutable entities preventing state mutations
    -   Type-safe model conversions

-   ✅ **Project Hygiene**
    -   Comprehensive linting rules (flutter_lints)
    -   `.gitignore` for generated files
    -   Feature-first architecture
    -   Consistent code formatting
    -   Clean Git history with feature branches

### Extra Polish ✨

-   🌙 **Dark mode support** with theme toggle switch in AppBar
-   🖼️ **Network pizza images** with loading/error states and placeholders
-   🎨 **Hero animations** transitioning from list to detail view
-   📱 **iOS & Android** permissions configured for network access
-   ⚡ **Optimistic updates** for smooth user experience
-   🎭 **Smart empty states** with status-specific messages per tab
-   🔄 **Edge-to-edge display** with hidden navigation bar (Android)
-   🎯 **Status chip visibility** on any image color with semi-transparent background

---

## 🏗️ Architecture & Design Decisions

### Architecture Pattern

**Feature-First + Clean Architecture** (pragmatic approach optimized for time constraint)

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
│           ├── providers/  # Riverpod state providers
│           ├── screens/    # Full-screen views (list, details)
│           └── widgets/    # Reusable UI components (cards, chips, tabs)
├── shared/                 # Shared utilities
│   ├── extensions/         # Dart extensions (DateTime)
│   └── widgets/            # Reusable widgets (loading, error, empty)
└── main.dart               # App entry point with system UI config
```

### Implementation Highlights

**Tabbed Navigation**  
Clean separation of order statuses with independent scrolling and refresh per tab. Color-coded indicators matching status chips for instant visual recognition. Empty states customized per tab with contextual messaging.

**Card Design System**  
Hero image at top for immediate visual impact. Order ID as bold title for clear identification. Smart subtitle showing pizza names with pluralization. Three colored badges for key information at a glance. Status chip overlay always visible with semi-transparent background.

**Riverpod State Management**  
Single source of truth for app state. StateNotifier manages complex order operations with optimistic updates. FutureProvider.family fetches individual orders efficiently. Provider.family filters orders by status with automatic reactivity.

**Feature-First Structure**  
Each feature is self-contained with clear layer separation. Easy navigation and testing. Boundaries prevent tight coupling. Scales naturally as new features are added.

**Type-Safe Everything**  
Enhanced enums with helper methods for business logic. Immutable entities prevent accidental mutations. Null safety eliminates entire classes of bugs. Extension methods add functionality without cluttering models.

**Material 3 Design**  
ColorScheme.fromSeed generates harmonious palette automatically. Theme-aware components adapt seamlessly to light/dark mode. Proper elevation creates visual hierarchy. Surface tints add depth and dimension.

**Efficient Data Flow**  
Clean conversion: JSON → Model → Entity at boundaries. In-memory caching for instant loading. Repository interface abstracts data source for easy backend integration.

**Professional Polish**  
Smooth implicit animations for delightful interactions. Loading and error states handled gracefully. Empty states with helpful, contextual messaging. Pull-to-refresh works independently per tab. Network images with loading indicators and fallbacks.

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
# Switch between tabs to see orders by status
# Pull down in any tab to refresh
# Tap any order card to see full details
# Tap "Mark as [Next Status]" button to update
# Toggle theme with switch in AppBar (moon/sun icon)
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

| Phase                    | Time    | Details                                                   |
| ------------------------ | ------- | --------------------------------------------------------- |
| **Setup & Architecture** | 30 min  | Project structure, dependencies, core theme configuration |
| **Core Features**        | 2 hours | Orders list, details view, state management, data layer   |
| **UI/UX Polish**         | 45 min  | Animations, stepper, Material 3 theming, network images   |
| **Quality Assurance**    | 15 min  | Bug fixes, edge cases, tabbed interface, final polish     |

---

## 🎯 Technical Decisions & Assumptions

### Architecture Decisions

**Riverpod for Everything**  
Unified solution for state management and dependency injection. Type-safe and compile-time checked. Eliminates service locator complexity. Single system handles DI, state management, and caching efficiently.

**Pragmatic Clean Architecture**  
Repository pattern with direct business logic in entities. Clean separation without use case layer overhead. Maintains testability and scalability while optimizing for development velocity within time constraint.

**Tabbed Interface Over Nested Lists**  
Better organization and navigation for status-based filtering. Independent scrolling and pull-to-refresh per tab. Reduces scrolling fatigue. Color-coded tabs match status chips for instant recognition.

**Card-First Design**  
Hero image creates immediate visual impact and brand consistency. Order ID as title emphasizes tracking. Smart badges surface key information efficiently. Status chip overlay always visible regardless of image colors.

**Type-Safe Domain Model**  
Enhanced enums (OrderStatus, PizzaSize) with methods eliminate magic strings. Immutable entities prevent mutation bugs. Extension methods (DateTime) add functionality cleanly without model clutter.

**Local-First Data**  
In-memory caching with JSON mock data. Fast initial loading with realistic data flow. Repository interface supports seamless swap to remote API or local database.

**Implicit Animations**  
Flutter's built-in animated widgets provide professional feel without complexity. Smooth transitions with minimal code overhead. AnimatedContainer, AnimatedSwitcher, AnimatedDefaultTextStyle used throughout.

**Manual Model Management**  
Explicit model definitions and conversions provide full control. Clear, readable serialization logic. Avoids code generation complexity for this project scope.

**Material 3 Design System**  
Theme-based styling eliminates hardcoded values. ColorScheme with seed colors ensures harmony. Proper elevation and surface tints create depth. Automatic dark mode support.

### Project Assumptions

1. **Linear Order Flow** - Orders progress sequentially through statuses (no backwards movement)
2. **Single Restaurant Context** - All orders managed from one centralized location
3. **Network Connectivity** - Internet available for pizza images (graceful fallbacks included)
4. **Demo Data** - Fixed timestamps and customer data for realistic demonstration
5. **Open Access** - No authentication layer (focus on core order management)
6. **Forward-Only Updates** - Orders advance only, status cannot be reversed
7. **Single Currency** - All prices in USD with $ symbol
8. **English Language** - UI and data in English only

---

## 📚 Dependencies

### Production

-   `flutter_riverpod: ^2.4.9` - State management + dependency injection
-   `intl: ^0.19.0` - Date/time formatting and localization
-   `cupertino_icons: ^1.0.8` - iOS-style icons

### Development

-   `flutter_lints: ^5.0.0` - Strict linting rules and code quality

**Total**: 3 production dependencies (minimal, intentional choices)

---

## 🎨 Design System

### Color Palette

**Status Colors (Requirement-based):**

-   🟠 **Preparing**: Orange (#F77F00) - Warm, active cooking
-   🔵 **On the Way**: Blue (#3A86FF) - Motion, in transit
-   🟢 **Delivered**: Green (#06D6A0) - Success, completion

**Brand Colors:**

-   **Primary**: Pizza Red/Orange (#FF6B35) - Brand identity
-   **Secondary**: Deep Navy (#004E89) - Professional contrast

**Semantic Colors:**

-   **Success**: Teal (#2A9D8F)
-   **Warning**: Orange (#F77F00)
-   **Error**: Red (#E63946)
-   **Info**: Blue (#3A86FF)

### Typography Scale

Material 3 text styles used throughout:

-   **Display**: 57px, 45px, 36px (rare usage)
-   **Headline**: 32px, 28px, 24px (section headers)
-   **Title**: 22px, 16px, 14px (card titles)
-   **Body**: 16px, 14px, 12px (content text)
-   **Label**: 14px, 12px, 11px (buttons, badges)

No hardcoded font sizes - all theme-aware for consistency.

### Spacing Scale (8px Grid)

```dart
xs: 4px   // Tight spacing, icon padding
sm: 8px   // Small gaps, chip padding
md: 16px  // Standard padding, card margins
lg: 24px  // Section spacing
xl: 32px  // Large separators
xxl: 48px // Major sections
```

### Border Radius Scale

```dart
sm: 8px   // Small elements
md: 12px  // Cards, buttons
lg: 16px  // Large cards
xl: 20px  // Special elements
circular: 999px  // Pills, circular badges
```

---

## 🎯 Project Scope

This prototype focuses on core order tracking functionality:

-   ✅ **Tabbed order management** with status-based organization
-   ✅ **Visual card design** with hero images and smart layouts
-   ✅ **Real-time status updates** with optimistic UI feedback
-   ✅ **Animated delivery stepper** showing progress visually
-   ✅ **Clean architecture** with clear layer separation
-   ✅ **Material 3 design** with comprehensive dark mode support
-   ✅ **Network images** with loading states and error handling
-   ✅ **Smooth animations** for professional feel
-   ✅ **Pull-to-refresh** working independently per tab
-   ✅ **Empty states** with contextual, helpful messaging

Built as a **working prototype** demonstrating production-ready patterns, best practices, and attention to detail.

---

## 🚀 Scalability & Extension Points

The architecture supports future enhancements:

**Search & Filtering**  
Provider pattern ready for search state. OrdersNotifier filters by status - easily extensible to search by customer name, order ID, pizza type, or date range.

**Real-time Updates**  
Repository interface designed for backend integration. Can swap to WebSocket connections, Firebase Realtime Database, or GraphQL subscriptions without changing presentation layer.

**Push Notifications**  
State management handles background updates naturally. Provider invalidation triggers automatic UI refresh when push notifications arrive.

**Offline Support**  
Data layer structured for local persistence. Repository pattern abstracts storage - add Hive, SQLite, or shared preferences without affecting business logic.

**Multi-tenant**  
Feature-first structure scales to multiple restaurants. Add restaurant ID filtering at provider level. UI components remain unchanged.

**Analytics Integration**  
Provider pattern allows easy event tracking. Monitor order views, status changes, tab switches, and user interactions for insights.

**Authentication & Authorization**  
Add auth provider to Riverpod tree. Protect routes with auth guards. Repository injects auth tokens automatically. Role-based access control for status updates.

**Payment Integration**  
Order entity ready for payment status. Add payment provider. Integrate Stripe, PayPal, or other payment gateways at data layer.

_Architecture designed for sustainable growth while keeping current scope focused and deliverable._

---

## 📄 Code Quality

### Linting

-   ✅ Strict analysis_options.yaml with flutter_lints
-   ✅ All lint rules passing (0 warnings, 0 errors)
-   ✅ Consistent code formatting with dartfmt
-   ✅ Generated files excluded from analysis

### Best Practices

-   ✅ Immutable entities prevent state mutations
-   ✅ Const constructors used where possible for performance
-   ✅ Proper error handling with try-catch and AsyncValue
-   ✅ Type safety throughout (no dynamic, no any)
-   ✅ Single Responsibility Principle per class
-   ✅ DRY (Don't Repeat Yourself) with shared widgets
-   ✅ Meaningful names for variables and functions
-   ✅ Comments for complex business logic

### UI/UX Quality

-   ✅ Consistent spacing using design tokens
-   ✅ Theme-aware colors (no hardcoded hex values in widgets)
-   ✅ Loading states for better perceived performance
-   ✅ Error states with retry actions
-   ✅ Empty states with helpful guidance
-   ✅ Smooth animations for professional feel
-   ✅ Accessibility: proper semantic labels
-   ✅ Touch targets meet minimum size (48x48dp)

---

## 📝 Git Workflow

Followed **Gitflow** methodology with feature branches:

```
main (production-ready)
  └─ development (integration)
       ├─ feature/project-setup
       ├─ feature/mock-data-json
       ├─ feature/core-theme
       ├─ feature/order-domain
       ├─ feature/order-data-layer
       ├─ feature/riverpod-providers
       ├─ feature/orders-list-screen
       ├─ feature/order-details-polish
       └─ feature/tabbed-interface
```

Clean commit history with descriptive conventional commit messages.

---

## 🤝 Deliverables Checklist

-   ✅ Public GitHub repository with clean history
-   ✅ Feature branches following Gitflow
-   ✅ Comprehensive README.md with all sections
-   ✅ Release APK (`build/app/outputs/flutter-apk/`)
-   ✅ All core requirements completed within time budget
-   ✅ Bonus features implemented (Material 3, advanced Riverpod)
-   ✅ Clean, well-documented code
-   ✅ Lint-free codebase
-   ✅ Manually tested on iOS and Android
-   ✅ Dark mode support throughout
-   ✅ Network images with proper error handling
-   ✅ Smooth animations and transitions
-   ✅ Professional UI/UX polish

---

## 👤 Author

**Riya Patel**  
Email: riya.patel.flutter@gmail.com  
GitHub: [@RiyaPatel7102](https://github.com/RiyaPatel7102)  
LinkedIn: [Riya Patel](https://linkedin.com/in/riyapatel)

---

## 📧 Submission

**Submitted to**: teams@flysoft.eu  
**Date**: December 14, 2025  
**Repository**: https://github.com/RiyaPatel7102/pizza_panic  
**APK**: Included in GitHub releases

---

## 🙏 Acknowledgments

Built as part of a technical assessment to demonstrate:

-   ✅ Flutter expertise and modern best practices
-   ✅ Clean architecture and separation of concerns
-   ✅ Advanced state management with Riverpod
-   ✅ Material 3 design system implementation
-   ✅ UI/UX attention to detail and polish
-   ✅ Time management and prioritization
-   ✅ Problem-solving approach and decision-making
-   ✅ Code quality and maintainability focus

---

**Thank you for reviewing! 🍕✨**

_"Making pizza delivery chaos a thing of the past, one order at a time!"_
