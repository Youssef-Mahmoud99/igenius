import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/primary_button.dart';
import '../../../../../core/widgets/base/base_stateful.dart';
import '../../../../../core/widgets/base_gradient.dart';
import '../widgets/edit_from.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
    GlobalKey<FormState> editProfileKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile',
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 10.0),
          //   child: SizedBox(
          //     height: 30.h,
          //     width: 70.w,
          //     child: Appbutton(borderRadius: 12, text: 'Save', onPressed: () {
          //       AppNavaigation.pop();
          //     }),
          //   ),
          // ),
        ],
      ),
      body: BaseGradient(
        child: SafeArea(
          child: EditFrom(editProfileKey: editProfileKey),
        ),
      ),
    );
  }
}
