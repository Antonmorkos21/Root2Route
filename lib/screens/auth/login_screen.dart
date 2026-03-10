import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:root2route/components/custom_auth/auth_background.dart';
import 'package:root2route/components/custom_auth/auth_header.dart';
import 'package:root2route/components/custom_button.dart';
import 'package:root2route/components/custom_text_form_field.dart';
import 'package:root2route/core/responsive/app_sizes.dart';
import 'package:root2route/cubits/user_cubit.dart';
import 'package:root2route/cubits/user_state.dart';
import 'package:root2route/screens/auth/forgot_password_screen.dart';
import 'package:root2route/screens/auth/register_screen.dart';
import 'package:root2route/screens/guest/products_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/loginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoginSuccess) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: "Login Successfully",
            showConfirmBtn: false,
          );

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProductsScreen()),
            );
          });
        }

        if (state is UserError) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: state.errmessage,
          );
        }
      },

      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: AuthBackground(
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.paddingSize(context)),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AuthHeader(
                          title: "Welcome to Root2Route",
                          description: "Access your account to continue.",
                          icon: Icons.eco,
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
                                ),
                              ),

                              child: Form(
                                key: context.read<UserCubit>().loginFormKey,
                                child: Column(
                                  children: [
                                    /// Tabs
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.16),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 38,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Text(
                                                "Login",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 8),

                                          Expanded(
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  RegisterScreen.id,
                                                );
                                              },
                                              child: const SizedBox(
                                                height: 38,
                                                child: Center(
                                                  child: Text(
                                                    "New account",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    CustomTextFormField(
                                      icon: Icons.email_outlined,
                                      label: "Email Address",
                                      controller:
                                          context.read<UserCubit>().loginEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your email";
                                        }

                                        if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                        ).hasMatch(value)) {
                                          return "Invalid Email";
                                        }

                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 14),

                                    CustomTextFormField(
                                      icon: Icons.lock_outline,
                                      label: "Password",
                                      controller:
                                          context
                                              .read<UserCubit>()
                                              .loginPassword,
                                      isPassword: true,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter your password";
                                        }

                                        if (value.length < 6) {
                                          return "Password must be at least 6 characters";
                                        }

                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 10),

                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            ForgotPasswordScreen.id,
                                          );
                                        },
                                        child: const Text("Forgot password?"),
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    state is UserLoading
                                        ? CircularProgressIndicator()
                                        : CustomButton(
                                          text: 'Login',
                                          onPressed: () {
                                            //context.read<UserCubit>().login();
                                          },
                                        ),
                                  ],
                                ),
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
          ),
        );
      },
    );
  }
}
