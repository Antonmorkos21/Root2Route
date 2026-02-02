import 'package:flutter/material.dart';
import 'package:root2route/components/auth_header.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_text_field.dart';
import 'package:root2route/screens/auth/verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = '/ForgotPasswordScreen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

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
                    Navigator.pushNamed(context, VerificationScreen.id);
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
