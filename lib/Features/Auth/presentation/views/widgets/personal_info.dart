import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/Features/Auth/presentation/views/widgets/code_picker.dart';
import 'package:igenius/core/widgets/custom_drop_down.dart';
import '../../../../../app.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/helper_methods.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/required_field_text.dart';
import 'choose_country_widget.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({
    Key? key,
    required this.formKey,
    required this.currentStep,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final int currentStep;

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  String? country;
  String? city;
  String? school;
  String? grade;
  String? birthDate;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequiredFieldText(text: 'Full Name'),
          5.verticalSpace,
          CustomTextField(
            onChanged: (value) {
              registerParams = registerParams?.copyWith(name: value);
            },
            hint: 'John Doe',
            inputType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty)
                return 'Full name is required';
              return null;
            },
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'Email Address'),
          5.verticalSpace,
          CustomTextField(
            onChanged: (value) {
              registerParams = registerParams?.copyWith(email: value);
            },
            hint: 'john.doe@example.com',
            inputType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email is required';
              if (!value.contains("@")) return 'Invalid email address';
              return null;
            },
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'Phone Number'),
          5.verticalSpace,
          CustomPhoneField(
            onInputChanged: (value) {
              registerParams = registerParams?.copyWith(
                phone: value.phoneNumber,
              );
            },
            hint: '+20 123 456 7890',
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'Whatsapp Number'),
          5.verticalSpace,
          CustomPhoneField(
            onInputChanged: (value) {
              registerParams = registerParams?.copyWith(
                whatsapp: value.phoneNumber,
              );
            },
            hint: '+20 123 456 7890',
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'Telegram '),
          5.verticalSpace,
          CustomTextField(
            onChanged: (value) {
              registerParams = registerParams?.copyWith(telegram: value);
            },
            hint: '@igenius',
            inputType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Telegram is required';
              }
              return null;
            },
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'Grade'),
          5.verticalSpace,
          CustomSmallDropdown(
            hint: 'Select Grade',
            height: 40.h,
            value: grade,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Grade is required';
              return null;
            },
            items: ['7', '8', '9', '10', '11', '12', '13', '14'],
            onChanged: (value) {
              registerParams = registerParams?.copyWith(grade: value);
            },
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'School Name'),
          5.verticalSpace,
          CustomTextField(
            hint: 'University of Egypt',
            onChanged: (value) {
              registerParams = registerParams?.copyWith(school: value);
            },
            inputType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'School is required';
              }
              return null;
            },
          ),
          10.verticalSpace,
          CustomTextField(
            controller:  TextEditingController(text: birthDate ?? ''),
            hint: '2002-01-01',
            readOnly: true,
            prefix: IconButton(
              onPressed: () async {
                await HelperMethods.selectDate(context, birthDate).then((
                  value,
                ) {
                  if (value != null) {
                    print("Date selected: $value");
                    setState(() {
                      birthDate = value;
                    });
                    registerParams = registerParams?.copyWith(birthDate: value);
                  }
                });
              },
              icon: Icon(
                FontAwesomeIcons.calendarAlt,
                color: AppColors.primary,
                size: 15,
              ),
            ),

            inputType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Birth date is required';
              }
              return null;
            },
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'Country'),
          5.verticalSpace,
          CustomTextField(
            hint: 'Egypt',
            onChanged: (value) {
              registerParams = registerParams?.copyWith(country: value);
            },
            inputType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Country is required';
              }
              return null;
            },
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'City'),
          5.verticalSpace,
          CustomTextField(
            hint: 'Cairo',
            onChanged: (value) {
              registerParams = registerParams?.copyWith(city: value);
            },
            inputType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'City is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
