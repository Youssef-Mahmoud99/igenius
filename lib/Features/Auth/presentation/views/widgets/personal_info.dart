import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Auth/presentation/views/widgets/code_picker.dart';
import 'package:igenius/core/widgets/custom_drop_down.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/required_field_text.dart';

class PersonalInfo extends StatelessWidget {
  PersonalInfo({Key? key, required this.formKey, required this.currentStep})
    : super(key: key);
  final GlobalKey<FormState> formKey;
  final int currentStep;
  String? email;
  String? fullName;
  String? grade;
  String? phoneNumber;
  String? whatsappNumber;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Form(
          key: formKey,
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
              RequiredFieldText(text: 'Whatsapp Number'),
              5.verticalSpace,
              CustomPhoneField(
                onInputChanged: (value) {
                  setState(() {
                    whatsappNumber = value.toString();
                  });
                  log(whatsappNumber ?? "");
                },
                hint: '+20 123 456 7890',
              ),
              10.verticalSpace,
              RequiredFieldText(text: 'Grade'),
              5.verticalSpace,
              CustomSmallDropdown(
                value: grade,
                height: 50,
                hint: 'Select your grade',
                items: ['Grade 1', 'Grade 2', 'Grade 3', 'Grade 4'],
                onChanged: (value) {
                  setState(() {
                    grade = value;
                  });
                  print(grade);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
