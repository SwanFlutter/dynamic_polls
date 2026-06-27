// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dynamic_polls/dynamic_polls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// مثال کامل برای استفاده از نظرسنجی با API سرور
class ServerIntegrationExample extends StatefulWidget {
  const ServerIntegrationExample({super.key});

  @override
  State<ServerIntegrationExample> createState() =>
      _ServerIntegrationExampleState();
}

class _ServerIntegrationExampleState extends State<ServerIntegrationExample> {
  List<PollModel> activePolls = [];
  List<PollModel> completedPolls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPollsFromServer();
  }

  /// دریافت نظرسنجی‌ها از سرور
  Future<void> _loadPollsFromServer() async {
    setState(() => isLoading = true);

    try {
      // فرض کنید این API شما است
      final response = await http.get(
        Uri.parse('https://your-api.com/api/polls'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          activePolls = data
              .map((json) => PollModel.fromJson(json))
              .where((poll) => !poll.isExpired)
              .toList();

          completedPolls = data
              .map((json) => PollModel.fromJson(json))
              .where((poll) => poll.isExpired)
              .toList();

          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading polls: $e');
      setState(() => isLoading = false);

      // در صورت خطا، از داده‌های نمونه استفاده کنید
      _loadSampleData();
    }
  }

  /// داده‌های نمونه برای تست
  void _loadSampleData() {
    setState(() {
      activePolls = [
        PollModel(
          id: 1,
          title: 'کدوم زبان برنامه‌نویسی رو بیشتر دوست داری؟',
          options: ['Dart', 'Python', 'JavaScript', 'Java'],
          startDate: DateTime.now().subtract(const Duration(hours: 1)),
          endDate: DateTime.now().add(const Duration(hours: 2)),
          isMultiSelect: false,
          maxSelections: null,
        ),
        PollModel(
          id: 2,
          title: 'کدوم ویژگی‌ها رو می‌خوای؟ (حداکثر 3 تا)',
          options: [
            'Dark Mode',
            'Offline Mode',
            'Push Notifications',
            'Cloud Sync',
            'AI Assistant',
          ],
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 7)),
          isMultiSelect: true,
          maxSelections: 3,
        ),
      ];
      isLoading = false;
    });
  }

  /// ارسال رای به سرور
  Future<void> _submitVoteToServer(int pollId, dynamic vote) async {
    try {
      final response = await http.post(
        Uri.parse('https://your-api.com/api/polls/$pollId/vote'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'poll_id': pollId,
          'vote': vote, // می‌تونه یک عدد یا لیست باشه
          'user_id': 'current_user_id', // از authentication بگیرید
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('Vote submitted successfully');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('رای شما ثبت شد!')));
      }
    } catch (e) {
      debugPrint('Error submitting vote: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('خطا در ثبت رای')));
    }
  }

  /// زمانی که نظرسنجی تمام میشه
  void _onPollEnded(PollModel poll) {
    setState(() {
      activePolls.removeWhere((p) => p.id == poll.id);
      completedPolls.add(poll);
    });

    // ارسال اطلاع به سرور که نظرسنجی تمام شده
    _notifyServerPollEnded(poll.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('نظرسنجی "${poll.title}" به پایان رسید')),
    );
  }

  /// اطلاع به سرور که نظرسنجی تمام شده
  Future<void> _notifyServerPollEnded(int pollId) async {
    try {
      await http.post(
        Uri.parse('https://your-api.com/api/polls/$pollId/ended'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'poll_id': pollId,
          'ended_at': DateTime.now().toIso8601String(),
        }),
      );
    } catch (e) {
      debugPrint('Error notifying server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نظرسنجی‌ها'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPollsFromServer,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadPollsFromServer,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // نظرسنجی‌های فعال
                    if (activePolls.isNotEmpty) ...[
                      const Text(
                        'نظرسنجی‌های فعال',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...activePolls.map(
                        (poll) => Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _buildPollWidget(poll, isActive: true),
                        ),
                      ),
                    ],

                    // نظرسنجی‌های تمام شده
                    if (completedPolls.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      const Divider(thickness: 2),
                      const SizedBox(height: 20),
                      const Text(
                        'نظرسنجی‌های تمام شده',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...completedPolls.map(
                        (poll) => Opacity(
                          opacity: 0.6,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _buildPollWidget(poll, isActive: false),
                          ),
                        ),
                      ),
                    ],

                    if (activePolls.isEmpty && completedPolls.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Text(
                            'هیچ نظرسنجی‌ای وجود ندارد',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildPollWidget(PollModel poll, {required bool isActive}) {
    if (poll.isMultiSelect) {
      // نظرسنجی مولتی سلکت
      return MultiSelectDynamicPolls(
        id: poll.id,
        title: poll.title,
        options: poll.options,
        startDate: poll.startDate,
        endDate: poll.endDate,
        showTimer: isActive,
        maxSelections: poll.maxSelections,
        onOptionsSelected: (selectedIndices) {
          debugPrint('Poll ${poll.id}: Selected $selectedIndices');
          if (isActive) {
            _submitVoteToServer(poll.id, selectedIndices);
          }
        },
        onPollEnded: isActive
            ? (isEnded) {
                if (isEnded) _onPollEnded(poll);
              }
            : null,
      );
    } else {
      // نظرسنجی تک انتخابی
      return DynamicPolls(
        id: poll.id,
        title: poll.title,
        options: poll.options,
        startDate: poll.startDate,
        endDate: poll.endDate,
        showTimer: isActive,
        onOptionSelected: (index) {
          debugPrint('Poll ${poll.id}: Selected $index');
          if (isActive && index >= 0) {
            _submitVoteToServer(poll.id, index);
          }
        },
      );
    }
  }
}

/// مدل داده برای نظرسنجی
class PollModel {
  final int id;
  final String title;
  final List<String> options;
  final DateTime startDate;
  final DateTime endDate;
  final bool isMultiSelect;
  final int? maxSelections;

  PollModel({
    required this.id,
    required this.title,
    required this.options,
    required this.startDate,
    required this.endDate,
    this.isMultiSelect = false,
    this.maxSelections,
  });

  bool get isExpired => DateTime.now().isAfter(endDate);
  bool get isActive =>
      DateTime.now().isAfter(startDate) && DateTime.now().isBefore(endDate);

  factory PollModel.fromJson(Map<String, dynamic> json) {
    return PollModel(
      id: json['id'],
      title: json['title'],
      options: List<String>.from(json['options']),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      isMultiSelect: json['is_multi_select'] ?? false,
      maxSelections: json['max_selections'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'options': options,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'is_multi_select': isMultiSelect,
      'max_selections': maxSelections,
    };
  }
}
