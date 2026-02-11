import 'package:flutter/material.dart';
import 'package:root2route/components/custom_dialog.dart';
import 'package:root2route/core/theme/app_colors.dart';
import 'package:root2route/components/auth_header.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_text_form_field.dart';
import 'package:root2route/screens/farmer/farmer_home_screen.dart';

class EditInfoScreen extends StatefulWidget {
  const EditInfoScreen({super.key});

  @override
  State<EditInfoScreen> createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final UserType = TextEditingController(text: 'Farmer');
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthHeader(
                    title: 'Edit ',
                    description: 'Edit personal data',
                    icon: Icons.edit,
                  ),

                  const SizedBox(height: 30),
                  CustomTextFormField(
                    icon: Icons.person_outline,
                    label: 'Full Name',
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name';
                      }
                      if (!RegExp(
                        r'^[a-zA-Z\u0600-\u06FF\s]+$',
                      ).hasMatch(value)) {
                        return 'The name must contain only letters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  CustomTextFormField(
                    icon: Icons.email_outlined,
                    label: 'Email Address',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }

                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Email is incorrect';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 15),
                  CustomTextFormField(
                    icon: Icons.badge_outlined,
                    isReadOnly: true,
                    label: '',
                    controller: UserType,
                  ),
                  const SizedBox(height: 30),

                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          text: 'Save',
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;

                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder:
                                  (_) => CustomDialog(
                                    title: 'Done!',
                                    message: 'Saved successfully 🎉',
                                    icon: Icons.check_circle_rounded,
                                    color: AppColors.primary,
                                    buttonText: 'Continue',
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => const FarmerHomeScreen(),
                                        ),
                                      );
                                    },
                                  ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomButton(
                          text: 'Cancel',
                          color: AppColors.iconSecondary,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
