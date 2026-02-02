import 'package:flutter/material.dart';
import 'package:root2route/components/auth_header.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_text_field.dart';

class ReEnterPasswordScreen extends StatefulWidget {
  static const String id = '/re-enter-passwordScreen';
  const ReEnterPasswordScreen({super.key});

  @override
  State<ReEnterPasswordScreen> createState() => _ReEnterPasswordScreenState();
}

class _ReEnterPasswordScreenState extends State<ReEnterPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

 

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
