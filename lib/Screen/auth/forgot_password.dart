import 'package:flutter/material.dart';
import 'package:root2route/Screen/auth/otp.dart';
import 'package:root2route/widgets/auth_header.dart';
import 'package:root2route/widgets/custom_button.dart';
import 'package:root2route/widgets/custom_text_field.dart';

class ForgotPassword extends StatefulWidget {
  static const String routeName = '/forgot';
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AuthHeader(
                  title: 'Forgot Password?',
                  description:
                      'Enter your email address to receive a password reset link',
                  icon: Icons.lock_reset,
                ),

                CustomTextField(
                  icon: Icons.email_outlined,
                  label: 'Email Address',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 25),

                CustomButton(
                  text: 'Send Reset Link',
                  onPressed: () {
                    Navigator.pushNamed(context, Otp.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
