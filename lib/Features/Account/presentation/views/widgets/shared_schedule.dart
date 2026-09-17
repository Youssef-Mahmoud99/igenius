import 'package:flutter/material.dart';

/// ============================================================
/// ألوان الصفحتين — مأخوذة بالتقريب من الشكل اللي بعته
/// عدّل القيم دي لو عندك ملف ثيمز/كولورز خاص بالتطبيق وعايز
/// تستخدم نفس الـ constants بتاعته
/// ============================================================
class AppScheduleColors {
  // خلفية الصفحة
  static const bgGrey = Color(0xFFF3F5F9);

  // Upcoming (الأزرق الكحلي)
  static const navyDark = Color(0xFF141B33);
  static const navyLight = Color(0xFF32467A);
  static const activePillUpcoming = Color(0xFF4A1942);

  // Overdue (الأحمر)
  static const redDark = Color(0xFF8E1414);
  static const redLight = Color(0xFFE0433D);
  static const activePillOverdue = Color(0xFFD32F2F);
  static const overdueBannerBg = Color(0xFFFDECEA);
  static const overdueBannerBorder = Color(0xFFF6C4C1);
  static const overdueBannerText = Color(0xFFB3261E);

  // شات الكارد لل upcoming
  static const cardDateBgUpcoming = Color(0xFFEFF2FA);
  // شات الكارد لل overdue
  static const cardDateBgOverdue = Color(0xFFFDECEA);

  static const inactivePillBg = Color(0xFFF1F2F6);
  static const inactivePillText = Color(0xFF6B7280);
  static const cardTitle = Color(0xFF1A1F36);
  static const cardSubtitle = Color(0xFF8A90A6);
}

/// ============================================================
/// الهيدر الملون بالـ gradient (زي "Upcoming" و "Overdue Items")
/// ============================================================
class ScheduleGradientHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final IconData? icon;

  const ScheduleGradientHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 20,
        20,
        26,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Icon(icon, color: Colors.white, size: 26),
            ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 13,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

/// ============================================================
/// شريط التابس الشكل بيضاوي (pill) مع Badge لعدد العناصر
/// بيتحرك مع TabController عشان يبقى فيه سواب بين التابس
/// ============================================================
class SchedulePillTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> labels;
  final List<int?> counts; // null = من غير badge
  final Color activeColor;

  const SchedulePillTabBar({
    super.key,
    required this.controller,
    required this.labels,
    required this.counts,
    required this.activeColor,
  }) : assert(labels.length == counts.length);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: activeColor,
          borderRadius: BorderRadius.circular(26),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        labelColor: Colors.white,
        unselectedLabelColor: AppScheduleColors.inactivePillText,
        labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5),
        splashBorderRadius: BorderRadius.circular(26),
        tabs: List.generate(labels.length, (i) {
          final count = counts[i];
          return Tab(
            height: 42,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(labels[i]),
                if (count != null && count > 0) ...[
                  const SizedBox(width: 6),
                  AnimatedBuilder(
                    animation: controller.animation!,
                    builder: (context, _) {
                      final selected = controller.index == i;
                      return Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.white.withOpacity(0.25)
                              : AppScheduleColors.inactivePillBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$count',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: selected
                                ? Colors.white
                                : AppScheduleColors.inactivePillText,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          );
        }),
      ),
    );
  }
}

/// ============================================================
/// بانر التحذير اللي فوق تابات Overdue
/// "You have X overdue items — Y assignment(s), Z exam(s)."
/// ============================================================
class OverdueSummaryBanner extends StatelessWidget {
  final int assignments;
  final int exams;

  const OverdueSummaryBanner({
    super.key,
    required this.assignments,
    required this.exams,
  });

  @override
  Widget build(BuildContext context) {
    final total = assignments + exams;
    if (total == 0) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppScheduleColors.overdueBannerBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppScheduleColors.overdueBannerBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: AppScheduleColors.activePillOverdue, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: AppScheduleColors.overdueBannerText,
                  fontSize: 13,
                  height: 1.4,
                ),
                children: [
                  TextSpan(text: 'You have $total overdue item${total == 1 ? '' : 's'} — '),
                  TextSpan(
                    text: '$assignments assignment${assignments == 1 ? '' : 's'}, '
                        '$exams exam${exams == 1 ? '' : 's'}.',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ============================================================
/// الكارد الأساسي لأي عنصر (Lesson / Exam / Assignment)
/// ============================================================
class ScheduleItemCard extends StatelessWidget {
  final String dateTop; // مثال: 'SEP'
  final String dateBottom; // مثال: '05'
  final Color dateBg;
  final Color dateColor;
  final String title;
  final String subtitle;
  final String? statusText; // مثال: 'Deadline was Sep 05, 2026'
  final Color statusColor;
  final String? badgeText; // مثال: '9 days late'
  final Color badgeBg;
  final Color badgeColor;
  final String? trailingText; // مثال: '100 marks'
  final VoidCallback? onTap;

  const ScheduleItemCard({
    super.key,
    required this.dateTop,
    required this.dateBottom,
    required this.dateBg,
    required this.dateColor,
    required this.title,
    required this.subtitle,
    this.statusText,
    this.statusColor = AppScheduleColors.cardSubtitle,
    this.badgeText,
    this.badgeBg = AppScheduleColors.inactivePillBg,
    this.badgeColor = AppScheduleColors.inactivePillText,
    this.trailingText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 54,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: dateBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    dateTop,
                    style: TextStyle(
                      color: dateColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dateBottom,
                    style: TextStyle(
                      color: dateColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: AppScheduleColors.cardTitle,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppScheduleColors.cardSubtitle,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      if (statusText != null)
                        Text(
                          statusText!,
                          style: TextStyle(
                            fontSize: 12,
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      if (badgeText != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: badgeBg,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            badgeText!,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: badgeColor,
                            ),
                          ),
                        ),
                      if (trailingText != null)
                        Text(
                          trailingText!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppScheduleColors.cardSubtitle,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ============================================================
/// حالة الفاضي (Empty state) — "No upcoming lessons" مثلاً
/// ============================================================
class ScheduleEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ScheduleEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 42, color: const Color(0xFFC7CBDA)),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3D4256),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12.5, color: Color(0xFF9AA0B4)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// حالة الايرور العامة
class ScheduleErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  const ScheduleErrorState({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 36, color: Colors.redAccent),
            const SizedBox(height: 10),
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 10),
              TextButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ],
        ),
      ),
    );
  }
}

/// ============================================================
/// Helpers للتاريخ — مستخدمة في كل الكاردز
/// ============================================================
String monthShort(DateTime? date) {
  if (date == null) return '';
  const months = [
    'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
  ];
  return months[date.month - 1];
}

String dayOfMonth(DateTime? date) =>
    date == null ? '' : date.day.toString().padLeft(2, '0');

String formatFullDate(DateTime? date) {
  if (date == null) return '';
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return '${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}';
}

int daysLate(DateTime? deadline) {
  if (deadline == null) return 0;
  final diff = DateTime.now().difference(deadline).inDays;
  return diff < 0 ? 0 : diff;
}