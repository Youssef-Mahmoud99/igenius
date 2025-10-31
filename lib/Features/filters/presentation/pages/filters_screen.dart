import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/widgets/base_gradient.dart';
import 'package:igenius/core/widgets/gradient_button.dart';
import 'package:igenius/core/widgets/primary_button.dart';

import '../widgets/filter_checkbox.dart';
import '../widgets/filter_radio.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key, this.isCourses = true}) : super(key: key);

  final bool isCourses;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String selectedLevel = "All Levels";
  List<String> selectedProviders = [];
  String selectedSession = "All Sessions";
  String selectedRating = "All Ratings";

  List<String> selectedSubjects = [];
  bool verifiedOnly = false;
  String selectedExperience = "All Experience";

  final subjects = [
    "Mathematics",
    "Physics",
    "Chemistry",
    "Biology",
    "English",
    "History",
  ];

  final levels = [
    "All Levels",
    "IGCSE (Grade 9-10)",
    "AS Level (Grade 11)",
    "A2 Level (Grade 12)",
  ];

  final providers = ["CAMBRIDGE", "EDEXCEL", "OXFORD"];

  final sessions = ["All Sessions", "Live Sessions", "Recorded Sessions"];

  final ratings = ["All Ratings", "4.0+ ⭐", "4.5+ ⭐", "4.8+ ⭐"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BaseGradient(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 80.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.isCourses)
                      ..._buildCoursesFilters()
                    else
                      ..._buildGeneralFilters(),
                    20.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70.h,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Filters", style: AppsStyles.s18Bold),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Appbutton(
                needBorder: true,
                color: Colors.white,
                textColor: AppColors.primary,
                height: 40.h,
                borderRadius: 16,
                text: 'Clear All',
                onPressed: _clearAll,
              ),
            ),
            15.horizontalSpace,
            Expanded(
              child: GradientButton(
                height: 40.h,
                text: 'Apply Filters',
                onTap: _applyFilters,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCoursesFilters() {
    return [
      _sectionTitle("Subject"),
      ...subjects.map(
        (subject) => CustomCheckTile(
          title: subject,
          value: selectedSubjects.contains(subject),
          onChanged: (checked) {
            setState(() {
              if (checked == true) {
                selectedSubjects.add(subject);
              } else {
                selectedSubjects.remove(subject);
              }
            });
          },
        ),
      ),
      _sectionTitle("Level"),
      ...levels.map(
        (level) => CustomRadioTile(
          title: level,
          value: level,
          groupValue: selectedLevel,
          onChanged: (value) => setState(() => selectedLevel = value!),
        ),
      ),
      _sectionTitle("Course Provider"),
      ...providers.map(
        (provider) => CustomCheckTile(
          title: provider,
          value: selectedProviders.contains(provider),
          onChanged: (checked) {
            setState(() {
              if (checked == true) {
                selectedProviders.add(provider);
              } else {
                selectedProviders.remove(provider);
              }
            });
          },
        ),
      ),
      _sectionTitle("Session Type"),
      ...sessions.map(
        (type) => CustomRadioTile(
          title: type,
          value: type,
          groupValue: selectedSession,
          onChanged: (value) => setState(() => selectedSession = value!),
        ),
      ),
      _sectionTitle("Minimum Rating"),
      ...ratings.map(
        (rating) => CustomRadioTile(
          title: rating,
          value: rating,
          groupValue: selectedRating,
          onChanged: (value) => setState(() => selectedRating = value!),
        ),
      ),
    ];
  }

  List<Widget> _buildGeneralFilters() {
    return [
      _sectionTitle("Subject"),
      ...subjects.map(
        (subject) => CustomCheckTile(
          title: subject,
          value: selectedSubjects.contains(subject),
          onChanged: (checked) {
            setState(() {
              if (checked == true) {
                selectedSubjects.add(subject);
              } else {
                selectedSubjects.remove(subject);
              }
            });
          },
        ),
      ),

      _sectionTitle("Minimum Rating"),
      ...ratings.map(
        (rating) => CustomRadioTile(
          title: rating,
          value: rating,
          groupValue: selectedRating,
          onChanged: (value) => setState(() => selectedRating = value!),
        ),
      ),
      _sectionTitle("Verification"),
      CustomCheckTile(
        title: "Verified Teachers Only",
        value: verifiedOnly,
        trailing: const Icon(Icons.verified, color: Colors.blue, size: 18),
        onChanged: (checked) => setState(() => verifiedOnly = checked ?? false),
      ),
      _sectionTitle("Experience"),
      CustomRadioTile(
        title: "All Experience",
        value: "All Experience",
        groupValue: selectedExperience,
        onChanged: (value) => setState(() => selectedExperience = value!),
      ),
    ];
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
      child: Text(title, style: AppsStyles.s14Bold),
    );
  }

  void _clearAll() {
    setState(() {
      selectedLevel = "All Levels";
      selectedProviders.clear();
      selectedSession = "All Sessions";
      selectedRating = "All Ratings";
      selectedSubjects.clear();
      verifiedOnly = false;
      selectedExperience = "All Experience";
    });
  }

  void _applyFilters() {
    final filters =
        widget.isCourses
            ? {
              "subjects": selectedSubjects,
              "rating": selectedRating,
              "verifiedOnly": verifiedOnly,
              "experience": selectedExperience,
            }
            : {
              "level": selectedLevel,
              "providers": selectedProviders,
              "session": selectedSession,
              "rating": selectedRating,
            };

    Navigator.pop(context, filters);
  }
}



