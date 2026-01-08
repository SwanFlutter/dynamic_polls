// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:dynamic_polls/dynamic_polls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PollStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // داده‌های نظرسنجی
  String title = "کدام زبان برنامه‌نویسی را بیشتر دوست دارید؟";
  List<String> options = ["دارت", "جاوا", "پایتون", "جاوا اسکریپت"];
  Map<int, int> votes = {
    0: 50, // دارت
    1: 30, // جاوا
    2: 70, // پایتون
    3: 40, // جاوا اسکریپت
  };
  int totalVotes = 190;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    voteNotifier.addListener(() {
      final voteData = voteNotifier.value;
      debugPrint('all votes: ${voteData.totalVotes}');
      debugPrint('votes for each option: ${voteData.optionVotes}');
      debugPrint('percentages for each option: ${voteData.percentages}');
    });

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add a listener to the voteNotifier
                      voteNotifier.addListener(() {
                        // Add a listener to the voteNotifier to track changes in the vote data.

                        // Get the current value of the vote data from the notifier.
                        var voteData = voteNotifier.value;

                        // Create an instance of the VoteData class with sample data.
                        VoteData voteData1 = VoteData(
                          totalVotes: 100, // Total number of votes
                          optionVotes: {
                            1: 50,
                            2: 30,
                            3: 20,
                          }, // Number of votes for each option
                          percentages: {
                            1: 50.0,
                            2: 30.0,
                            3: 20.0,
                          }, // Percentage of votes for each option
                          selectedOption: 1, // The selected option
                          userToVote:
                              'John Doe', // The username or identifier of the voter
                          userId: '12345', // Unique ID of the user
                          country: 'USA', // Country of the user
                          gender: 'Male', // Gender of the user
                          age: 25, // Age of the user
                          phone: 1234567890, // Phone number of the user
                        );

                        // Convert the VoteData object to a readable string and print it.
                        debugPrint(voteData1.toString());

                        // Create a new instance of VoteData with some modified fields using copyWith().
                        var updatedVoteData = voteData1.copyWith(
                          totalVotes: 120,
                          selectedOption: 2,
                        );
                      });
                    },
                    child: const Text("Click me"),
                  ),
                  DynamicPolls(
                    id: 1,
                    pollsLabels: PollsLabels.persian,
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
                    userData: UserDataModel(
                      userToVote: 'John Doe',
                      userId: '12345',
                      country: 'USA',
                      gender: 'Male',
                      age: 25,
                      phone: 1234567890,
                    ),
                    loadingWidget: const CircularProgressIndicator(),
                    voteStream: StreamController<VoteData>(),
                    allStyle: Styles(
                      titleStyle: TitleStyle(
                        alignment: Alignment.center,
                        maxLines: 2,
                        minLines: 1,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      optionStyle: OptionStyle(
                        borderRadius: BorderRadius.circular(12),
                        selectedBorderColor: Colors.blue,
                        unselectedBorderColor: Colors.grey,
                        borderWidth: 2.0,
                        fillColor: Colors.white,
                        votedCheckmark: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
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
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      dateStyle: DateStyle(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        textStart: 'شروع شده در: ',
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onOptionSelected: (index) {
                      debugPrint('رای داده شد به گزینه $index');
                    },
                  ),
                  const SizedBox(height: 50),
                  DynamicPolls(
                    voteNotifier: voteNotifier,
                    private: false,
                    allowReselection: true,
                    showPercentages: false,
                    showTimer: true,
                    allStyle: Styles(
                      titleStyle: TitleStyle(
                        textDirection: TextDirection.ltr,
                        alignment: Alignment.centerLeft,
                      ),
                      optionStyle: OptionStyle(
                        borderWidth: 2,
                        progressBorderWidth: 0,
                        unselectedBorderColor: Colors.teal,
                        votedBackgroundColor: Colors.blue.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        borderColor: Colors.purple,
                        leadingVotedProgessColor: Colors.purple,
                        height: 45,
                        voteBorderProgressColor: Colors.green,
                        fillColor: Colors.white,
                      ),
                    ),
                    title:
                        'What is your favorite color?  ef ewf wewerwetwerwrweret  t t wtwetrw t  4twtrw4 ttttetertt   4tetree t ertert et ert e 543eter te t ert ter te4 t rret54e te tre te  ert 4 3tertert',
                    options: const [
                      'Reddfdfd',
                      'Bluefdfdfd',
                      'Greendfdfdfd sd sad sadadsadadsadsa s adas wdwdawd aw',
                      'Yellowfdfdfd',
                    ],
                    startDate: DateTime.now().add(const Duration(seconds: 7)),
                    endDate: DateTime.now().add(const Duration(minutes: 4)),
                    onOptionSelected: (int selectedOption) {
                      if (kDebugMode) {
                        print('Selected option: $selectedOption');
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  DynamicPolls.radioBottomPolls(
                    id: 2,
                    pollsLabels: PollsLabels.persian,
                    title: 'How old are you?',
                    options: const [
                      '18-25',
                      '26-30',
                      '31-35',
                      '36-40',
                      '41-45',
                      '46-50',
                      '51-55',
                      '56-60',
                      '61-65',
                      '66-70',
                    ],
                    onOptionSelected: (int index) {},
                    allowReselection: true,
                    private: false,
                  ),
                  const SizedBox(height: 20),
                  DynamicPolls.polls(
                    id: 3,
                    pollsLabels: PollsLabels.spanish,
                    title: 'How old are you?',
                    options: [
                      '18-25',
                      '26-30',
                      '31-35',
                      '36-40',
                      '41-45',
                      '46-50',
                      '51-55',
                      '56-60',
                      '61-65',
                      '66-70',
                    ],
                    onOptionSelected: (int index) {},
                    allowReselection: true,
                    allStyle: Styles(
                      optionStyle: OptionStyle(
                        progressBorderWidth: 2,
                        animationDuration: const Duration(seconds: 1),
                        borderColor: Colors.amber,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DynamicPolls.viewOnlyPollWidget(
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
                      votedPercentageTextStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      votesTextStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
