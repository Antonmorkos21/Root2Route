import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:root2route/core/constants.dart';
import 'package:root2route/models/user_model.dart';
import 'package:root2route/services/storage_service.dart';
import 'dart:convert'; // ✅ مهم جداً لاستخدام base64Url و utf8

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  final Dio _dio = Dio();
  final String _defaultOrgId = "3fa85f64-5717-4562-b3fc-2c963f66afa6";

  ApiService._internal() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );

    // إضافة الـ Interceptor لإضافة التوكن تلقائياً لكل الطلبات
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = StorageService().token;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['X-Organization-Id'] = _defaultOrgId;
          return handler.next(options);
        },
      ),
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
      print("Register Success: ${response.data}");
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

      // استخراج البيانات من الرد
      final data = response.data['data'];
      if (data != null) {
        final accessToken = data['accessToken'];
        final fullName = data['fullName'];
        final expireAt = data['expireAt'];

        // استخراج الـ userId من التوكن (أو من الرد إذا كان موجود)
        // بما أن الـ userId موجود في التوكن، هنفكه ونستخرجه
        final userId = _extractUserIdFromToken(accessToken);

        // حفظ البيانات في الـ StorageService
        await StorageService().saveAuthData(
          token: accessToken,
          userId: userId,
          email: userName,
          fullName: fullName ?? '',
          expireAt: expireAt ?? '',
        );

        print("Login Success. Data saved to SharedPreferences.");
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
    }
  }

  // دالة لاستخراج الـ userId من التوكن (JWT)
  String _extractUserIdFromToken(String token) {
    try {
      // فك التوكن (JWT)
      final parts = token.split('.');
      if (parts.length != 3) return '';

      // فك الجزء الثاني (payload)
      String payload = parts[1];
      // إضافة padding إذا لزم الأمر
      while (payload.length % 4 != 0) {
        payload += '=';
      }

      final decodedBytes = Uri.decodeComponent(payload);
      final jsonString = utf8.decode(base64Url.decode(decodedBytes));
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      // البحث عن الـ userId في التوكن
      // حسب الـ claims اللي عندك، الـ userId موجود في 'sub' أو 'nameidentifier'
      return jsonData['sub'] ??
          jsonData['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'] ??
          '';
    } catch (e) {
      print("Error extracting userId from token: $e");
      return '';
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
        data: {"email": email.trim(), "otp": otpCode.trim()},
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
      debugPrint("📧 Requesting OTP for: '${email.trim()}'");
      final response = await _dio.post(
        '/auth/forget-password',
        data: {"email": email.trim().toLowerCase()},
        options: Options(
          headers: {
            "X-Organization-Id": _defaultOrgId,
            "Content-Type": "application/json",
          },
        ),
      );
      return {
        "success": true,
        "message": response.data['message'] ?? "تم إرسال كود التحقق بنجاح",
      };
    } on DioException catch (e) {
      String errorMsg = "فشل إرسال الكود";
      if (e.response?.data is Map) {
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

  Future<Map<String, dynamic>?> analyzeCropImage(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        "ImageFile": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: DioMediaType('image', 'jpeg'),
        ),
      });

      final response = await _dio.post(
        '/model-analysis/analyze',
        data: formData,
        options: Options(
          // التعديل هنا: بنخلي Dio يقبل كود 400 وما يرميش Error
          validateStatus: (status) => status! < 501,
          headers: {
            "X-Organization-Id": _defaultOrgId,
            "accept": "*/*",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      // بنرجع الداتا لو السيرفر رد بـ 200 أو 400
      if (response.data is Map<String, dynamic>) {
        return response.data;
      }

      return null;
    } on DioException catch (e) {
      debugPrint("AI SERVER ERROR: ${e.response?.data}");
      return null;
    } catch (e) {
      debugPrint("Unexpected Error: $e");
      return null;
    }
  }
  //   Future<void> logout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('auth_token');

  //   _tempToken = null;

  //   print("User logged out and token cleared.");
  // }

  //creat organization
  Future<Map<String, dynamic>> createOrganization({
    required String name,
    required String description,
    required String address,
    required String contactEmail,
    required String contactPhone,
    required int type,
    File? logo,
  }) async {
    try {
      // جلب الـ ownerId من التخزين (المستخدم اللي عامل login)
      final ownerId = StorageService().userId;

      if (ownerId == null || ownerId.isEmpty) {
        throw Exception("User not logged in");
      }

      print("📦 Creating organization with ownerId: $ownerId");

      // إنشاء FormData
      final formData = FormData.fromMap({
        'OwnerId': ownerId,
        'Name': name,
        'Description': description,
        'Address': address,
        'ContactEmail': contactEmail,
        'ContactPhone': contactPhone,
        'Type': type,
        if (logo != null)
          'Logo': await MultipartFile.fromFile(
            logo.path,
            filename: 'logo_${DateTime.now().millisecondsSinceEpoch}.png',
          ),
      });

      final response = await _dio.post(
        '/organizations',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      print("✅ Organization created successfully: ${response.data}");

      return {
        "success": true,
        "data": response.data,
        "message": "تم إنشاء المنظمة بنجاح",
      };
    } on DioException catch (e) {
      print("❌ Error creating organization: ${e.response?.data}");

      String errorMsg = "فشل إنشاء المنظمة";
      if (e.response?.data is Map) {
        errorMsg = e.response?.data['message'] ?? errorMsg;
      } else if (e.response?.data is String) {
        errorMsg = e.response?.data;
      }

      return {"success": false, "message": errorMsg};
    } catch (e) {
      print("❌ Unexpected error: $e");
      return {"success": false, "message": "حدث خطأ غير متوقع: $e"};
    }
  }

  // الحصول على التوكن المخزن
  String? getToken() {
    return StorageService().token;
  }

  // الحصول على معرف المستخدم (owner id)
  String? getUserId() {
    return StorageService().userId;
  }

  // التحقق من حالة تسجيل الدخول
  bool isLoggedIn() {
    return StorageService().isLoggedIn;
  }

  Future<void> logout() async {
    await StorageService().logout();
    print("User logged out and token cleared.");
  }
}
