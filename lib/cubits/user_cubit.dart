import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:root2route/core/api/api_consumer.dart';
import 'package:root2route/cubits/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final ApiConsumer api;
  UserCubit({required this.api}) : super(UserInitial());

  // Login Form
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  // Register Form
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
}
