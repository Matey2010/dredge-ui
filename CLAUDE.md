# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`dredge_ui` is a Flutter package containing reusable UI widgets, providers, utilities, and models for the Dredge project. This is a standalone package designed to be published to pub.dev.

## Commands

### Testing & Quality
```bash
flutter test                    # Run all tests
flutter analyze                 # Run static analysis
```

### Publishing
```bash
dart pub publish --dry-run      # Validate package before publishing
dart pub publish                # Publish to pub.dev
```

### Custom Workflows

When working with this project, Claude should handle listed automated workflows.
Each workflow has Name section (prefixed with `####`), optional Description section (prefixed with `#####`), optional Parameters section (prefixed with `#####`) and Steps section (prefixed with `#####`). If workflow's format is invalid it should'nt be run either and user should be responded with issue with current workflow

- Name is unique workflow identifier and should be descriptive
- Description is a paragraph gives general understanding of what this workflow does
- Parameters is a list with workflow parameters. It will have short description after dash. If parameter is not valid by it's description (missing parameter that described as required for example) claude should not run workflow but instead ask user to pass valid params.
- Steps are ordered actions that should be performed to complete workflow

#### `update-version` - Increment version

##### Description

Increment version

##### Parameters

- `type` - one of major|minor|patch

##### Steps

1. Checkout to main and pull --rebase latest version.
2. Perform flutter pub get to update pubspec.lock
3. Update version in pubspec.yaml depending on parameter (first number if type=major, second if type=minor and third if type=patch)
4. Analize changes that occured after previous commit that updated version (Usually version commit name's have format `Version x.y.z` so you can use them as flag)
5. Update README.md with the new component documentation
6. Update CHANGELOG.md with the additions
7. Run flutter analize to check if package is available for update
8. Write about problems or places that require attention that happened at the time of update3

**TODO**: Add more custom workflows as needed

## Architecture

### Module Organization

The package is organized into five main export modules, each with its own barrel file:

- **[widgets.dart](lib/widgets.dart)** - UI components (inputs, buttons, modals, toasts, web views, tab navigation)
- **[providers.dart](lib/providers.dart)** - ChangeNotifier providers for state management
- **[models.dart](lib/models.dart)** - Data models and types
- **[utils.dart](lib/utils.dart)** - Utility functions and helpers
- **[constants.dart](lib/constants.dart)** - Layout constants and configurations
- **[extensions.dart](lib/extensions.dart)** - Dart/Flutter extensions

### Key Architectural Patterns

**Provider-based State Management**: The package uses the `provider` package for managing UI state:
- `ModalProvider` - Stack-based modal management with alignment control and backdrop click handling
- `ToastProvider` - Toast notifications with automatic queuing and animation timing
- `DialogProvider` - Dialog state management

**Modal System**: Modals use a stack-based approach where multiple modals can be opened simultaneously. Each modal has:
- Unique ID for programmatic control
- Configurable alignment (center, bottom, etc.)
- Backdrop click behavior
- Layout padding options

**Toast System**: Toasts queue automatically - if a toast is already showing, new toasts wait 150ms before appearing. Animation timing is managed internally (300ms).

**WebView Integration**: Uses `flutter_inappwebview` for embedded web content with three widget variants:
- `DrWebView` - Basic web view
- `DrWebViewModal` - Web view in modal wrapper
- `DrFixedHeightWebView` - Web view with fixed height

### Adding New Components

1. Create the component file in the appropriate `lib/src/` directory:
   - `lib/src/widgets/` for UI components
   - `lib/src/providers/` for ChangeNotifier providers
   - `lib/src/models/` for data models
   - `lib/src/utils/` for utilities
   - `lib/src/constants/` for constants
   - `lib/src/extensions/` for extensions

2. Export it in the corresponding barrel file in `lib/`:
   - `widgets.dart`, `providers.dart`, `models.dart`, `utils.dart`, `constants.dart`, or `extensions.dart`

## Dependencies

- `flutter_inappwebview: ^6.1.5` - WebView functionality
- `provider: ^6.1.2` - State management

## Development Notes

- This package is designed to work as both a path dependency and a pub.dev package
- No tests are currently present in the package
- Minimum Flutter version: 1.17.0
- SDK version: ^3.8.1
- On adding new widgets update README.md and CHANGELOG.md respectively
