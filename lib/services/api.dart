import 'package:dio/dio.dart';
import 'package:root2route/core/constants.dart';
import 'package:root2route/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String? _tempToken; //تخزين التوكن ف الزاكره

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-Organization-Id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      },
    ),
  );

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

  Future<void> verifyOTP({
    required String email,
    required String otpCode,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/verify-otp',
        data: {"email": email, "otp": otpCode},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();

        if (response.data['data'] != null &&
            response.data['data']['token'] != null) {
          await prefs.setString('auth_token', response.data['data']['token']);
          _tempToken = null;
        } else if (_tempToken != null) {
          await prefs.setString('auth_token', _tempToken!);
          _tempToken = null;
        }
        print("OTP Verified & Token Saved!");
      }
    } on DioException catch (e) {
      String errorMsg = "كود التحقق غير صحيح";

      if (e.response?.data is Map) {
        errorMsg = e.response?.data['message'] ?? errorMsg;
      } else if (e.response?.data is String) {
        errorMsg = e.response?.data;
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
      throw Exception(errorMsg);
    }
  }

  Future<void> resendOTP({required String email}) async {
    try {
      await _dio.post('/auth/resend-otp', data: {"email": email});
    } catch (e) {
      throw Exception("Failed to resend code");
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');

    _tempToken = null;

    print("User logged out and token cleared.");
  }
}



