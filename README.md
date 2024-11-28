## CustomPoll Package
This package provides a customizable and dynamic poll widget for Flutter applications. It allows you to create polls with various options, styles, and behaviors, making it easy to integrate polls into your app.

## Features
Customizable Poll Widget: Create polls with customizable titles, options, and styles.

Dynamic Voting: Users can vote and see real-time updates.

Reselection Option: Allow or disallow users to change their votes.

Timer Support: Display a countdown timer for the poll duration.

Private Polls: Create private polls that only specific users can vote on.

Stream Integration: Integrate with a stream to handle vote updates and send data to a server.

- CustomPoll

![custompoll](https://github.com/user-attachments/assets/8d5a5d63-67b1-42d0-acb6-964738159f18)


```dart
CustomPoll(
                    title: 'کدام زبان برنامه‌نویسی محبوب‌تر است؟',
                    private: false,
                    allowReselection: false,
                    showPercentages: false,
                    showTimer: false,
                    options: const [
                      'فلاتر',
                      'جاوااسکریپت',
                      'پایتون',
                      'سی‌شارپ',
                    ],
                    totalVotes: 0,
                    startDate: DateTime.now().add(const Duration(seconds: 5)),
                    endDate: DateTime.now().add(const Duration(seconds: 10)),
                    maximumOptions: 20,
                    backgroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.grey.shade100,
                    ),
                    heightBetweenTitleAndOptions: 20,
                    votesText: 'رای‌ها',
                    createdBy: 'نام خلق کننده',
                    userToVote: 'نام کاربر',
                    loadingWidget: const CircularProgressIndicator(),
                    voteStream: StreamController<VoteData>(),
                    allStyle: Styles(
                      titleStyle: TitleStyle(
                        alignment: Alignment.center,
                        maxLines: 2,
                        minLines: 1,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      optionStyle: OptionStyle(
                        borderRadius: BorderRadius.circular(12),
                        selectedBorderColor: Colors.blue,
                        unselectedBorderColor: Colors.grey,
                        borderWidth: 2.0,
                        fillColor: Colors.white,
                        votedCheckmark: const Icon(Icons.check, color: Colors.green),
                        textSelectColor: Colors.blue,
                        otherTextPercentColor: Colors.black,
                        leadingVotedProgessColor: Colors.blue,
                        opacityLeadingVotedProgessColor: 0.5,
                        votedBackgroundColor: Colors.blue,
                        voteBorderProgressColor: Colors.blue,
                        progressBorderWidth: 1.0,
                      ),
                      votesTextStyle: VotesTextStyle(
                        alignment: Alignment.center,
                        paddingTop: 10,
                        paddingBottom: 10,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      dateStyle: DateStyle(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        textStart: 'شروع شده در: ',
                        textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    onOptionSelected: (index) {
                      print('رای داده شد به گزینه $index');
                    },
                  ),
                 
```
```dart
                  CustomPoll(
                    private: false,
                    allowReselection: true,
                    showPercentages: false,
                    showTimer: true,
                    allStyle: Styles(
                      titleStyle: TitleStyle(textDirection: TextDirection.ltr, alignment: Alignment.centerLeft),
                      optionStyle: OptionStyle(
                        unselectedBorderColor: Colors.teal,
                        votedBackgroundColor: Colors.blue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                        borderColor: Colors.purple,
                        leadingVotedProgessColor: Colors.purple,
                        height: 45,
                        voteBorderProgressColor: Colors.purple,
                        fillColor: Colors.white,
                      ),
                    ),
                    title: 'What is your favorite color?  ef ewf wewerwetwerwrweret  t t wtwetrw t  4twtrw4 ttttetertt   4tetree t ertert et ert e 543eter te t ert ter te4 t rret54e te tre te  ert 4 3tertert',
                    options: const ['Reddfdfd', 'Bluefdfdfd', 'Greendfdfdfd sd sad sadadsadadsadsa s adas wdwdawd aw', 'Yellowfdfdfd'],
                    startDate: DateTime.now().add(const Duration(seconds: 7)),
                    endDate: DateTime.now().add(const Duration(minutes: 4)),
                    onOptionSelected: (int selectedOption) {
                      if (kDebugMode) {
                        print('Selected option: $selectedOption');
                      }
                    },
                  ),
```

- CustomPoll.polls

![polls](https://github.com/user-attachments/assets/023e1dbf-47c4-4ad6-be0c-480df9edfbde)


```dart
CustomPoll.polls(
        title: 'How old are you?',
       options: ['18-25', '26-30', '31-35', '36-40', '41-45', '46-50', '51-55', '56-60', '61-65', '66-70'],
     onOptionSelected: (int index) {},
   allowReselection: false,
  ),
```

- CustomPoll.radioBottomPolls

![radioBottomPolls](https://github.com/user-attachments/assets/588f5d24-028c-4e03-8cdd-8b4b905edae7)


```dart
CustomPoll.radioBottomPolls(
               title: 'How old are you?',
          options: const ['18-25', '26-30', '31-35', '36-40', '41-45', '46-50', '51-55', '56-60', '61-65', '66-70'],
        onOptionSelected: (int index) {},
     allowReselection: true,
  ),
```

- CustomPoll.viewOnlyPollWidget

![onlyPolls](https://github.com/user-attachments/assets/c98f1dd9-afd9-4736-b8ad-bdd415b12d7b)


```dart
   Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomPoll.viewOnlyPollWidget(
                      title: title,
                      options: options,
                      votes: votes,
                      totalVotes: totalVotes,
                      startDate: startDate,
                      endDate: endDate,
                      showPercentages: true,
                      votesText: "آرا",
                      heightBetweenTitleAndOptions: 12,
                      heightBetweenOptions: 16,
                      pollOptionsHeight: 50,
                      pollOptionsWidth: double.infinity,
                      pollOptionsBorderRadius: BorderRadius.circular(12),
                      pollOptionsFillColor: Colors.white,
                      pollOptionsSplashColor: Colors.grey[300]!,
                      votedProgressColor: Colors.blue,
                      leadingVotedProgessColor: Colors.blueAccent,
                      votedBackgroundColor: const Color(0xffEEF0EB),
                      votedPercentageTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      votesTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
```

## Getting Started

To use this package, add custom_poll as a dependency in your pubspec.yaml file.

```yaml
dependencies:
  custom_poll: ^1.0.0
```
Then, import the package in your Dart code:

```yaml
import 'package:custom_poll/custom_poll.dart';
```

- Usage
Here is a basic example of how to use the CustomPoll widget in your Flutter app:

```dart
class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final voteStreamController = StreamController<VoteData>.broadcast();

  @override
  void initState() {
    super.initState();
    voteStreamController.stream.listen((voteData) {
      // Send vote data to the server
      _sendToServer(voteData);
    });
  }

  void _handleVoteChange() {
    final voteData = voteNotifier.value;
    _sendToServer(voteData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPoll(
        title: 'What is your favorite color?',
        options: ['Red', 'Blue', 'Green', 'Yellow'],
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(hours: 24)),
        onOptionSelected: (index) {
          print('Selected option: $index');
        },
        voteStream: voteStreamController,
        // Other parameters
      ),
    );
  }

  @override
  void dispose() {
    voteStreamController.dispose();
    super.dispose();
  }

  Future<void> _sendToServer(VoteData voteData) async {
    try {
      final response = await http.post(
        Uri.parse('YOUR_API_ENDPOINT'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(voteData.toJson()),
      );

      if (response.statusCode == 200) {
        print('Vote data sent successfully');
      } else {
        print('Failed to send vote data');
      }
    } catch (e) {
      print('Error sending vote data: $e');
    }
  }
}
```

## Example Parameters
- -title: The title of the poll.

- -options: A list of options for the poll.

- -startDate: The start date of the poll.

- -endDate: The end date of the poll.

- -onOptionSelected: A callback function that is called when an option is selected.

- -voteStream: A stream controller for handling vote updates.

## Additional Parameters

- -allowReselection: Whether users can reselect an option after voting.

- -showPercentages: Whether to display the percentage of votes for each option.

- -backgroundDecoration: The decoration applied to the background of the poll.

- -heightBetweenTitleAndOptions: The height between the title and the options.

- -votesText: The text displayed next to the vote count.

- -createdBy: The name of the user who created the poll.

- -userToVote: The name of the user who is allowed to vote.

- -private: Whether the poll is private.

- -loadingWidget: The widget to display while the poll is loading.

- -allStyle: The styles to apply to the poll.

- -maximumOptions: The maximum number of options allowed in the poll.

- -height: The height of the poll widget.

- -width: The width of the poll widget.

- -showTimer: Whether to show a timer for the poll duration.
