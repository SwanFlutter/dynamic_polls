class PollTimerManager {
  static Duration calculateRemainingTime(DateTime startDate, DateTime endDate) {
    final now = DateTime.now();

    // اگر هنوز به زمان شروع نرسیده
    if (now.isBefore(startDate)) {
      return startDate.difference(now);
    }
    // اگر در بازه زمانی است
    else if (now.isAfter(startDate) && now.isBefore(endDate)) {
      return endDate.difference(now);
    }
    // اگر زمان تمام شده
    else {
      return Duration.zero;
    }
  }

  static String formatTimer(Duration duration) {
    if (duration.isNegative || duration == Duration.zero) {
      return "00:00:00";
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return "${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}";
  }
}
