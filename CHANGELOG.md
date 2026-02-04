# Changelog

All notable changes to this project will be documented in this file.

## [0.0.7] - 2024-XX-XX

### 🎉 New Features

#### Multi-Select Polls
- **NEW**: `MultiSelectPolls` - Simple multi-selection poll widget
  - Allow users to select multiple options
  - Optional `maxSelections` parameter to limit choices
  - No vote counts or percentages displayed
  - Clean selection indicators with checkmarks
  - Local storage support with `id` parameter

- **NEW**: `MultiSelectDynamicPolls` - Multi-selection poll with timer
  - All features of `MultiSelectPolls`
  - Built-in countdown timer
  - `onPollEnded` callback when poll expires
  - Perfect for time-limited feature voting
  - Automatic poll state management

#### Poll Storage Enhancements
- **NEW**: `saveMultipleVotes()` - Save multiple selections locally
- **NEW**: `getMultipleVotes()` - Retrieve saved multi-selections
- **NEW**: `hasMultipleVotes()` - Check if multi-selections exist
- **NEW**: `clearMultipleVotes()` - Clear saved multi-selections

### 📚 Documentation
- Added comprehensive `MULTI_SELECT_USAGE.md` guide in Persian
- Added `MULTI_SELECT_EXAMPLE.md` with practical examples
- Updated README.md with multi-select examples
- Added `server_integration_example.dart` for API integration

### 🔧 Improvements
- Better separation of concerns between single and multi-select polls
- Improved code organization and maintainability
- Enhanced example app with all poll types

### 📝 Examples
- Complete server integration example
- Multi-select poll examples
- Poll lifecycle management examples
- Active/completed polls separation example

### ⚠️ Breaking Changes
None - All changes are backward compatible!

---

## [0.0.6] - Previous Release

### Features
* Add `PollsLabels` for localization support (English, Spanish, Persian, Arabic, French, German)
* Add `PollStorage` for local vote persistence using `get_x_storage`
* Add `id` parameter to `DynamicPolls` for unique identification in storage
* Fix progress bar visibility in `RadioBottomPolls`
* Improve `RadioBottomPollOption` animation and styling
* Update Last SDK

---

## [0.0.5+1]
* Fix Pub Point

---

## [0.0.5]
* Fix bug

---

## [0.0.4]
* Add Property `voteNotifier`
* Add Property `userdata`
* Update SDK to Flutter 3.27
* Fix Pub Point

---

## [0.0.3]
* Fix Property
* Edit API

---

## [0.0.2]
* Add Property `id`
* Edit README

---

## [0.0.1]
* Initial release
* Basic poll functionality
* Single selection polls
* Timer support
* Customizable styling

---

## Migration Guide

### From 0.0.6 to 0.0.7

No breaking changes! Simply update your dependency:

```yaml
dependencies:
  dynamic_polls: ^0.0.7
```

#### To use new multi-select features:

**Before (Single Selection):**
```dart
DynamicPolls(
  title: 'Choose one',
  options: ['A', 'B', 'C'],
  onOptionSelected: (index) => print(index),
)
```

**After (Multi Selection):**
```dart
MultiSelectPolls(
  title: 'Choose multiple',
  options: ['A', 'B', 'C'],
  maxSelections: 2, // Optional
  onOptionsSelected: (indices) => print(indices),
)
```

**With Timer:**
```dart
MultiSelectDynamicPolls(
  title: 'Choose multiple',
  options: ['A', 'B', 'C'],
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 7)),
  maxSelections: 3,
  onOptionsSelected: (indices) => print(indices),
  onPollEnded: (isEnded) {
    if (isEnded) print('Poll ended!');
  },
)
```

---

## Roadmap

### Planned Features
- [ ] Poll analytics and insights
- [ ] Custom animations
- [ ] Poll templates
- [ ] Export poll results
- [ ] More localization options
- [ ] Accessibility improvements

### Under Consideration
- [ ] Image-based options
- [ ] Ranked choice voting
- [ ] Poll scheduling
- [ ] Result visualization charts

---

For more information, see the [README.md](README.md) or visit our [GitHub repository](https://github.com/your-repo/dynamic_polls).
