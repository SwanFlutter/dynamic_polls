



# Guide to Using New Features in Dynamic Polls Package

## New Features Added:

### 1. Multi-Select
Now you can allow users to select multiple options at once.

### 2. Poll Ended Callback
When a poll ends, a callback is triggered to notify you.

---

## Usage Examples:

### Example 1: DynamicPolls with Multi-Select

```dart
import 'package:flutter/material.dart';
import 'package:dynamic_polls/dynamic_polls.dart';

class MultiSelectPollExample extends StatefulWidget {
  @override
  _MultiSelectPollExampleState createState() => _MultiSelectPollExampleState();
}

class _MultiSelectPollExampleState extends State<MultiSelectPollExample> {
  List<Map<String, dynamic>> activePolls = [];
  List<Map<String, dynamic>> completedPolls = [];

  @override
  void initState() {
    super.initState();

    // Add an active poll
    activePolls.add({
      'id': 1,
      'title': 'Which programming languages do you know?',
      'options': ['Dart', 'Python', 'JavaScript', 'Java', 'C++'],
      'startDate': DateTime.now(),
      'endDate': DateTime.now().add(Duration(hours: 2)),
    });
  }

  void _onPollEnded(int pollId, bool isEnded) {
    if (isEnded) {
      setState(() {
        // Find the ended poll
        var poll = activePolls.firstWhere((p) => p['id'] == pollId);

        // Move to the completed polls list
        activePolls.removeWhere((p) => p['id'] == pollId);
        completedPolls.add(poll);
      });

      // Show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Poll has ended!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Polls')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Active polls
            if (activePolls.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Active Polls',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ...activePolls.map((poll) => Padding(
                padding: EdgeInsets.all(8),
                child: DynamicPolls(
                  id: poll['id'],
                  title: poll['title'],
                  options: poll['options'],
                  startDate: poll['startDate'],
                  endDate: poll['endDate'],
                  allowMultipleSelection: true, // Enable multi-select
                  allowReselection: true,
                  showTimer: true,
                  onOptionSelected: (index) {
                    print('Selected option: $index');
                  },
                  onPollEnded: (isEnded) => _onPollEnded(poll['id'], isEnded),
                ),
              )),
            ],

            // Completed polls
            if (completedPolls.isNotEmpty) ...[
              Divider(thickness: 2),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Completed Polls',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...completedPolls.map((poll) => Opacity(
                opacity: 0.6,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: DynamicPolls(
                    id: poll['id'],
                    title: poll['title'],
                    options: poll['options'],
                    startDate: poll['startDate'],
                    endDate: poll['endDate'],
                    allowMultipleSelection: true,
                    onOptionSelected: (index) {},
                  ),
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }
}
```

### Example 2: Simple Polls with Multi-Select

```dart
DynamicPolls.polls(
  title: 'What foods do you like?',
  options: ['Pizza', 'Burger', 'Kebab', 'Sushi', 'Pasta'],
  allowMultipleSelection: true, // Enable multi-select
  allowReselection: true,
  onOptionSelected: (index) {
    print('Option $index selected');
  },
)
```

### Example 3: RadioBottomPolls with Multi-Select

```dart
DynamicPolls.radioBottomPolls(
  title: 'Which social networks do you use?',
  options: ['Instagram', 'Twitter', 'Facebook', 'LinkedIn', 'TikTok'],
  allowMultipleSelection: true, // Enable multi-select
  allowReselection: true,
  onOptionSelected: (index) {
    print('Option $index selected');
  },
)
```

### Example 4: Using Poll Ended Callback

```dart
class PollManager extends StatefulWidget {
  @override
  _PollManagerState createState() => _PollManagerState();
}

class _PollManagerState extends State<PollManager> {
  bool isPollActive = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isPollActive)
          DynamicPolls(
            title: 'Best Mobile Framework?',
            options: ['Flutter', 'React Native', 'Xamarin', 'Native'],
            startDate: DateTime.now(),
            endDate: DateTime.now().add(Duration(minutes: 5)),
            showTimer: true,
            onOptionSelected: (index) {
              print('Selected: $index');
            },
            onPollEnded: (isEnded) {
              if (isEnded) {
                setState(() {
                  isPollActive = false;
                });

                // Send results to server
                _sendResultsToServer();

                // Show dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Poll has ended'),
                    content: Text('Thank you for participating!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
          )
        else
          Text('This poll has ended'),
      ],
    );
  }

  void _sendResultsToServer() {
    // Send results to server
    print('Results sent');
  }
}
```

---

## New Parameters:

### `allowMultipleSelection` (bool)
- **Default**: `false`
- **Description**: If `true`, users can select multiple options at once.
- **Available in**: `DynamicPolls`, `Polls`, `RadioBottomPolls`

### `onPollEnded` (Function(bool)?)
- **Default**: `null`
- **Description**: This callback is triggered when the poll ends, with `true` as the argument.
- **Available in**: `DynamicPolls` (only this widget has a timer)

---

## Important Notes:

1. **Multi-Select + allowReselection**: If `allowReselection` is `true`, users can deselect previously selected options.

2. **onPollEnded Only for DynamicPolls**: Since only `DynamicPolls` has a timer, this callback only works for this widget.

3. **Poll List Management**: You can use `onPollEnded` to move ended polls to a separate list.

4. **Local Storage**: For polls with an `id`, selections are stored locally.

---

## Practical Scenarios:

### Scenario 1: Multi-Select Poll with Time Limit
```dart
DynamicPolls(
  title: 'Which features do you want? (Max 3)',
  options: ['Dark Mode', 'Offline Mode', 'Push Notifications', 'Cloud Sync', 'AI Assistant'],
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 7)),
  allowMultipleSelection: true,
  showTimer: true,
  onOptionSelected: (index) {
    // Limit to 3 selections
  },
  onPollEnded: (isEnded) {
    if (isEnded) {
      // Send results and close the poll
    }
  },
)
```

### Scenario 2: Separating Active and Inactive Polls
```dart
class PollListManager {
  List<Poll> activePolls = [];
  List<Poll> expiredPolls = [];

  void handlePollEnd(Poll poll, bool isEnded) {
    if (isEnded) {
      activePolls.remove(poll);
      expiredPolls.add(poll);
      // Save to database or SharedPreferences
    }
  }
}
```


