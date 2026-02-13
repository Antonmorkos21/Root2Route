import 'package:flutter/material.dart';
import 'package:root2route/components/otp_field.dart';
import 'package:root2route/screens/auth/re-enter_password_screen.dart';
import 'package:root2route/components/auth_header.dart';
import 'package:root2route/components/custom_button.dart';

class VerificationScreen extends StatefulWidget {
  static const String id = '/VerificationScreen';
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  static const Color green = Color(0xFF2ECC71);

  //Timer? _timer;
  int secondsLeft = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 150),
            const AuthHeader(
              title: 'Verification Code',
              description: 'Enter the 4-digit code we sent to your email',
              icon: Icons.verified_outlined,
            ),

            const SizedBox(height: 10),
            OtpField(),

            const SizedBox(height: 26),

            CustomButton(
              text: 'Verify',
              onPressed:
                  () => Navigator.pushReplacementNamed(
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
                  onPressed: () {},
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
    );
  }
}
