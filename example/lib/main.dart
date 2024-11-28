import 'dart:async';

import 'package:dynamic_polls/dynamic_polls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
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
                  DynamicPolls(
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
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      optionStyle: OptionStyle(
                        borderRadius: BorderRadius.circular(12),
                        selectedBorderColor: Colors.blue,
                        unselectedBorderColor: Colors.grey,
                        borderWidth: 2.0,
                        fillColor: Colors.white,
                        votedCheckmark:
                            const Icon(Icons.check, color: Colors.green),
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
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      dateStyle: DateStyle(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        textStart: 'شروع شده در: ',
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    onOptionSelected: (index) {
                      debugPrint('رای داده شد به گزینه $index');
                    },
                  ),
                  const SizedBox(height: 50),
                  DynamicPolls(
                    private: false,
                    allowReselection: true,
                    showPercentages: false,
                    showTimer: true,
                    allStyle: Styles(
                      titleStyle: TitleStyle(
                          textDirection: TextDirection.ltr,
                          alignment: Alignment.centerLeft),
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
                    title:
                        'What is your favorite color?  ef ewf wewerwetwerwrweret  t t wtwetrw t  4twtrw4 ttttetertt   4tetree t ertert et ert e 543eter te t ert ter te4 t rret54e te tre te  ert 4 3tertert',
                    options: const [
                      'Reddfdfd',
                      'Bluefdfdfd',
                      'Greendfdfdfd sd sad sadadsadadsadsa s adas wdwdawd aw',
                      'Yellowfdfdfd'
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
                      '66-70'
                    ],
                    onOptionSelected: (int index) {},
                    allowReselection: true,
                  ),
                  const SizedBox(height: 20),
                  DynamicPolls.polls(
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
                      '66-70'
                    ],
                    onOptionSelected: (int index) {},
                    allowReselection: false,
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
                          fontSize: 14, fontWeight: FontWeight.bold),
                      votesTextStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
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
