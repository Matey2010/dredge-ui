## 0.2.1

### Fixed
- Fixed `Select` widget height spanning by adding `MainAxisSize.min` to prevent unnecessary vertical expansion
- Removed unused theme and colorScheme variables in `DrInput`, `DrPhoneInput`, and `DrLoader` widgets
- Changed default focus border color from theme-based to hardcoded iOS blue (`Color(0xFF007AFF)`) for consistency across themes

### Changed
- Code formatting improvements across `DrInput`, `DrLoader`, and `DrPhoneInput` widgets

## 0.2.0

### Added
- **DrLoader** - Customizable circular progress indicator widget with extensive styling options including container support, custom colors, sizes, and child widget support

### Changed
- Updated CLAUDE.md with improved custom workflow documentation format

## 0.1.0

### Added
- **DrPhoneInput** - International phone number input widget with country selector dropdown
- **CountryPhoneData** model with comprehensive country phone data (50+ countries)
- **DrDefaultModal** - Default modal component with header support and flexible styling
- **DrModalHeader** - Reusable modal header with close and back button support

### Changed
- Renamed `Input` widget to `DrInput` for consistency with package naming convention
- Reorganized modal components into `dr_modal/` directory
- Updated `DrInput` to show lock icon when disabled
- Improved `DrModalHeader` decoration merging logic

### Fixed
- Import paths updated across all components to reflect new structure
- Removed unused modal header implementation

## 0.0.1

* Initial release with core widgets, providers, and models
