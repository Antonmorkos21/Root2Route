import 'package:flutter/material.dart';
import 'package:root2route/screens/auth/create_new_password.dart';
import 'package:root2route/screens/auth/forgot_password_screen.dart';
import 'package:root2route/screens/auth/register_screen.dart';
import 'package:root2route/screens/auth/recovery_screen.dart';
import 'package:root2route/screens/guest/guest_home_screen.dart';
import 'package:root2route/screens/auth/login_screen.dart';
import 'package:root2route/screens/guest/products_screen.dart';
import 'package:root2route/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة خدمة التخزين
  await StorageService().init();

  // التحقق من حالة تسجيل الدخول لتحديد الشاشة الافتتاحية
  final isLoggedIn = StorageService().isLoggedIn;
  final startScreen = isLoggedIn ? GuestHomeScreen.id : LoginScreen.id;

  runApp(MyApp(startScreen: startScreen));
}

class MyApp extends StatelessWidget {
  final String startScreen;
  const MyApp({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      initialRoute: startScreen,
      routes: {
        LoginScreen.id: (_) => const LoginScreen(),
        RegisterScreen.id: (_) => const RegisterScreen(),
        ForgotPasswordScreen.id: (_) => const ForgotPasswordScreen(),
        CreateNewPassword.id: (_) => const CreateNewPassword(),
        RecoveryScreen.id: (_) => const RecoveryScreen(),
        GuestHomeScreen.id: (_) => const GuestHomeScreen(),
        ProductsScreen.id: (_) => const ProductsScreen(),
      },
    );
  }
}
