import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/Features/Home/presentation/views/widgets/material_details.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';

import '../../../../../core/resources/assets_manager.dart';

class PopularCourses extends StatelessWidget {
  final bool isGuest;

  const PopularCourses({Key? key, this.isGuest = false}) : super(key: key);

  final List<Map<String, dynamic>> courses = const [
    {
      "tag": "Most Popular",
      "tagIcon": "🔥",
      "title": "Advanced Mathematics",
      "subtitle": "Master algebra, geometry, and calculus",
      "category": "Mathematics",
      "categoryColor": Color(0xFF1D4ED8),
      "categoryBackgroundColor": Color(0xFFDCFCE7),
      "rating": 4.9,
      "price": "\$299",
      "gradientColors": [Color(0xFF8B5CF6), Color(0xFF6366F1)],
      "image": AppImages.calculator,
    },
    {
      "tag": "Trending",
      "tagIcon": "📈",
      "title": "Advanced Physics",
      "subtitle": "Mechanics, thermodynamics",
      "category": "Physics",
      "categoryColor": Color(0xFF4338CA),
      "categoryBackgroundColor": Color(0xFFFEE2E2),
      "rating": 4.8,
      "price": "\$249",
      "gradientColors": [Color(0xFF3B82F6), Color(0xFF2563EB)],
      "image": AppImages.calculator,
    },
    {
      "tag": "New",
      "tagIcon": "✨",
      "title": "Organic Chemistry",
      "subtitle": "Introduction to organic chemistry",
      "category": "Chemistry",
      "categoryColor": Color(0xFF15803D),
      "categoryBackgroundColor": Color(0xFFDCFCE7),
      "rating": 4.7,
      "price": "\$199",
      "gradientColors": [Color(0xFF06B6D4), Color(0xFF0891B2)],
      "image": AppImages.calculator,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCourses =
        isGuest
            ? courses.take(2).toList()
            : courses.sublist(courses.length - 2); // آخر اتنين

    return SizedBox(
      height: 300.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: filteredCourses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final course = filteredCourses[index];
          return SizedBox(
            width: 260.w,
            child: courseDetailsTile(
              course["tag"],
              course["tagIcon"],
              course["title"],
              course["subtitle"],
              course["category"],
              course["categoryColor"],
              course["rating"],
              course["price"],
              List<Color>.from(course["gradientColors"]),
              course["image"],
              course["categoryBackgroundColor"],
            ),
          );
        },
      ),
    );
  }

  Widget courseDetailsTile(
    String tag,
    String tagIcon,
    String title,
    String subtitle,
    String category,
    Color categoryColor,
    double rating,
    String price,
    List<Color> gradientColors,
    String image,
    Color categoryBackgroundColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gradient Header
          Container(
            width: double.infinity, // ياخد العرض كله
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(tagIcon, style: const TextStyle(fontSize: 13)),
                        const SizedBox(width: 4),
                        Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(child: Image.asset(image)),
              ],
            ),
          ),

          // Body content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialDetails(
                    color: categoryBackgroundColor,
                    backgroundColor: categoryColor,
                    name: category,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xFFFBBF24),
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        price,
                        style: AppsStyles.s18Bold.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
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
