import 'package:flutter/material.dart';
import 'package:root2route/components/account_type_button.dart';
import 'package:root2route/components/auth_header.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = '/registerScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  AccountType selectedType = AccountType.defult;

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
                  title: 'Create Account',
                  description: 'Enter your details to create a new account',
                  icon: Icons.person_add_alt_1,
                ),

                const SizedBox(height: 30),

                CustomTextField(
                  label: 'Full Name',
                  controller: nameController,
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 15),

                CustomTextField(
                  icon: Icons.email_outlined,
                  label: 'Email Address',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 18),

                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Account Type',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),

                const SizedBox(height: 10),

                // Account Type Boxes
                Row(
                  children: [
                    AccountTile(
                      text: 'Farmer',
                      icon: Icons.agriculture_outlined,
                      selected: selectedType == AccountType.farmer,
                      onTap: () {
                        setState(() {
                          selectedType = AccountType.farmer;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    AccountTile(
                      text: 'Merchant',
                      icon: Icons.storefront_outlined,
                      selected: selectedType == AccountType.merchant,
                      onTap: () {
                        setState(() {
                          selectedType = AccountType.merchant;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    AccountTile(
                      text: 'Factory',
                      icon: Icons.factory_outlined,
                      selected: selectedType == AccountType.factory,
                      onTap: () {
                        setState(() {
                          selectedType = AccountType.factory;
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Password',
                  controller: passwordController,
                  isPassword: true,
                  icon: Icons.lock_outline,
                ),

                const SizedBox(height: 15),

                CustomTextField(
                  label: 'Confirm Password',
                  controller: confirmPasswordController,
                  isPassword: true,
                  icon: Icons.lock_outline,
                ),

                const SizedBox(height: 25),

                CustomButton(text: 'Register', onPressed: () {}),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF2ECC71),
                      ),
                      child: const Text(' Login'),
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
