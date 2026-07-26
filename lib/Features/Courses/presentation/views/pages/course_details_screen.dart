import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/presentation/cubits/courses/course_details_cubit.dart';
import 'package:igenius/Features/Courses/presentation/views/pages/course_details_view.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/helper_methods.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({Key? key, required this.courseId, required this.isBought})
    : super(key: key);

  final int courseId;
  final bool isBought;

  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  @override
  void initState() {
    context.read<CourseDetailsCubit>().getCourseDetails(widget.courseId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,

        title: 'Course Details',

        showBack: true,

        actions: [
          IconButton(
            onPressed: () {
              HelperMethods.shareText('Share this course details');
            },

            icon: Icon(Icons.share, color: AppColors.black, size: 20.r),
          ),
        ],
      ),

      body: SafeArea(child: CourseDetailsView( isBought: widget.isBought)),
    );
  }
}
