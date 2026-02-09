import 'package:flutter/material.dart';
import 'package:root2route/components/account_type_button.dart';
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
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AccountType? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.paddingSize(context)),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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

                  const SizedBox(height: 18),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Account Type',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Expanded(
                        child: AccountTile(
                          text: 'Farmer',
                          icon: Icons.agriculture_outlined,
                          selected: selectedType == AccountType.farmer,
                          onTap:
                              () => setState(() {
                                selectedType = AccountType.farmer;
                              }),
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: AccountTile(
                          text: 'Merchant',
                          icon: Icons.storefront_outlined,
                          selected: selectedType == AccountType.merchant,
                          onTap:
                              () => setState(() {
                                selectedType = AccountType.merchant;
                              }),
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: AccountTile(
                          text: 'Factory',
                          icon: Icons.factory_outlined,
                          selected: selectedType == AccountType.factory,
                          onTap:
                              () => setState(() {
                                selectedType = AccountType.factory;
                              }),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

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

                  const SizedBox(height: 15),

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
                      if (selectedType == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select an account type'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(10),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
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
                        onPressed: () => Navigator.pop(context),
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
        ),
      ),
    );
  }
}
