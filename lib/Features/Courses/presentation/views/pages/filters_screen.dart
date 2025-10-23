import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/widgets/gradient_button.dart';
import 'package:igenius/core/widgets/primary_button.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String selectedLevel = "All Levels";
  List<String> selectedProviders = [];
  String selectedSession = "All Sessions";
  String selectedRating = "All Ratings";

  final levels = [
    "All Levels",
    "IGCSE (Grade 9-10)",
    "AS Level (Grade 11)",
    "A2 Level (Grade 12)",
  ];

  final providers = ["CAMBRIDGE", "EDEXCEL", "OXFORD"];

  final sessions = ["All Sessions", "Live Sessions", "Recorded Sessions"];

  final ratings = ["All Ratings", "4+ ⭐", "3+ ⭐", "2+ ⭐", "1+ ⭐"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: ,
      //   centerTitle: false,
      //   backgroundColor: Colors.white,
      //   surfaceTintColor: Colors.transparent,
      //   elevation: 0,
      //   actions: [
      //
      //   ],
      // ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 80.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle("Level"),
                  ...levels.map(
                    (level) => RadioListTile<String>(
                      activeColor: AppColors.primary,
                      value: level,
                      groupValue: selectedLevel,
                      title: Text(level, style: AppsStyles.s14Regular),
                      onChanged: (value) {
                        setState(() => selectedLevel = value!);
                      },
                    ),
                  ),

                  _sectionTitle("Course Provider"),
                  ...providers.map(
                    (provider) => CheckboxListTile(
                      activeColor: AppColors.primary,
                      value: selectedProviders.contains(provider),
                      title: Text(provider, style: AppsStyles.s14Regular),
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
                    (type) => RadioListTile<String>(
                      activeColor: AppColors.primary,
                      value: type,
                      groupValue: selectedSession,
                      title: Text(type, style: AppsStyles.s14Regular),
                      onChanged: (value) {
                        setState(() => selectedSession = value!);
                      },
                    ),
                  ),

                  _sectionTitle("Minimum Rating"),
                  ...ratings.map(
                    (rating) => RadioListTile<String>(
                      activeColor: AppColors.primary,
                      value: rating,
                      groupValue: selectedRating,
                      title: Text(rating, style: AppsStyles.s14Regular),
                      onChanged: (value) {
                        setState(() => selectedRating = value!);
                      },
                    ),
                  ),

                  SizedBox(height: 50.h),
                ],
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
                padding: const EdgeInsets.all(30),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Filters", style: AppsStyles.s20Bold),
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
                height: 45.h,
                borderRadius: 16,
                text: 'Clear All',
                onPressed: _clearAll,
              ),
            ),
            15.horizontalSpace,
            Expanded(
              child: GradientButton(
                height: 45.h,
                text: 'Apply Filters',
                onTap: _applyFilters,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
      child: Text(
        title,
        style: AppsStyles.s16Bold.copyWith(color: AppColors.primary),
      ),
    );
  }

  void _clearAll() {
    setState(() {
      selectedLevel = "All Levels";
      selectedProviders.clear();
      selectedSession = "All Sessions";
      selectedRating = "All Ratings";
    });
  }

  void _applyFilters() {
    final filters = {
      "level": selectedLevel,
      "providers": selectedProviders,
      "session": selectedSession,
      "rating": selectedRating,
    };
    Navigator.pop(context, filters);
  }
}
