# راهنمای استفاده از قابلیت مولتی سلکت

## نصب

در فایل `pubspec.yaml` خود، پکیج را اضافه کنید:

```yaml
dependencies:
  dynamic_polls: ^latest_version
```

## مقدمه

این پکیج حالا دو نوع جدید نظرسنجی با قابلیت مولتی سلکت ارائه می‌دهد:

1. **MultiSelectPolls**: نظرسنجی ساده با قابلیت انتخاب چند گزینه
2. **MultiSelectDynamicPolls**: نظرسنجی با تایمر و callback اتمام + قابلیت انتخاب چند گزینه

## 1. MultiSelectPolls (نظرسنجی مولتی سلکت ساده)

### استفاده پایه

```dart
MultiSelectPolls(
  id: 1,
  title: 'کدوم زبان‌های برنامه‌نویسی رو بلدی؟',
  options: ['Dart', 'Python', 'JavaScript', 'Java', 'C++'],
  onOptionsSelected: (List<int> selectedIndices) {
    print('گزینه‌های انتخاب شده: $selectedIndices');
  },
)
```

### با محدودیت تعداد انتخاب

```dart
MultiSelectPolls(
  id: 2,
  title: 'حداکثر 3 زبان برنامه‌نویسی مورد علاقه‌ات رو انتخاب کن',
  options: ['Dart', 'Python', 'JavaScript', 'Java', 'C++', 'Go'],
  maxSelections: 3, // حداکثر 3 گزینه
  onOptionsSelected: (List<int> selectedIndices) {
    print('انتخاب شده: $selectedIndices');
  },
)
```

### پارامترهای کامل

```dart
MultiSelectPolls(
  id: 3,
  title: 'عنوان نظرسنجی',
  options: ['گزینه 1', 'گزینه 2', 'گزینه 3'],
  maxSelections: 2, // اختیاری - حداکثر تعداد انتخاب (null = نامحدود)
  showPercentages: true, // نمایش درصد آرا
  private: false, // اگر true باشه، نتایج نمایش داده نمیشه
  backgroundDecoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  ),
  heightBetweenTitleAndOptions: 16,
  votesText: 'آرا',
  allStyle: Styles(
    titleStyle: TitleStyle(
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    optionStyle: OptionStyle(
      selectedBorderColor: Colors.blue,
      unselectedBorderColor: Colors.grey,
    ),
  ),
  onOptionsSelected: (List<int> selectedIndices) {
    // این callback هر بار که کاربر گزینه‌ای رو انتخاب یا لغو کنه فراخوانی میشه
    print('گزینه‌های فعلی: $selectedIndices');
  },
)
```

## 2. MultiSelectDynamicPolls (با تایمر و callback)

### استفاده پایه

```dart
MultiSelectDynamicPolls(
  id: 4,
  title: 'کدوم ویژگی‌ها رو می‌خوای؟',
  options: ['Dark Mode', 'Offline Mode', 'Push Notifications', 'Cloud Sync'],
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 7)),
  showTimer: true,
  onOptionsSelected: (List<int> selectedIndices) {
    print('انتخاب شده: $selectedIndices');
  },
  onPollEnded: (bool isEnded) {
    if (isEnded) {
      print('نظرسنجی به پایان رسید!');
      // اینجا می‌تونید نظرسنجی رو به لیست تمام شده‌ها منتقل کنید
    }
  },
)
```

### مثال کامل با مدیریت لیست

```dart
class PollManager extends StatefulWidget {
  @override
  _PollManagerState createState() => _PollManagerState();
}

class _PollManagerState extends State<PollManager> {
  List<Map<String, dynamic>> activePolls = [];
  List<Map<String, dynamic>> completedPolls = [];

  @override
  void initState() {
    super.initState();
    
    activePolls.add({
      'id': 1,
      'title': 'کدوم ویژگی‌ها رو می‌خوای؟ (حداکثر 3 تا)',
      'options': ['Dark Mode', 'Offline Mode', 'Push Notifications', 'Cloud Sync', 'AI'],
      'startDate': DateTime.now(),
      'endDate': DateTime.now().add(Duration(hours: 2)),
      'maxSelections': 3,
    });
  }

  void _onPollEnded(int pollId) {
    setState(() {
      var poll = activePolls.firstWhere((p) => p['id'] == pollId);
      activePolls.removeWhere((p) => p['id'] == pollId);
      completedPolls.add(poll);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('نظرسنجی به پایان رسید!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // نظرسنجی‌های فعال
            if (activePolls.isNotEmpty) ...[
              Text('نظرسنجی‌های فعال', style: TextStyle(fontSize: 20)),
              ...activePolls.map((poll) => MultiSelectDynamicPolls(
                id: poll['id'],
                title: poll['title'],
                options: poll['options'],
                startDate: poll['startDate'],
                endDate: poll['endDate'],
                maxSelections: poll['maxSelections'],
                showTimer: true,
                onOptionsSelected: (indices) {
                  print('Poll ${poll['id']}: $indices');
                },
                onPollEnded: (isEnded) {
                  if (isEnded) _onPollEnded(poll['id']);
                },
              )),
            ],
            
            // نظرسنجی‌های تمام شده
            if (completedPolls.isNotEmpty) ...[
              Divider(),
              Text('نظرسنجی‌های تمام شده', style: TextStyle(color: Colors.grey)),
              ...completedPolls.map((poll) => Opacity(
                opacity: 0.5,
                child: MultiSelectDynamicPolls(
                  id: poll['id'],
                  title: poll['title'],
                  options: poll['options'],
                  startDate: poll['startDate'],
                  endDate: poll['endDate'],
                  maxSelections: poll['maxSelections'],
                  onOptionsSelected: (indices) {},
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

## 3. استفاده با API سرور

### ساختار JSON از سرور

```json
{
  "id": 1,
  "title": "کدوم زبان‌ها رو بلدی؟",
  "options": ["Dart", "Python", "JavaScript", "Java"],
  "start_date": "2024-01-01T00:00:00Z",
  "end_date": "2024-01-07T23:59:59Z",
  "is_multi_select": true,
  "max_selections": 3
}
```

### مثال کامل

```dart
class ServerPollsPage extends StatefulWidget {
  @override
  _ServerPollsPageState createState() => _ServerPollsPageState();
}

class _ServerPollsPageState extends State<ServerPollsPage> {
  List<PollModel> polls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPolls();
  }

  Future<void> _loadPolls() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.example.com/polls'),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          polls = data.map((json) => PollModel.fromJson(json)).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _submitVote(int pollId, List<int> selectedOptions) async {
    try {
      await http.post(
        Uri.parse('https://api.example.com/polls/$pollId/vote'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'poll_id': pollId,
          'selected_options': selectedOptions,
          'user_id': 'current_user_id',
        }),
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('رای شما ثبت شد!')),
      );
    } catch (e) {
      print('Error submitting vote: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: polls.length,
      itemBuilder: (context, index) {
        final poll = polls[index];
        
        if (poll.isMultiSelect) {
          return MultiSelectDynamicPolls(
            id: poll.id,
            title: poll.title,
            options: poll.options,
            startDate: poll.startDate,
            endDate: poll.endDate,
            maxSelections: poll.maxSelections,
            showTimer: true,
            onOptionsSelected: (selectedIndices) {
              _submitVote(poll.id, selectedIndices);
            },
            onPollEnded: (isEnded) {
              if (isEnded) {
                // انتقال به لیست تمام شده‌ها
                setState(() {
                  polls[index] = poll.copyWith(isExpired: true);
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
            showTimer: true,
            onOptionSelected: (index) {
              if (index >= 0) {
                _submitVote(poll.id, [index]);
              }
            },
          );
        }
      },
    );
  }
}

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
}
```

## تفاوت‌های کلیدی

### نظرسنجی‌های قدیمی (تک انتخابی)
- `DynamicPolls`: با تایمر
- `Polls`: بدون تایمر
- `RadioBottomPolls`: استایل رادیو باتن

### نظرسنجی‌های جدید (مولتی سلکت)
- `MultiSelectPolls`: بدون تایمر، چند انتخابی
- `MultiSelectDynamicPolls`: با تایمر، چند انتخابی، callback اتمام

## نکات مهم

1. **ذخیره‌سازی محلی**: اگر `id` تنظیم کنید، انتخاب‌ها به صورت محلی ذخیره می‌شوند
2. **محدودیت انتخاب**: با `maxSelections` می‌تونید تعداد انتخاب رو محدود کنید
3. **callback اتمام**: فقط در `MultiSelectDynamicPolls` موجوده
4. **مدیریت لیست**: با `onPollEnded` می‌تونید نظرسنجی‌های تمام شده رو جدا کنید

## مثال‌های بیشتر

فایل `example/lib/server_integration_example.dart` رو ببینید برای یک مثال کامل با:
- دریافت داده از API
- ارسال رای به سرور
- مدیریت نظرسنجی‌های فعال و تمام شده
- Refresh و error handling

---

برای سوالات بیشتر، به مستندات کامل مراجعه کنید یا issue باز کنید.
