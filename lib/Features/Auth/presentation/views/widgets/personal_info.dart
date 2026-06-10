import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Auth/presentation/views/widgets/code_picker.dart';
import 'package:igenius/core/widgets/custom_drop_down.dart';
import '../../../../../app.dart';
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
          RequiredFieldText(text: 'Grade'),
          5.verticalSpace,
          CustomSmallDropdown(
            validator: (value) {
              if (value == null || value.isEmpty) return 'Grade is required';
              return null;
            },
            value: grade,
            height: 50,
            hint: 'Select your grade',
            items: ['Grade 1', 'Grade 2', 'Grade 3', 'Grade 4'],
            onChanged: (value) {
              registerParams = registerParams?.copyWith(grade: value);
              setState(() {});
            },
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'School Name'),
          5.verticalSpace,
          CustomSmallDropdown(
            validator: (value) {
              if (value == null || value.isEmpty) return 'School is required';
              return null;
            },
            value: school,
            height: 50,
            hint: 'Select your school',
            items: ['Cairo American College', 'Cairo University', 'Other'],
            onChanged: (value) {
              registerParams = registerParams?.copyWith(school: value);
              setState(() {});
            },
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'Country'),
          5.verticalSpace,
          CustomCountryCityField(
            countryValidator: (value) {
              if (value == null || value.isEmpty) return 'Country is required';
              return null;
            },
            cityValidator: (value) {
              if (value == null || value.isEmpty) return 'City is required';
              return null;
            },
            onChanged: (country, city) {
              registerParams = registerParams?.copyWith(
                country: country,
                city: city,
              );
            },
          ),
        ],
      ),
    );
  }
}
