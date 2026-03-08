import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:root2route/components/custom_auth/auth_background.dart';
import 'package:root2route/components/custom_auth/auth_header.dart';
import 'package:root2route/components/custom_auth/otp_field.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/core/responsive/app_sizes.dart';
import 'package:root2route/screens/auth/re-enter_password_screen.dart';

class VerificationScreen extends StatefulWidget {
  static const String id = '/VerificationScreen';
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  static const Color green = Color(0xFF2ECC71);

  int secondsLeft = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.paddingSize(context)),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthHeader(
                    title: 'Verification Code',
                    description: 'Enter the 4-digit code we sent to your email',
                    icon: Icons.verified_outlined,
                  ),
                  const SizedBox(height: 16),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 11, sigmaY: 11),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            OtpField(),
                            const SizedBox(height: 26),

                            CustomButton(
                              text: 'Verify',
                              onPressed: () => Navigator.pushReplacementNamed(
                                context,
                                ReEnterPasswordScreen.id,
                              ),
                            ),

                            const SizedBox(height: 16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  secondsLeft > 0
                                      ? 'Resend in 00:${secondsLeft.toString().padLeft(2, '0')}'
                                      : 'Didn’t receive the code?',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: secondsLeft > 0 ? null : () {},
                                  style: TextButton.styleFrom(
                                    foregroundColor: green,
                                    disabledForegroundColor: Colors.grey,
                                  ),
                                  child: const Text('Resend'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}