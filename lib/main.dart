import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root2route/core/api/dio_consumer.dart';
import 'package:root2route/cubits/user_cubit.dart';
import 'package:root2route/screens/auth/forgot_password_screen.dart';
import 'package:root2route/screens/auth/login_screen.dart';
import 'package:root2route/screens/auth/verification_screen.dart';
import 'package:root2route/screens/auth/create_new_password.dart';
import 'package:root2route/screens/auth/register_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => UserCubit(api: DioConsumer(dio: Dio())),
      child: const MyApp(),
    ),
  );
}

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
        CreateNewPassword.id: (_) => const CreateNewPassword(),
      },
    );
  }
}
