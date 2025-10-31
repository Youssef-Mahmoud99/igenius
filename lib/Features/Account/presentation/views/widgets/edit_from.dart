import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Account/presentation/views/widgets/info_data_card.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/widgets/custom_drop_down.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/gradient_button.dart';
import '../../../../Auth/presentation/views/widgets/code_picker.dart';
import 'change_image.dart';

class EditFrom extends StatelessWidget {
  EditFrom({Key? key, required this.editProfileKey}) : super(key: key);
  final GlobalKey<FormState> editProfileKey;
  String email = 'john.doe@example.com';
  String fullName = 'John Doe';
  String grade = "Grade 9 (IGCSE Year 1)";
  String phoneNumber = '+20 123 456 7890';
  String whatsappNumber = '+20 123 456 7890';
  String parentEmail = 'john.doe@example.com';
  String parentPhoneNumber = '+20 123 456 7890';
  String parentWhatsappNumber = '+20 123 456 7890';
  String? pickedImagePath;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: editProfileKey,
                  child: Column(
                    children: [
                      ChangeImage(
                        onImagePicked: (imagePath) {
                          setState(() {
                            pickedImagePath = imagePath;
                          });
                          debugPrint('hello source: $pickedImagePath');
                        },
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: InfoDataCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: 'Personal Information',
                                style: AppsStyles.s16Bold,
                              ),
                              10.verticalSpace,
                              AppText(
                                text: 'Full Name',
                                style: AppsStyles.s12Bold,
                              ),
                              5.verticalSpace,

                              CustomTextField(
                                initialValue: fullName,
                                onChanged: (value) {
                                  setState(() {
                                    fullName = value;
                                  });
                                },
                                inputType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Full name is required';
                                  }
                                  return null;
                                },
                              ),
                              10.verticalSpace,
                              AppText(
                                text: 'Email Address',
                                style: AppsStyles.s12Bold,
                              ),
                              5.verticalSpace,
                              CustomTextField(
                                initialValue: email,
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
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
                              AppText(
                                text: 'Phone Number',
                                style: AppsStyles.s12Bold,
                              ),
                              5.verticalSpace,
                              CustomPhoneField(
                                initialValue: phoneNumber,
                                onInputChanged: (value) {
                                  setState(() {
                                    phoneNumber = value.toString();
                                  });
                                },
                              ),
                              10.verticalSpace,
                              AppText(
                                text: 'Whatsapp Number',
                                style: AppsStyles.s12Bold,
                              ),
                              5.verticalSpace,
                              CustomPhoneField(
                                initialValue: whatsappNumber,
                                onInputChanged: (value) {
                                  setState(() {
                                    whatsappNumber = value.toString();
                                  });
                                },
                                hint: '+20 123 456 7890',
                              ),
                              10.verticalSpace,
                              AppText(text: 'Grade', style: AppsStyles.s12Bold),
                              5.verticalSpace,
                              CustomSmallDropdown(
                                value: "Grade 9 (IGCSE Year 1)",
                                height: 50,
                                items: [
                                  'Grade 9 (IGCSE Year 1)',
                                  'Grade 10 (IGCSE Year 2)',
                                  'Grade 11 (IGCSE Year 3)',
                                  'Grade 12 (IGCSE Year 4)',
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    grade = value!;
                                  });
                                  print(grade);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: InfoDataCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: 'Parent Information',
                                style: AppsStyles.s16Bold,
                              ),
                              5.verticalSpace,
                              CustomTextField(
                                initialValue: parentEmail,
                                onChanged: (value) {
                                  setState(() {
                                    parentEmail = value;
                                  });
                                },
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
                              AppText(
                                text: 'Parent Phone',
                                style: AppsStyles.s12Bold,
                              ),
                              5.verticalSpace,
                              CustomPhoneField(
                                initialValue: parentPhoneNumber,
                                onInputChanged: (value) {
                                  setState(() {
                                    parentPhoneNumber = value.toString();
                                  });
                                },
                              ),
                              10.verticalSpace,
                              AppText(
                                text: 'Parent Whatsapp',
                                style: AppsStyles.s12Bold,
                              ),
                              5.verticalSpace,
                              CustomPhoneField(
                                initialValue: parentWhatsappNumber,
                                onInputChanged: (value) {
                                  setState(() {
                                    parentWhatsappNumber = value.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GradientButton(
                height: 40.h,
                text: 'Save Changes',
                onTap: () {
                  if (editProfileKey.currentState!.validate()) {
                    AppNavaigation.pop();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
