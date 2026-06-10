import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Auth/presentation/views/widgets/code_picker.dart';
import 'package:igenius/core/resources/assets_manager.dart';
import '../../../../../app.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/required_field_text.dart';

class ParentInfo extends StatefulWidget {
  ParentInfo({Key? key, required this.currentStep, required this.formKey})
    : super(key: key);
  final int currentStep;
  final GlobalKey<FormState> formKey;

  @override
  State<ParentInfo> createState() => _ParentInfoState();
}

class _ParentInfoState extends State<ParentInfo> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequiredFieldText(text: 'Parent Email'),
          5.verticalSpace,
          CustomTextField(
            onChanged: (value) {
              registerParams = registerParams?.copyWith(parentEmail: value);
              log("parent email: ${registerParams?.parentEmail}");
            },
            hint: 'john.doe@example.com',
            inputType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              } else if (!value.contains("@")) {
                return 'Invalid email address';
              }
              return null;
            },
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'Parent Phone'),
          5.verticalSpace,
          CustomPhoneField(
            onInputChanged: (value) {
              registerParams = registerParams?.copyWith(parentPhone: value.phoneNumber.toString());
              log("parent phone: ${registerParams?.parentPhone}");
            },
            hint: '+20 123 456 7890',
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'Parent Whatsapp'),
          5.verticalSpace,
          CustomPhoneField(
            onInputChanged: (value) {
              registerParams = registerParams?.copyWith(parentWhatsapp: value.phoneNumber.toString());
              log("parent whatsapp: ${registerParams?.parentWhatsapp}");
            },
            hint: '+20 123 456 7890',
          ),
        ],
      ),
    );
  }
}
