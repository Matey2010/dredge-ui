<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Dredge UI

A collection of reusable UI widgets for the Dredge project.

## Usage

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  dredge_ui:
    path: packages/dredge_ui
```

## Widgets

This package contains reusable widgets that can be used throughout the project.

### Adding New Widgets

1. Create your widget file in `lib/src/widgets/`
2. Export it in `lib/src/widgets/widgets.dart`
3. Export the widgets barrel file in `lib/dredge_ui.dart`

## Development

This package is part of the main project workspace. To use it locally, reference it by path in your `pubspec.yaml`.

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

```dart
const like = 'sample';
```
