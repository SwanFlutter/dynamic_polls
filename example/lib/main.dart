// ignore_for_file: unused_local_variable

import 'package:dynamic_polls/dynamic_polls.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PollStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Polls Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime startDate = DateTime(2024, 11, 25, 10, 0);
  DateTime endDate = DateTime(2024, 11, 30, 18, 0);

  final voteNotifier = ValueNotifier<VoteData>(
    VoteData(
      totalVotes: 0,
      optionVotes: {},
      percentages: {},
      selectedOption: 0,
      userToVote: '',
    ),
  );

  // داده‌های نظرسنجی
  String title = "کدام زبان برنامه‌نویسی را بیشتر دوست دارید؟";
  List<String> options = ["دارت", "جاوا", "پایتون", "جاوا اسکریپت"];
  Map<int, int> votes = {0: 50, 1: 30, 2: 70, 3: 40};
  int totalVotes = 190;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Polls Examples'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // مثال 1: نظرسنجی ساده
                  const Text(
                    '1. Simple Poll',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DynamicPolls.polls(
                    id: 1,
                    title: 'What is your favorite programming language?',
                    options: const ['Dart', 'JavaScript', 'Python', 'Java'],
                    onOptionSelected: (int index) {
                      debugPrint('Selected option: $index');
                    },
                    allowReselection: true,
                  ),

                  const SizedBox(height: 40),
                  const Divider(),

                  // مثال 2: نظرسنجی با تایمر
                  const Text(
                    '2. Poll with Timer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DynamicPolls(
                    id: 2,
                    title: 'Which framework do you prefer?',
                    options: const ['Flutter', 'React Native', 'Xamarin'],
                    startDate: DateTime.now().add(const Duration(minutes: 1)),
                    endDate: DateTime.now().add(const Duration(minutes: 5)),
                    showTimer: true,
                    onOptionSelected: (int index) {
                      debugPrint('Selected: $index');
                    },
                  ),

                  const SizedBox(height: 40),
                  const Divider(),

                  // مثال 3: نظرسنجی مولتی سلکت
                  const Text(
                    '3. Multi-Select Poll',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  MultiSelectPolls(
                    id: 3,
                    title:
                        'Which programming languages do you know? (Select multiple)',
                    options: const [
                      'Dart',
                      'Python',
                      'JavaScript',
                      'Java',
                      'C++',
                      'Go',
                    ],
                    maxSelections: 3,
                    onOptionsSelected: (List<int> selectedIndices) {
                      debugPrint('Selected options: $selectedIndices');
                    },
                  ),

                  const SizedBox(height: 40),
                  const Divider(),

                  // مثال 4: نظرسنجی مولتی سلکت با تایمر
                  const Text(
                    '4. Multi-Select Poll with Timer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  MultiSelectDynamicPolls(
                    id: 4,
                    title: 'What features do you want? (Max 3)',
                    options: const [
                      'Dark Mode',
                      'Offline Mode',
                      'Push Notifications',
                      'Cloud Sync',
                      'AI Assistant',
                    ],
                    startDate: DateTime.now(),
                    endDate: DateTime.now().add(const Duration(minutes: 2)),
                    showTimer: true,
                    maxSelections: 3,
                    onOptionsSelected: (List<int> selectedIndices) {
                      debugPrint('Selected features: $selectedIndices');
                    },
                    onPollEnded: (bool isEnded) {
                      if (isEnded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Poll has ended!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 40),
                  const Divider(),

                  // مثال 5: Radio Bottom Poll
                  const Text(
                    '5. Radio Bottom Poll',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DynamicPolls.radioBottomPolls(
                    id: 5,
                    title: 'How old are you?',
                    options: const ['18-25', '26-30', '31-35', '36-40', '41+'],
                    onOptionSelected: (int index) {
                      debugPrint('Age group selected: $index');
                    },
                    allowReselection: true,
                  ),

                  const SizedBox(height: 40),
                  const Divider(),

                  // مثال 6: View Only Poll
                  const Text(
                    '6. View Only Poll (Results)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  DynamicPolls.viewOnlyPollWidget(
                    title: title,
                    options: options,
                    votes: votes,
                    totalVotes: totalVotes,
                    startDate: startDate,
                    endDate: endDate,
                    showPercentages: true,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
