import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/primary_button.dart';
import '../../../../../core/widgets/base/base_stateful.dart';
import '../../../../../core/widgets/base_gradient.dart';
import '../widgets/edit_from.dart';

class EditProfileScreen extends BaseStatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState
    extends BaseStatefulWidgetState<EditProfileScreen> {
  GlobalKey<FormState> editProfileKey = GlobalKey<FormState>();

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'Edit Profile',
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: SizedBox(
            height: 30.h,
            width: 70.w,
            child: Appbutton(borderRadius: 12, text: 'Save', onPressed: () {
              AppNavaigation.pop();
            }),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return BaseGradient(
      child: SafeArea(child: EditFrom(editProfileKey: editProfileKey)),
    );
  }
}
