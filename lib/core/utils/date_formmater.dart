import 'package:intl/intl.dart';

class DateFormatter {
  static String formatApiDate(
    String dateString, {
    String format = 'dd MMM yyyy, hh:mm a',
    String languageCode = 'en',
  }) {
    try {
      final dateTime = DateTime.parse(dateString).toLocal();
      return DateFormat(format, languageCode).format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static String formatDayMonth(String dateString, {String languageCode = 'en'}) =>
      formatApiDate(dateString, format: 'dd MMM', languageCode: languageCode);

  static String formatDateYMD(String dateString, {String languageCode = 'en'}) =>
      formatApiDate(dateString, format: 'yyyy-MM-dd', languageCode: languageCode);

  static String formatTime(String dateString, {String languageCode = 'en'}) =>
      formatApiDate(dateString, format: 'hh:mm a', languageCode: languageCode);

  static String formatDayName(String dateString, {String languageCode = 'en'}) {
    try {
      final dateTime = DateTime.parse(dateString).toLocal();
      return DateFormat('EEEE, dd MMM', languageCode).format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static String getCurrentDate({String format = 'yyyy-MM-dd', String languageCode = 'en'}) {
    return DateFormat(format, languageCode).format(DateTime.now());
  }

  /// 🕒 عرض الوقت النسبي زي واتساب (قبل 10 دقائق - منذ ساعة - أمس ...)
  static String timeAgo(String dateString, {String languageCode = 'en'}) {
    try {
      final dateTime = DateTime.parse(dateString).toLocal();
      final now = DateTime.now();
      final diff = now.difference(dateTime);

      if (diff.inSeconds < 60) {
        return languageCode == 'ar' ? 'الآن' : 'just now';
      } else if (diff.inMinutes < 60) {
        final mins = diff.inMinutes;
        return languageCode == 'ar'
            ? 'قبل $mins دقيقة${mins > 1 ? '' : ''}'
            : '$mins min ago';
      } else if (diff.inHours < 24) {
        final hrs = diff.inHours;
        return languageCode == 'ar'
            ? 'قبل $hrs ساعة${hrs > 1 ? '' : ''}'
            : '$hrs hour${hrs > 1 ? 's' : ''} ago';
      } else if (diff.inDays == 1) {
        return languageCode == 'ar' ? 'أمس' : 'yesterday';
      } else if (diff.inDays < 7) {
        return languageCode == 'ar'
            ? 'قبل ${diff.inDays} يوم'
            : '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
      } else {
        // لو الوقت قديم أكتر من أسبوع نرجع التاريخ العادي
        return formatApiDate(dateString, format: 'dd MMM yyyy', languageCode: languageCode);
      }
    } catch (e) {
      return '';
    }
  }
}
