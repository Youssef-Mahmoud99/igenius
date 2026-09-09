import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Home/presentation/views/widgets/continue_learning.dart';
import 'package:igenius/core/widgets/base_gradient.dart';
import '../../../../../app.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../Teachers/presentation/views/widgets/popular_teachers.dart';
import '../widgets/get_started.dart';
import '../widgets/head_line.dart';
import '../widgets/popular_courses.dart';
import '../widgets/ready_to_start.dart';
import '../../../../Teachers/presentation/views/widgets/teachers_view.dart';
import '../widgets/upcoming_deadlines.dart';
import '../widgets/user_courses_details.dart';
import '../widgets/view_all.dart';
import '../widgets/why_choose_igenius.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.isGuest}) : super(key: key);
  final bool isGuest;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // initState() {
  //   context.read<HomeCoursesCubit>().getHomeCourses(

  //   );
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BaseGradient(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                widget.isGuest
                    ? [
                      HeadLine(isGuest: true),
                      GetStarted(),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: AppText(
                          text: 'Why Choose IGenius?',
                          style: AppsStyles.s18Bold,
                        ),
                      ),
                      10.verticalSpace,
                      WhyChooseIgenius(),
                      10.verticalSpace,
                      ViewAll(
                        title: 'Popular Courses',
                        viewallTitle: 'View All',
                        onViewAllTap: () {
                          layoutKey.currentState?.setIndex(1);
                        },
                      ),
                      SizedBox(
                        height: 290.h,
                        child: PopularCourses(isGuest: true),
                      ),
                      10.verticalSpace,
                      ViewAll(
                        title: 'Meet Our Teachers',
                        viewallTitle: 'View All',
                        onViewAllTap: () {
                          layoutKey.currentState?.setIndex(2);
                        },
                      ),
                      PopularTeachersSection(),
                      ReadyToStart(),
                    ]
                    : [
                      HeadLine(isGuest: false),
                      ContinueLearningCard(),
                      Padding(
                        padding: 10.rPadding,
                        child: UserCoursesDetails(),
                      ),
                      ViewAll(
                        title: 'Explore Teachers',
                        viewallTitle: 'See All',
                        onViewAllTap: () {
                          layoutKey.currentState?.setIndex(2);
                        },
                      ),
                      10.verticalSpace,
                      PopularTeachersSection(),
                      10.verticalSpace,
                      ViewAll(
                        title: 'Featured Courses',
                        viewallTitle: 'See All',
                        onViewAllTap: () {
                          layoutKey.currentState?.setIndex(1);
                        },
                      ),
                      SizedBox(
                        height: 320.h,
                        child: PopularCourses(isGuest: false),
                      ),
                      20.verticalSpace,
                    ],
          ),
        ),
      ),
    );
  }
}