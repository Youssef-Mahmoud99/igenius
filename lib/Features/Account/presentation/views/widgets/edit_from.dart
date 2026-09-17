import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/Features/Account/presentation/views/widgets/info_data_card.dart';

import '../../../../../app.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/utils/helpers/helper_methods.dart';
import '../../../../../core/widgets/custom_drop_down.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/gradient_button.dart';
import '../../../../Auth/presentation/views/widgets/choose_country_widget.dart';
import '../../../../Auth/presentation/views/widgets/code_picker.dart';
import '../../cubits/profile/update_profile_cubit.dart';
import 'change_image.dart';

class EditFrom extends StatefulWidget {
  EditFrom({Key? key, required this.editProfileKey}) : super(key: key);
  final GlobalKey<FormState> editProfileKey;

  @override
  _EditFromState createState() => _EditFromState();
}

class _EditFromState extends State<EditFrom> {
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController grade = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController whatsappNumber = TextEditingController();
  TextEditingController telegram = TextEditingController();
  TextEditingController parentEmail = TextEditingController();
  TextEditingController parentPhoneNumber = TextEditingController();
  TextEditingController parentWhatsappNumber = TextEditingController();
  TextEditingController parentTelegram = TextEditingController();
  TextEditingController school = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  @override
  void initState() {
    email.text = currentUser?.user?.email ?? '';
    fullName.text = currentUser?.user?.name ?? '';
    grade.text = currentUser?.grade.toString() ?? '';
    phoneNumber.text = currentUser?.phone ?? '';
    whatsappNumber.text = currentUser?.whatsapp ?? '';
    telegram.text = currentUser?.telegram ?? '';
    parentEmail.text = currentUser?.parentEmail ?? '';
    parentPhoneNumber.text = currentUser?.parentPhone ?? '';
    parentWhatsappNumber.text = currentUser?.parentWhatsapp ?? '';
    parentTelegram.text = currentUser?.parentTelegram ?? '';
    school.text = currentUser?.school ?? '';
    country.text = currentUser?.country ?? '';
    city.text = currentUser?.city ?? '';
    birthDateController.text = currentUser?.birthDate ?? '';
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    fullName.dispose();
    grade.dispose();
    phoneNumber.dispose();
    whatsappNumber.dispose();
    telegram.dispose();
    parentEmail.dispose();
    parentPhoneNumber.dispose();
    parentWhatsappNumber.dispose();
    parentTelegram.dispose();
    school.dispose();
    country.dispose();
    city.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: widget.editProfileKey,
              child: Column(
                children: [
                  // ChangeImage(
                  //   onImagePicked: (imagePath) {
                  //     setState(() {
                  //       pickedImagePath = imagePath;
                  //     });
                  //     debugPrint('hello source: $pickedImagePath');
                  //   },
                  // ),
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
                          AppText(text: 'Full Name', style: AppsStyles.s12Bold),
                          5.verticalSpace,

                          CustomTextField(
                            controller: fullName,
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
                            controller: email,
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
                          CustomPhoneField(controller: phoneNumber),
                          10.verticalSpace,
                          AppText(
                            text: 'Whatsapp Number',
                            style: AppsStyles.s12Bold,
                          ),
                          5.verticalSpace,
                          CustomPhoneField(
                            controller: whatsappNumber,
                            hint: '+20 123 456 7890',
                          ),
                          10.verticalSpace,
                          AppText(text: 'Telegram ', style: AppsStyles.s12Bold),
                          5.verticalSpace,
                          CustomTextField(
                            controller: telegram,
                            inputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Telegram is required';
                              }
                              return null;
                            },
                          ),
                          10.verticalSpace,
                          AppText(
                            text: 'School Name',
                            style: AppsStyles.s12Bold,
                          ),
                          5.verticalSpace,
                          CustomTextField(
                            controller: school,
                            inputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'School is required';
                              }
                              return null;
                            },
                          ),

                          10.verticalSpace,
                          AppText(text: 'Grade', style: AppsStyles.s12Bold),
                          5.verticalSpace,
                          CustomSmallDropdown(
                            hint: 'Select Grade',
                            height: 40.h,
                            value: grade.text,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Grade is required';
                              return null;
                            },
                            items: [
                              '7',
                              '8',
                              '9',
                              '10',
                              '11',
                              '12',
                              '13',
                              '14',
                            ],
                            onChanged: (value) {
                              registerParams = registerParams?.copyWith(
                                grade: value,
                              );
                            },
                          ),
                          10.verticalSpace,
                          CustomTextField(
                            controller: birthDateController,
                            readOnly: true,
                            prefix: IconButton(
                              onPressed: () async {
                                await HelperMethods.selectDate(
                                  context,
                                  birthDateController.text,
                                ).then((value) {
                                  if (value != null) {
                                    birthDateController.text = value;
                                  }
                                });
                              },
                              icon: Icon(
                                FontAwesomeIcons.calendarAlt,
                                color: AppColors.grey,
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
                          AppText(text: 'Country', style: AppsStyles.s12Bold),
                          5.verticalSpace,
                          CustomTextField(
                            controller: country,
                            inputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Country is required';
                              }
                              return null;
                            },
                          ),
                          10.verticalSpace,
                          AppText(
                            text: 'City',
                            style: AppsStyles.s12Bold,
                          ),
                          5.verticalSpace,
                          CustomTextField(
                            controller: city,
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
                            controller: parentEmail,
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
                          CustomPhoneField(controller: parentPhoneNumber),
                          10.verticalSpace,
                          AppText(
                            text: 'Parent Whatsapp',
                            style: AppsStyles.s12Bold,
                          ),
                          5.verticalSpace,
                          CustomPhoneField(controller: parentWhatsappNumber),
                          10.verticalSpace,
                          AppText(
                            text: 'Parent Telegram',
                            style: AppsStyles.s12Bold,
                          ),
                          5.verticalSpace,
                          CustomTextField(
                            controller: parentTelegram,
                            inputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Telegram is required';
                              }
                              return null;
                            },
                          ),
                          10.verticalSpace,
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
              FocusScope.of(context).unfocus();
              if (widget.editProfileKey.currentState!.validate()) {
                registerParams = registerParams?.copyWith(
                  name: fullName.text,
                  email: email.text,
                  phone: phoneNumber.text,
                  whatsapp: whatsappNumber.text,
                  telegram: telegram.text,
                  parentEmail: parentEmail.text,
                  parentPhone: parentPhoneNumber.text,
                  parentWhatsapp: parentWhatsappNumber.text,
                  parentTelegram: parentTelegram.text,
                  school: school.text,
                  country: country.text,
                  city: city.text,
                  birthDate: birthDateController.text,
                  grade: grade.text,
                );
                context.read<UpdateProfileCubit>().updateProfile(
                  registerParams!,
                  context,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
