import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/widgets/custom_drop_down.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/required_field_text.dart';

class PersonalInfo extends StatefulWidget {
  PersonalInfo({Key? key, required this.currentStep, required this.formKey})
    : super(key: key);
  final int currentStep;
  final GlobalKey<FormState> formKey;
  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  String? email;
  String? fullName;
  String? phoneNumber;
  String? whatsappNumber;
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

          CustomTextField(
            onChanged: (value) {
              setState(() {
                phoneNumber = value;
              });
            },
            hint: '+20 123 456 7890',
            inputType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Phone number is required';
              }
              return null;
            },
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'Whatsapp Number'),
          5.verticalSpace,
          CustomTextField(
            onChanged: (value) {
              setState(() {
                whatsappNumber = value;
              });
            },
            hint: '+20 123 456 7890',
            inputType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Whatsapp number is required';
              }
              return null;
            },
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'Grade'),
          5.verticalSpace,
          CustomSmallDropdown(
            value: grade,
            height: 50,
            hint: 'Select your grade',
            itemsMap: {'1': '1', '2': '2', '3': '3', '4': '4'},
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
  }
}
