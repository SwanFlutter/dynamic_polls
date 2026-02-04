# Dynamic Polls Package

A comprehensive and customizable poll widget package for Flutter applications. Create beautiful, interactive polls with support for single selection, multi-selection, timers, and real-time updates.

## ✨ Features

- **Multiple Poll Types**: Single-select, multi-select, radio-style, and view-only polls
- **Timer Support**: Built-in countdown timer with customizable display
- **Multi-Select Polls**: NEW! Allow users to select multiple options with optional limits
- **Poll Completion Callback**: Get notified when a poll ends
- **Real-time Updates**: Dynamic voting with instant feedback
- **Vote Persistence**: Automatic local storage of votes
- **Reselection Control**: Allow or prevent vote changes
- **Private Polls**: Restrict voting to specific users
- **Stream Integration**: Easy integration with backend services
- **Localization**: Built-in support for multiple languages (English, Spanish, Persian, Arabic, French, German)
- **Highly Customizable**: Extensive styling options for every element

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  dynamic_polls: ^latest_version
```

Then run:
```bash
flutter pub get
```

## 🚀 Quick Start

```dart
import 'package:dynamic_polls/dynamic_polls.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PollStorage.init(); // Initialize for vote persistence
  runApp(const MyApp());
}
```

## 📱 Poll Types

### 1. DynamicPolls - Poll with Timer

Full-featured poll with start/end dates and countdown timer.

```dart
DynamicPolls(
  id: 1,
  title: 'What is your favorite programming language?',
  options: ['Dart', 'JavaScript', 'Python', 'Java'],
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(hours: 24)),
  showTimer: true,
  onOptionSelected: (index) {
    print('Selected: $index');
  },
)
```

![DynamicPoll](https://github.com/user-attachments/assets/8d5a5d63-67b1-42d0-acb6-964738159f18)

### 2. Polls - Simple Poll

Basic poll without timer functionality.

```dart
DynamicPolls.polls(
  id: 2,
  title: 'How old are you?',
  options: ['18-25', '26-30', '31-35', '36-40', '41+'],
  onOptionSelected: (int index) {
    print('Age group: $index');
  },
  allowReselection: true,
)
```

![Polls](https://github.com/user-attachments/assets/023e1dbf-47c4-4ad6-be0c-480df9edfbde)

### 3. RadioBottomPolls - Radio Style

Poll with radio button style and progress bars.

```dart
DynamicPolls.radioBottomPolls(
  id: 3,
  title: 'Rate our service',
  options: ['Excellent', 'Good', 'Average', 'Poor'],
  onOptionSelected: (int index) {},
  allowReselection: true,
)
```

![RadioBottomPolls](https://github.com/user-attachments/assets/588f5d24-028c-4e03-8cdd-8b4b905edae7)

### 4. MultiSelectPolls - Multi-Selection (NEW!)

Allow users to select multiple options.

```dart
MultiSelectPolls(
  id: 4,
  title: 'Which programming languages do you know? (Select up to 3)',
  options: ['Dart', 'Python', 'JavaScript', 'Java', 'C++', 'Go'],
  maxSelections: 3, // Optional: limit number of selections
  onOptionsSelected: (List<int> selectedIndices) {
    print('Selected: $selectedIndices');
  },
)
```

**Key Features:**
- No vote counts or percentages displayed
- Just selection indicators
- Optional maximum selection limit
- Clean, simple interface

### 5. MultiSelectDynamicPolls - Multi-Select with Timer (NEW!)

Multi-selection poll with timer and completion callback.

```dart
MultiSelectDynamicPolls(
  id: 5,
  title: 'What features do you want? (Max 3)',
  options: ['Dark Mode', 'Offline Mode', 'Push Notifications', 'Cloud Sync'],
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 7)),
  showTimer: true,
  maxSelections: 3,
  onOptionsSelected: (List<int> selectedIndices) {
    print('Selected: $selectedIndices');
  },
  onPollEnded: (bool isEnded) {
    if (isEnded) {
      print('Poll has ended!');
      // Move to completed polls list
    }
  },
)
```

**Key Features:**
- Timer with start/end dates
- Completion callback
- No vote counts or percentages
- Perfect for feature voting

### 6. ViewOnlyPollWidget - Display Results

Display poll results without voting capability.

```dart
DynamicPolls.viewOnlyPollWidget(
  title: 'Poll Results',
  options: ['Option 1', 'Option 2', 'Option 3'],
  votes: {0: 50, 1: 30, 2: 70},
  totalVotes: 150,
  startDate: DateTime(2024, 1, 1),
  endDate: DateTime(2024, 1, 7),
  showPercentages: true,
)
```

![ViewOnlyPoll](https://github.com/user-attachments/assets/c98f1dd9-afd9-4736-b8ad-bdd415b12d7b)

## 🎨 Styling

Customize every aspect of your polls:

```dart
DynamicPolls(
  title: 'Styled Poll',
  options: ['Option 1', 'Option 2'],
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(hours: 1)),
  onOptionSelected: (index) {},
  allStyle: Styles(
    titleStyle: TitleStyle(
      alignment: Alignment.center,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      textDirection: TextDirection.ltr,
    ),
    optionStyle: OptionStyle(
      borderRadius: BorderRadius.circular(12),
      selectedBorderColor: Colors.blue,
      unselectedBorderColor: Colors.grey,
      borderWidth: 2.0,
      fillColor: Colors.white,
      votedCheckmark: Icon(Icons.check, color: Colors.green),
      height: 45,
    ),
    votesTextStyle: VotesTextStyle(
      alignment: Alignment.center,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
)
```

## 🌍 Localization

Built-in support for multiple languages:

```dart
DynamicPolls(
  pollsLabels: PollsLabels.persian, // or .spanish, .arabic, .french, .german
  title: 'عنوان نظرسنجی',
  options: ['گزینه ۱', 'گزینه ۲'],
  // ...
)
```

## 💾 Vote Persistence

Votes are automatically saved locally when you provide an `id`:

```dart
DynamicPolls(
  id: 123, // Unique identifier
  title: 'Persistent Poll',
  options: ['Yes', 'No'],
  // ...
)
```

## 🔄 Real-time Updates

### Using ValueNotifier

```dart
final voteNotifier = ValueNotifier<VoteData>(
  VoteData(totalVotes: 0, optionVotes: {}, percentages: {}),
);

DynamicPolls(
  voteNotifier: voteNotifier,
  // ...
)

// Listen to changes
voteNotifier.addListener(() {
  print('Total votes: ${voteNotifier.value.totalVotes}');
  print('Option votes: ${voteNotifier.value.optionVotes}');
  print('Percentages: ${voteNotifier.value.percentages}');
});
```

### Using StreamController

```dart
final voteStream = StreamController<VoteData>.broadcast();

DynamicPolls(
  voteStream: voteStream,
  // ...
)

// Listen to stream
voteStream.stream.listen((voteData) {
  // Send to server
  sendToServer(voteData.toJson());
});
```

## 🌐 Server Integration

Complete example with API integration:

```dart
class PollsPage extends StatefulWidget {
  @override
  _PollsPageState createState() => _PollsPageState();
}

class _PollsPageState extends State<PollsPage> {
  List<PollModel> activePolls = [];
  List<PollModel> completedPolls = [];

  @override
  void initState() {
    super.initState();
    _loadPolls();
  }

  Future<void> _loadPolls() async {
    final response = await http.get(Uri.parse('YOUR_API/polls'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        activePolls = data
            .map((json) => PollModel.fromJson(json))
            .where((poll) => !poll.isExpired)
            .toList();
      });
    }
  }

  Future<void> _submitVote(int pollId, dynamic vote) async {
    await http.post(
      Uri.parse('YOUR_API/polls/$pollId/vote'),
      body: json.encode({'vote': vote}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activePolls.length,
      itemBuilder: (context, index) {
        final poll = activePolls[index];
        
        if (poll.isMultiSelect) {
          return MultiSelectDynamicPolls(
            id: poll.id,
            title: poll.title,
            options: poll.options,
            startDate: poll.startDate,
            endDate: poll.endDate,
            maxSelections: poll.maxSelections,
            onOptionsSelected: (indices) => _submitVote(poll.id, indices),
            onPollEnded: (isEnded) {
              if (isEnded) {
                setState(() {
                  activePolls.remove(poll);
                  completedPolls.add(poll);
                });
              }
            },
          );
        } else {
          return DynamicPolls(
            id: poll.id,
            title: poll.title,
            options: poll.options,
            startDate: poll.startDate,
            endDate: poll.endDate,
            onOptionSelected: (index) => _submitVote(poll.id, index),
          );
        }
      },
    );
  }
}
```

## 📋 Parameters Reference

### Common Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | `int?` | Unique identifier for vote persistence |
| `title` | `String` | Poll title |
| `options` | `List<String>` | List of poll options |
| `onOptionSelected` | `Function(int)` | Callback for single selection |
| `onOptionsSelected` | `Function(List<int>)` | Callback for multi-selection |
| `allowReselection` | `bool` | Allow vote changes (default: false) |
| `showPercentages` | `bool` | Show vote percentages (default: true) |
| `private` | `bool` | Hide results from others (default: false) |
| `allStyle` | `Styles?` | Custom styling |
| `pollsLabels` | `PollsLabels?` | Localization labels |

### Timer-Specific Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `startDate` | `DateTime` | Poll start time |
| `endDate` | `DateTime` | Poll end time |
| `showTimer` | `bool` | Display countdown timer |
| `onPollEnded` | `Function(bool)?` | Callback when poll ends |

### Multi-Select Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `maxSelections` | `int?` | Maximum selections allowed (null = unlimited) |

## 📚 Examples

Check out the `/example` folder for complete examples:
- `main.dart` - Basic usage examples
- `server_integration_example.dart` - Full API integration
- See `MULTI_SELECT_USAGE.md` for detailed multi-select guide

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🐛 Issues

Found a bug? Please file an issue on [GitHub](https://github.com/your-repo/dynamic_polls/issues).

## 📧 Contact

For questions or suggestions, please open an issue or contact the maintainers.

---

Made with ❤️ for the Flutter community
