import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/resources/assets_manager.dart';
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
  String? parentEmail;

  String? parentPhoneNumber;

  String? parentWhatsappNumber;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppImages.infoInstructions,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          10.verticalSpace,
          RequiredFieldText(text: 'Parent Email'),
          5.verticalSpace,
          CustomTextField(
            onChanged: (value) {
              setState(() {
                parentEmail = value;
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
          RequiredFieldText(text: 'Parent Phone'),
          5.verticalSpace,
          CustomTextField(
            onChanged: (value) {
              setState(() {
                parentPhoneNumber = value;
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
          RequiredFieldText(text: 'Parent Whatsapp'),
          5.verticalSpace,
          CustomTextField(
            onChanged: (value) {
              setState(() {
                parentWhatsappNumber = value;
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
        ],
      ),
    );
  }
}
