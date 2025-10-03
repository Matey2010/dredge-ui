# Dredge UI

A comprehensive Flutter package providing reusable UI widgets, state management providers, and utilities for the Dredge project. Built with Material Design principles and optimized for cross-platform Flutter applications.

## Features

- **Rich Widget Library** - Pre-built, customizable UI components
- **State Management** - Provider-based modal, toast, and dialog management
- **WebView Integration** - Embedded web content with `flutter_inappwebview`
- **Type-Safe Models** - Structured data models for consistency
- **Utility Functions** - Common helpers for UI development

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  dredge_ui: ^0.0.1
```

Or for local development:

```yaml
dependencies:
  dredge_ui:
    path: packages/dredge_ui
```

Then run:

```bash
flutter pub get
```

## Usage

### Setup Providers

Wrap your app with the required providers:

```dart
import 'package:dredge_ui/providers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModalProvider()),
        ChangeNotifierProvider(create: (_) => ToastProvider()),
        ChangeNotifierProvider(create: (_) => DialogProvider()),
      ],
      child: MyApp(),
    ),
  );
}
```

### Using Widgets

#### Input with Animated Label

```dart
import 'package:dredge_ui/widgets.dart';

Input(
  label: 'Email',
  keyboardType: TextInputType.emailAddress,
  onChange: (value) => print(value),
)
```

The `Input` widget features an animated floating label that transitions when focused or filled.

#### Button

```dart
import 'package:dredge_ui/widgets.dart';

DredgeButton(
  text: 'Submit',
  icon: Icon(Icons.send),
  onTap: () => print('Clicked'),
  backgroundColor: Colors.blue,
  foregroundColor: Colors.white,
)
```

#### Modal System

The modal system uses a stack-based approach for managing multiple modals:

```dart
import 'package:dredge_ui/widgets.dart';
import 'package:dredge_ui/providers.dart';
import 'package:provider/provider.dart';

// Open a modal
final modalProvider = context.read<ModalProvider>();
int modalId = modalProvider.openModal(
  YourCustomWidget(),
  alignment: Alignment.bottomCenter,
  shouldCloseOnBackdropClick: true,
);

// Close the modal
modalProvider.closeModal(modalId);
// Or pop the most recent modal
modalProvider.popModal();
```

Add the `ModalLayout` to your app scaffold:

```dart
Stack(
  children: [
    YourContent(),
    ModalLayout(padding: EdgeInsets.all(16)),
  ],
)
```

#### Toast Notifications

Toasts automatically queue and animate:

```dart
import 'package:dredge_ui/widgets.dart';
import 'package:dredge_ui/providers.dart';

final toastProvider = context.read<ToastProvider>();
toastProvider.showToast(
  NotificationWidget(
    notification: DredgeNotification(
      type: NotificationType.success,
      title: 'Success',
      description: 'Operation completed',
    ),
  ),
);
```

Add the `ToastLayout` to your app scaffold:

```dart
Stack(
  children: [
    YourContent(),
    ToastLayout(),
  ],
)
```

#### Select Dropdown

```dart
import 'package:dredge_ui/widgets.dart';
import 'package:dredge_ui/models.dart';

Select(
  options: [
    SelectOption(text: 'Option 1', value: 1),
    SelectOption(text: 'Option 2', value: 2),
  ],
  value: selectedValue,
  onChange: (option) => setState(() => selectedValue = option?.value),
)
```

#### Tab Navigation

```dart
import 'package:dredge_ui/widgets.dart';

TabNavigation(
  tabs: [
    DefaultTabNavigationItem(label: 'Home', icon: Icons.home),
    DefaultTabNavigationItem(label: 'Profile', icon: Icons.person),
  ],
  currentIndex: _currentIndex,
  onTabChange: (index) => setState(() => _currentIndex = index),
)
```

#### WebView

```dart
import 'package:dredge_ui/widgets.dart';

// Basic WebView
DrWebView(
  url: 'https://example.com',
  onLoadComplete: () => print('Loaded'),
)

// WebView in a Modal
DrWebViewModal(
  url: 'https://example.com',
  onClose: () => Navigator.pop(context),
)

// Fixed Height WebView
DrFixedHeightWebView(
  url: 'https://example.com',
  height: 400,
)
```

## Package Structure

The package is organized into modular exports:

```dart
import 'package:dredge_ui/widgets.dart';     // UI components
import 'package:dredge_ui/providers.dart';   // State management
import 'package:dredge_ui/models.dart';      // Data models
import 'package:dredge_ui/utils.dart';       // Utility functions
import 'package:dredge_ui/constants.dart';   // Layout constants
import 'package:dredge_ui/extensions.dart';  // Dart extensions
```

## Key Components

### Providers

- **ModalProvider** - Stack-based modal management with multiple simultaneous modals
- **ToastProvider** - Auto-queuing toast notifications with animation timing
- **DialogProvider** - Dialog state management

### Widgets

- **Input** - Text field with animated floating label
- **DredgeButton** - Customizable button with icon support
- **Select** - Dropdown selector with `SelectOption` model
- **AmountInput** - Numeric input with formatting
- **AmountChipsSelector** - Quick amount selection chips
- **NotificationWidget** - Styled notification with type-based colors
- **ModalLayout** - Modal container with backdrop
- **ToastLayout** - Toast notification overlay
- **TabNavigation** - Tab bar navigation
- **DrWebView** - WebView components
- **Tappable** - Touchable wrapper with ripple effect

### Models

- **SelectOption** - Dropdown option data
- **DredgeNotification** - Notification data with type and content
- **NotificationType** - Enum for notification variants (success, error, warning, info)

## Development

This package uses standard Flutter development tools:

```bash
# Run tests
flutter test

# Analyze code
flutter analyze

# Validate before publishing
dart pub publish --dry-run
```

## Contributing

When adding new components:

1. Place implementation in `lib/src/<category>/`
2. Export in the corresponding barrel file (`widgets.dart`, `providers.dart`, etc.)
3. Update this README with usage examples

## License

See [LICENSE](LICENSE) file for details.
