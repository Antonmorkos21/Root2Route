import 'package:flutter/material.dart';
import 'package:root2route/Screen/auth/forgot_password.dart';
import 'package:root2route/Screen/auth/register.dart';
import 'package:root2route/widgets/auth_header.dart';
import 'package:root2route/widgets/custom_button.dart';
import 'package:root2route/widgets/custom_text_field.dart';

class Login extends StatefulWidget {
  static const String routeName = '/login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthHeader(
                  title: 'Welcome Back',
                  description: 'Sign in to continue',
                  icon: Icons.spa,
                ),

                const SizedBox(height: 30),

                CustomTextField(
                  icon: Icons.email_outlined,
                  label: 'Email Address',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 15),

                CustomTextField(
                  icon: Icons.lock_outline,
                  label: 'Password',
                  controller: passwordController,
                  isPassword: true,
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed:
                        () => Navigator.pushNamed(
                          context,
                          ForgotPassword.routeName,
                        ),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF2ECC71),
                    ),
                    child: const Text('Forgot password?'),
                  ),
                ),

                const SizedBox(height: 15),

                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    // TODO: login logic
                  },
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don’t have an account? '),
                    TextButton(
                      onPressed:
                          () => Navigator.pushNamed(
                            context,
                            Register.routeName,
                          ),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF2ECC71),
                      ),
                      child: const Text('Create account'),
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
}
