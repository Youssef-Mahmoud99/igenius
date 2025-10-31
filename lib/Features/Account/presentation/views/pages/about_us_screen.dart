import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';

class AboutUsScreen extends BaseStatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return CustomAppBar(title: 'About Us', showBack: true, centerTitle: false);
  }

  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: dataCard(
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),

                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.buttonGradient1,
                              AppColors.buttonGradient2,
                            ],
                          ),
                        ),
                        child: Image.asset(AppImages.courses, height: 50),
                      ),

                      10.verticalSpace,
                      Image.asset(AppImages.logo2, height: 50.h),
                    ],
                  ),
                ),
              ),
              dataCard(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Who we are', style: AppsStyles.s14Bold),
                    10.verticalSpace,
                    Text(
                      'iGenius is a comprehensive online learning platform dedicated to helping IGCSE students excel in their studies. We provide high-quality courses, expert instructors, and interactive learning materials designed specifically for the IGCSE curriculum.',
                      style: AppsStyles.s12Regular,
                    ),
                    10.verticalSpace,
                    Text(
                      'Our mission is to make quality education accessible to all students, regardless of their location. We believe that every student deserves the opportunity to reach their full potential with the right guidance and resources.',
                      style: AppsStyles.s12Regular,
                    ),
                  ],
                ),
              ),
              dataCard(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('What We Offer', style: AppsStyles.s14Bold),
                    10.verticalSpace,
                    Text(
                      'At iGenius, we provide a complete learning experience that includes:',
                      style: AppsStyles.s12Regular,
                    ),
                    10.verticalSpace,
                    offerItem(
                      'Comprehensive IGCSE courses covering all major subjects',
                    ),
                    offerItem(
                      'Expert instructors with years of teaching experience',
                    ),
                    offerItem(
                      'Interactive lessons with video content and practice materials',
                    ),
                    offerItem(
                      'Regular assessments and assignments with detailed feedback',
                    ),
                    offerItem(
                      'Live sessions for real-time interaction with teachers',
                    ),
                    offerItem('Progress tracking for students and parents'),
                    offerItem('Certificates upon course completion'),
                  ],
                ),
              ),
              dataCard(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Our Vision', style: AppsStyles.s14Bold),
                    10.verticalSpace,
                    Text(
                      'We envision a future where every IGCSE student has access to world-class education that empowers them to achieve their academic goals and build a strong foundation for their future careers. Through innovation, dedication, and a student-centered approach, we aim to transform the way students learn and succeed.',
                      style: AppsStyles.s12Regular,
                    ),
                  ],
                ),
              ),
              dataCard(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contact Us', style: AppsStyles.s14Bold),
                    10.verticalSpace,
                    contactUs(Icons.email_outlined, 'support@igenius.com'),
                    10.verticalSpace,
                    contactUs(Icons.phone_outlined, '+20 100 123 4567'),
                    10.verticalSpace,
                    contactUs(Icons.location_on_outlined, 'Cairo, Egypt'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dataCard(Widget child) {
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.4),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: Colors.white,
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }

  Widget contactUs(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20.r),
        10.horizontalSpace,
        Text(text, style: AppsStyles.s12Regular),
      ],
    );
  }

  Widget offerItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          10.horizontalSpace,
          Expanded(child: Text(text, style: AppsStyles.s12Regular)),
        ],
      ),
    );
  }
}
