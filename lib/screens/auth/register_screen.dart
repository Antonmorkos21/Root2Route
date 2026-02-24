import 'package:flutter/material.dart';
import 'package:root2route/components/auth_header.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_dialog.dart';
import 'package:root2route/components/custom_text_form_field.dart';
import 'package:root2route/core/responsive/app_sizes.dart';
import 'package:root2route/core/theme/app_colors.dart';
import 'package:root2route/screens/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = '/registerScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingSize(context)),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              AuthHeader(
                title: 'Create Account',
                description: 'Enter your details to create a new account',
                icon: Icons.person_add_alt_1,
              ),

              const SizedBox(height: 30),

              CustomTextFormField(
                icon: Icons.person_outline,
                label: 'Full Name',
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter the name';
                  if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(value)) {
                    return 'The name must contain only letters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              CustomTextFormField(
                icon: Icons.phone_outlined,
                label: 'Phone Number',
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter your phone';
                  if (!RegExp(r'^[0-9]{7,15}$').hasMatch(value)) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              CustomTextFormField(
                icon: Icons.location_on_outlined,
                label: 'Address',
                controller: addressController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter your address';
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
                  if (value == null || value.isEmpty)
                    return 'Please enter your email address';
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Email is incorrect';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              CustomTextFormField(
                icon: Icons.lock_outline,
                label: 'New Password',
                controller: passwordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please enter your password";
                  if (value.length < 6)
                    return 'The password must be at least 6 characters long';
                  return null;
                },
              ),

              const SizedBox(height: 15),

              CustomTextFormField(
                icon: Icons.lock_outline,
                label: 'Confirm Password',
                controller: confirmPasswordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Please confirm your password";
                  if (passwordController.text !=
                      confirmPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              CustomButton(
                text: 'Register',
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder:
                        (_) => CustomDialog(
                          title: 'Done!',
                          message: 'Account created successfully 🎉',
                          icon: Icons.check_circle_rounded,
                          color: AppColors.primary,
                          buttonText: 'OK',
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.id,
                            );
                          },
                        ),
                  );
                },
              ),

              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreen.id);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF2ECC71),
                    ),
                    child: const Text(' Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
