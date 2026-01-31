import 'package:flutter/material.dart';
import 'package:root2route/Screen/auth/forgot_password.dart';
import 'package:root2route/Screen/auth/login.dart';
import 'package:root2route/Screen/auth/otp.dart';
import 'package:root2route/Screen/auth/re-enter_password.dart';
import 'package:root2route/Screen/auth/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      initialRoute: Login.routeName,
      routes: {
        Login.routeName: (_) => const Login(),
        Register.routeName: (_) => const Register(),
        ForgotPassword.routeName: (_) => const ForgotPassword(),
        Otp.routeName: (_) => const Otp(),
        ReEnterPassword.routeName: (_) => const ReEnterPassword(),
      },
    );
  }
}
