import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:root2route/Screen/auth/re-enter_password.dart';
import 'package:root2route/widgets/auth_header.dart';
import 'package:root2route/widgets/custom_button.dart';

class Otp extends StatefulWidget {
  static const String routeName = '/otp';
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<Otp> {
  static const Color green = Color(0xFF2ECC71);

  final _c1 = TextEditingController();
  final _c2 = TextEditingController();
  final _c3 = TextEditingController();
  final _c4 = TextEditingController();

  final _f1 = FocusNode();
  final _f2 = FocusNode();
  final _f3 = FocusNode();
  final _f4 = FocusNode();

  Timer? _timer;
  int secondsLeft = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();

    _c1.addListener(_refresh);
    _c2.addListener(_refresh);
    _c3.addListener(_refresh);
    _c4.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => secondsLeft = 30);

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft == 0) {
        t.cancel();
      } else {
        setState(() => secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    _c1.removeListener(_refresh);
    _c2.removeListener(_refresh);
    _c3.removeListener(_refresh);
    _c4.removeListener(_refresh);

    _c1.dispose();
    _c2.dispose();
    _c3.dispose();
    _c4.dispose();

    _f1.dispose();
    _f2.dispose();
    _f3.dispose();
    _f4.dispose();

    super.dispose();
  }

  String get otp => "${_c1.text}${_c2.text}${_c3.text}${_c4.text}";
  bool get isOtpComplete => RegExp(r'^\d{4}$').hasMatch(otp);

  void _verifyOtp() {
    // TODO: verify logic using otp
    // مثال:
    // print("OTP = $otp");
  }

  void _resendOtp() {
    // TODO: resend logic
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthHeader(
                  title: 'Verification Code',
                  description: 'Enter the 4-digit code we sent to your email',
                  icon: Icons.verified_outlined,
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _otpBox(_c1, _f1, next: _f2),
                    _otpBox(_c2, _f2, prev: _f1, next: _f3),
                    _otpBox(_c3, _f3, prev: _f2, next: _f4),
                    _otpBox(_c4, _f4, prev: _f3),
                  ],
                ),

                const SizedBox(height: 26),

                CustomButton(
                  text: 'Verify',
                  onPressed:
                      () => Navigator.pushNamed(
                        context,
                        ReEnterPassword.routeName,
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
                      onPressed: secondsLeft > 0 ? null : _resendOtp,
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
    );
  }

  Widget _otpBox(
    TextEditingController controller,
    FocusNode focusNode, {
    FocusNode? next,
    FocusNode? prev,
  }) {
    return SizedBox(
      width: 70,
      height: 60,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        cursorColor: green,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        inputFormatters: const [],
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFF4F4F4),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: green, width: 1.5),
          ),
        ),
        onChanged: (v) {
          if (v.isNotEmpty) {
            if (next != null) FocusScope.of(context).requestFocus(next);
          } else {
            if (prev != null) FocusScope.of(context).requestFocus(prev);
          }
        },
      ),
    );
  }
}
