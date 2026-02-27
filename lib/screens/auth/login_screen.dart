import 'package:flutter/material.dart';
import 'package:root2route/components/custom_dialog.dart';
import 'package:root2route/core/theme/app_colors.dart';
import 'package:root2route/screens/auth/forgot_password_screen.dart';
import 'package:root2route/screens/auth/register_screen.dart';
import 'package:root2route/components/auth_header.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_text_form_field.dart';
import 'package:root2route/screens/guest/products_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthHeader(
                  title: 'Welcome Back',
                  description: 'Sign in to continue',
                  icon: Icons.spa,
                ),

                const SizedBox(height: 30),
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
                  icon: Icons.lock_outline,
                  label: 'Password',
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

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed:
                        () => Navigator.pushNamed(
                          context,
                          ForgotPasswordScreen.id,
                        ),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
                    child: const Text('Forgot password?'),
                  ),
                ),

                const SizedBox(height: 15),

                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    if (formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder:
                            (_) => CustomDialog(
                              title: 'Welcome!',
                              message: 'Logged in successfully ',
                              icon: Icons.check_circle_rounded,
                              color: AppColors.primary,
                              buttonText: 'Continue',

                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => productsScreen(),
                                  ),
                                );
                              },
                            ),
                      );
                    }
                  },
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don’t have an account? '),
                    TextButton(
                      onPressed:
                          () => Navigator.pushNamed(context, RegisterScreen.id),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                      ),
                      child: const Text('Create account'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
