# 🎉 Release Notes - Version 0.0.7

## خلاصه تغییرات

این نسخه دو نوع نظرسنجی جدید با قابلیت **مولتی سلکت** (انتخاب چند گزینه) اضافه می‌کنه.

---

## ✨ ویژگی‌های جدید

### 1️⃣ MultiSelectPolls
نظرسنجی ساده با قابلیت انتخاب چند گزینه

**ویژگی‌ها:**
- ✅ انتخاب چندتایی بدون محدودیت یا با محدودیت دلخواه
- ✅ بدون نمایش تعداد آرا و درصد
- ✅ فقط نمایش گزینه‌های انتخاب شده
- ✅ ذخیره‌سازی محلی با `id`
- ✅ آیکون تیک برای گزینه‌های انتخاب شده

**مثال:**
```dart
MultiSelectPolls(
  id: 1,
  title: 'کدوم زبان‌های برنامه‌نویسی رو بلدی؟',
  options: ['Dart', 'Python', 'JavaScript', 'Java', 'C++'],
  maxSelections: 3, // حداکثر 3 تا
  onOptionsSelected: (List<int> selectedIndices) {
    print('انتخاب شده: $selectedIndices');
  },
)
```

---

### 2️⃣ MultiSelectDynamicPolls
نظرسنجی مولتی سلکت با تایمر و callback اتمام

**ویژگی‌ها:**
- ✅ همه ویژگی‌های `MultiSelectPolls`
- ✅ تایمر شروع و پایان
- ✅ نمایش زمان باقی‌مانده
- ✅ callback برای زمان اتمام نظرسنجی
- ✅ مدیریت خودکار وضعیت نظرسنجی

**مثال:**
```dart
MultiSelectDynamicPolls(
  id: 2,
  title: 'کدوم ویژگی‌ها رو می‌خوای؟ (حداکثر 3 تا)',
  options: ['Dark Mode', 'Offline Mode', 'Push Notifications', 'Cloud Sync'],
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 7)),
  showTimer: true,
  maxSelections: 3,
  onOptionsSelected: (indices) {
    print('انتخاب شده: $indices');
  },
  onPollEnded: (bool isEnded) {
    if (isEnded) {
      print('نظرسنجی تمام شد!');
      // انتقال به لیست نظرسنجی‌های تمام شده
    }
  },
)
```

---

## 🔧 متدهای جدید PollStorage

برای مدیریت انتخاب‌های چندگانه:

```dart
// ذخیره
await PollStorage().saveMultipleVotes('poll_1', [0, 2, 4]);

// دریافت
List<int>? votes = PollStorage().getMultipleVotes('poll_1');

// بررسی وجود
bool hasVotes = PollStorage().hasMultipleVotes('poll_1');

// پاک کردن
await PollStorage().clearMultipleVotes('poll_1');
```

---

## 📚 مستندات جدید

### فایل‌های راهنما:
1. **MULTI_SELECT_USAGE.md** - راهنمای کامل فارسی
2. **MULTI_SELECT_EXAMPLE.md** - مثال‌های کاربردی
3. **example/lib/server_integration_example.dart** - مثال کامل با API

---

## 🎯 موارد استفاده

### سناریو 1: نظرسنجی مهارت‌ها
```dart
MultiSelectPolls(
  title: 'کدوم زبان‌های برنامه‌نویسی رو بلدی؟',
  options: ['Dart', 'Python', 'JavaScript', 'Java', 'C++', 'Go'],
  onOptionsSelected: (indices) {
    // ارسال به سرور
  },
)
```

### سناریو 2: انتخاب ویژگی با محدودیت زمانی
```dart
MultiSelectDynamicPolls(
  title: 'کدوم ویژگی‌ها رو می‌خوای؟ (حداکثر 3 تا)',
  options: ['Feature 1', 'Feature 2', 'Feature 3', 'Feature 4'],
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 7)),
  maxSelections: 3,
  showTimer: true,
  onOptionsSelected: (indices) => sendToServer(indices),
  onPollEnded: (isEnded) {
    if (isEnded) moveToCompletedPolls();
  },
)
```

### سناریو 3: مدیریت نظرسنجی‌های فعال و تمام شده
```dart
class PollManager extends StatefulWidget {
  @override
  _PollManagerState createState() => _PollManagerState();
}

class _PollManagerState extends State<PollManager> {
  List<Poll> activePolls = [];
  List<Poll> completedPolls = [];

  void _onPollEnded(Poll poll) {
    setState(() {
      activePolls.remove(poll);
      completedPolls.add(poll);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // نظرسنجی‌های فعال
        ...activePolls.map((poll) => MultiSelectDynamicPolls(
          id: poll.id,
          title: poll.title,
          options: poll.options,
          startDate: poll.startDate,
          endDate: poll.endDate,
          onOptionsSelected: (indices) {},
          onPollEnded: (isEnded) {
            if (isEnded) _onPollEnded(poll);
          },
        )),
        
        Divider(),
        
        // نظرسنجی‌های تمام شده
        ...completedPolls.map((poll) => Opacity(
          opacity: 0.5,
          child: MultiSelectPolls(
            id: poll.id,
            title: poll.title,
            options: poll.options,
            onOptionsSelected: (indices) {},
          ),
        )),
      ],
    );
  }
}
```

---

## 🔄 سازگاری با نسخه‌های قبلی

✅ **هیچ تغییر breaking نداریم!**

همه کدهای قبلی بدون تغییر کار می‌کنن. فقط دو کلاس جدید اضافه شده:
- `MultiSelectPolls`
- `MultiSelectDynamicPolls`

---

## 📊 مقایسه انواع نظرسنجی

| ویژگی | DynamicPolls | Polls | MultiSelectPolls | MultiSelectDynamicPolls |
|-------|--------------|-------|------------------|------------------------|
| تک انتخابی | ✅ | ✅ | ❌ | ❌ |
| چند انتخابی | ❌ | ❌ | ✅ | ✅ |
| تایمر | ✅ | ❌ | ❌ | ✅ |
| نمایش آرا | ✅ | ✅ | ❌ | ❌ |
| نمایش درصد | ✅ | ✅ | ❌ | ❌ |
| callback اتمام | ❌ | ❌ | ❌ | ✅ |
| محدودیت انتخاب | ❌ | ❌ | ✅ | ✅ |

---

## 🚀 نحوه آپدیت

### 1. آپدیت pubspec.yaml
```yaml
dependencies:
  dynamic_polls: ^0.0.7
```

### 2. دریافت پکیج
```bash
flutter pub get
```

### 3. استفاده از ویژگی‌های جدید
```dart
import 'package:dynamic_polls/dynamic_polls.dart';

// استفاده از MultiSelectPolls
MultiSelectPolls(
  title: 'عنوان',
  options: ['گزینه 1', 'گزینه 2'],
  onOptionsSelected: (indices) {},
)
```

---

## 📖 منابع یادگیری

1. **README.md** - مستندات کامل
2. **MULTI_SELECT_USAGE.md** - راهنمای مولتی سلکت
3. **example/lib/main.dart** - مثال‌های پایه
4. **example/lib/server_integration_example.dart** - مثال کامل با API

---

## 🐛 گزارش مشکلات

اگر مشکلی پیدا کردید یا پیشنهادی دارید:
- GitHub Issues: [لینک]
- Email: [ایمیل]

---

## 🙏 تشکر

از همه کسانی که در توسعه این پکیج مشارکت کردن، ممنونیم!

---

**نسخه:** 0.0.7  
**تاریخ انتشار:** 2024-XX-XX  
**سازگاری:** Flutter 3.27+
