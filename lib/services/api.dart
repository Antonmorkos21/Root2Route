import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:root2route/core/constants.dart';
import 'package:root2route/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  final Dio _dio = Dio();
  final String _defaultOrgId = "3fa85f64-5717-4562-b3fc-2c963f66afa6";
  String? _tempToken;
  ApiService._internal() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    );
  }

  Future<void> registerUser(UserModel user) async {
    try {
      final response = await _dio.post('/auth/register', data: user.toJson());

      if (response.data['data'] != null) {
        _tempToken = response.data['data']['token'];
        print("Register Success. Temp Token saved in memory.");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print("Server Error (${e.response?.statusCode}): ${e.response?.data}");

        dynamic data = e.response?.data;
        String message = "Something went wrong";

        if (data is Map) {
          message = data['message'] ?? data['msg'] ?? "Error occurred";
        } else if (data is String) {
          message = data;
        }

        throw Exception(message);
      } else {
        throw Exception("No Internet Connection");
      }
      throw Exception(e.response?.data['message'] ?? "Registration failed");
    }
  }

  Future<void> loginUser(String userName, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          "userName": userName,
          "password": password,
          "isRememberMe": true,
        },
      );

      if (response.data['data'] != null) {
        _tempToken = response.data['data']['token'];
      }
    } on DioException catch (e) {
      if (e.response?.data['data'] != null) {
        _tempToken = e.response?.data['data']['token'];
        print("Login partial success. Temp Token captured for OTP.");
      }
      if (e.response != null) {
        print("Server Error (${e.response?.statusCode}): ${e.response?.data}");

        dynamic data = e.response?.data;
        String message = "Something went wrong";

        if (data is Map) {
          message = data['message'] ?? data['msg'] ?? "Error occurred";
        } else if (data is String) {
          message = data;
        }

        throw Exception(message);
      } else {
        throw Exception("No Internet Connection");
      }

      throw Exception(e.response?.data['message'] ?? "Login failed");
    }
  }

  Future<void> resendOTP({required String email}) async {
    try {
      await _dio.post('/auth/resend-otp', data: {"email": email});
    } catch (e) {
      throw Exception("Failed to resend code");
    }
  }

  Future<Map<String, dynamic>> verifyOTP({
    required String email,
    required String otpCode,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/verify-otp',
        data: {
          "email": email.trim(),
          "otp": otpCode.trim(), // جرب تبعته String زي الـ Schema بالظبط
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "X-Organization-Id": _defaultOrgId,
          },
        ),
      );
      return {"success": true, "message": "Success"};
    } on DioException catch (e) {
      debugPrint("🛑 Error Data: ${e.response?.data}");
      return {
        "success": false,
        "message": e.response?.data['message'] ?? "Invalid OTP",
      };
    }
  }

  Future<Map<String, dynamic>> forgetPassword(String email) async {
    try {
      // طباعة للإيميل قبل ما يتبعت عشان تتأكد إنه نظيف
      debugPrint("📧 Requesting OTP for: '${email.trim()}'");

      final response = await _dio.post(
        '/auth/forget-password',
        data: {
          "email":
              email
                  .trim()
                  .toLowerCase(), // تأكدنا إن الـ lowercase بيفرق مع السيرفرات
        },
        options: Options(
          headers: {
            "X-Organization-Id": _defaultOrgId, // الـ ID اللي ثبتناه
            "Content-Type": "application/json",
          },
        ),
      );

      // لو الرد نجح (Status 200/201)
      return {
        "success": true,
        "message": response.data['message'] ?? "تم إرسال كود التحقق بنجاح",
      };
    } on DioException catch (e) {
      // هنا بنعرف السيرفر زعلان من إيه (مثلاً الإيميل مش موجود)
      String errorMsg = "فشل إرسال الكود";

      if (e.response?.data is Map) {
        // لو السيرفر بعت رسالة زي "User not found"
        errorMsg = e.response?.data['message'] ?? errorMsg;
      }

      debugPrint("🛑 Forget Password Server Error: ${e.response?.data}");
      return {"success": false, "message": errorMsg};
    } catch (err) {
      return {"success": false, "message": "حدث خطأ غير متوقع: $err"};
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/reset-password',
        data: {
          "email": email.trim().toLowerCase(),
          "otp": otp.trim(),
          "newPassword": newPassword,
        },
        options: Options(
          headers: {
            "X-Organization-Id": _defaultOrgId,
            "Content-Type": "application/json",
          },
        ),
      );

      return {
        "success": true,
        "message": response.data['message'] ?? "تم تغيير كلمة المرور بنجاح",
      };
    } on DioException catch (e) {
      String errorMsg = "فشل تغيير كلمة المرور";

      if (e.response?.data is Map) {
        errorMsg = e.response?.data['message'] ?? errorMsg;
      }

      debugPrint("🛑 Reset Password Error: ${e.response?.data}");
      return {"success": false, "message": errorMsg};
    } catch (err) {
      return {"success": false, "message": "حدث خطأ غير متوقع: $err"};
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');

    _tempToken = null;

    print("User logged out and token cleared.");
  }
}
