import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:root2route/components/auth_header.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_text_form_field.dart';
import 'package:root2route/screens/auth/login_screen.dart';

class ReEnterPasswordScreen extends StatefulWidget {
  static const String id = '/re-enter-passwordScreen';
  const ReEnterPasswordScreen({super.key});

  @override
  State<ReEnterPasswordScreen> createState() =>
      _ReEnterPasswordScreenState();
}

class _ReEnterPasswordScreenState
    extends State<ReEnterPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/3.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 11,
                      sigmaY: 11,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color:
                            Colors.white.withOpacity(0.12),
                        borderRadius:
                            BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white
                              .withOpacity(0.25),
                          width: 1,
                        ),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min,
                          children: [
                            const SizedBox(
                                height: 20),
                            AuthHeader(
                              title:
                                  'Create New Password',
                              description:
                                  'Your new password must be different from previously used passwords.',
                              icon: Icons
                                  .password_rounded,
                            ),
                            const SizedBox(
                                height: 30),
                            CustomTextFormField(
                              icon: Icons.lock_outline,
                              label:
                                  'New Password',
                              controller:
                                  passwordController,
                              isPassword: true,
                              validator: (value) {
                                if (value ==
                                        null ||
                                    value
                                        .isEmpty) {
                                  return "Please enter your password";
                                }
                                if (value
                                        .length <
                                    6) {
                                  return 'The password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                                height: 25),
                            CustomTextFormField(
                              icon: Icons.lock_outline,
                              label:
                                  'Confirm Password',
                              controller:
                                  confirmPasswordController,
                              isPassword: true,
                              validator: (value) {
                                if (value ==
                                        null ||
                                    value
                                        .isEmpty) {
                                  return "Please enter your password";
                                }
                                if (value
                                        .length <
                                    6) {
                                  return 'The password must be at least 6 characters long';
                                }
                                if (passwordController
                                        .value !=
                                    confirmPasswordController
                                        .value) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                                height: 30),
                            CustomButton(
                              text:
                                  "Reset Password",
                              onPressed: () {
                                if (!formKey
                                    .currentState!
                                    .validate())
                                  return;
                                Navigator
                                    .pushNamedAndRemoveUntil(
                                  context,
                                  LoginScreen.id,
                                  (route) =>
                                      false,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}