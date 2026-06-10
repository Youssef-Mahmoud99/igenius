import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/core/constants/app_routes.dart';
import 'package:igenius/core/widgets/custom_text_button.dart';
import 'package:igenius/core/widgets/gradient_button.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/required_field_text.dart';
import '../../../../Auth/presentation/views/widgets/code_picker.dart';

class ContactUsForm extends StatelessWidget {
  ContactUsForm({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? fullName;
  String? phoneNumber;
  String? message;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RequiredFieldText(text: 'Full Name'),
              5.verticalSpace,

              CustomTextField(
                onChanged: (value) {
                  setState(() {
                    fullName = value;
                  });
                },
                hint: 'John Doe',
                inputType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Full name is required';
                  }
                  return null;
                },
              ),
              10.verticalSpace,
              RequiredFieldText(text: 'Email Address'),
              5.verticalSpace,
              CustomTextField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
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
              RequiredFieldText(text: 'Phone Number'),
              5.verticalSpace,
              CustomPhoneField(
                onInputChanged: (value) {
                  setState(() {
                    phoneNumber = value.toString();
                  });
                  log(phoneNumber ?? "");
                },
                hint: '+20 123 456 7890',
              ),
              10.verticalSpace,
              RequiredFieldText(text: 'Message'),
              5.verticalSpace,
              CustomTextField(
                onChanged: (value) {
                  setState(() {
                    message = value;
                  });
                },
                hint: 'Enter your message here...',
                inputType: TextInputType.multiline,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Message is required';
                  }
                  return null;
                },
              ),
              10.verticalSpace,
              GradientButton(
                height: 50.h,
                text: 'Send Message',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    AppNavaigation.goToHome(isGuest: false);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
