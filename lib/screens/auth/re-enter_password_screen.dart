import 'package:flutter/material.dart';
import 'package:root2route/components/auth_header.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_dialog.dart';
import 'package:root2route/components/custom_text_form_field.dart';
import 'package:root2route/screens/auth/login_screen.dart';

class ReEnterPasswordScreen extends StatefulWidget {
  static const String id = '/re-enter-passwordScreen';
  const ReEnterPasswordScreen({super.key});

  @override
  State<ReEnterPasswordScreen> createState() => _ReEnterPasswordScreenState();
}

class _ReEnterPasswordScreenState extends State<ReEnterPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    AuthHeader(
                      title: 'Create New Password',
                      description:
                          'Your new password must be different from previously used passwords.',
                      icon: Icons.password_rounded,
                    ),

                    const SizedBox(height: 30),

                    CustomTextFormField(
                      icon: Icons.lock_outline,
                      label: 'New Password',
                      controller: passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }

                        if (value.length < 6) {
                          return 'The password must be at least 6 characters long';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    CustomTextFormField(
                      icon: Icons.lock_outline,
                      label: 'Confirm Password',
                      controller: confirmPasswordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }

                        if (value.length < 6) {
                          return 'The password must be at least 6 characters long';
                        }
                        if (passwordController.value !=
                            confirmPasswordController.value) {
                          return 'Passwords do not match';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    CustomButton(
                      text: "Reset Password",
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        if (formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (_) => CustomDialog(
                                  type: DialogType.success,
                                  title: "Success",
                                  message:
                                      "Your password has been reset successfully. \n You can now log in with your new password",
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      LoginScreen.id,
                                    );
                                  },
                                ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
