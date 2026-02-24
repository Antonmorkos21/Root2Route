import 'package:flutter/material.dart';
import 'package:root2route/screens/auth/forgot_password_screen.dart';
import 'package:root2route/screens/auth/login_screen.dart';
import 'package:root2route/screens/auth/verification_screen.dart';
import 'package:root2route/screens/auth/re-enter_password_screen.dart';
import 'package:root2route/screens/auth/register_screen.dart';

void main() {
  runApp(const MyApp());
}

// void main() => runApp(
//   DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()),
// );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (_) => const LoginScreen(),
        RegisterScreen.id: (_) => const RegisterScreen(),
        ForgotPasswordScreen.id: (_) => const ForgotPasswordScreen(),
        VerificationScreen.id: (_) => const VerificationScreen(),
        ReEnterPasswordScreen.id: (_) => const ReEnterPasswordScreen(),
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: productsScreen(),
//     );
//   }
// }
