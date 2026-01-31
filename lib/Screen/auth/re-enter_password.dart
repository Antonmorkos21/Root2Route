import 'package:flutter/material.dart';
import 'package:root2route/widgets/auth_header.dart';
import 'package:root2route/widgets/custom_button.dart';
import 'package:root2route/widgets/custom_text_field.dart';

class ReEnterPassword extends StatefulWidget {
  static const String routeName = '/re-enter-password';
  const ReEnterPassword({super.key});

  @override
  State<ReEnterPassword> createState() => _ReEnterPasswordState();
}

class _ReEnterPasswordState extends State<ReEnterPassword> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  AuthHeader(
                    title: 'Create New Password',
                    description:
                        'Your new password must be different from previously used passwords.',
                    icon: Icons.password_rounded,
                  ),

                  const SizedBox(height: 30),

                  CustomTextField(
                    icon: Icons.lock_outline,
                    label: 'New Password',
                    controller: passwordController,
                    isPassword: true,
                  ),

                  const SizedBox(height: 25),

                  CustomTextField(
                    icon: Icons.lock_outline,
                    label: 'Confirm Password',
                    controller: confirmPasswordController,
                    isPassword: true,
                  ),

                  const SizedBox(height: 30),

                  CustomButton(
                    text: "Reset Password",
                    onPressed: () {
                      // TODO: validate + reset logic
                    },
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
