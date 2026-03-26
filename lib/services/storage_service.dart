import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  static const String _keyToken = 'auth_token';
  static const String _keyUserId = 'user_id';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserFullName = 'user_full_name';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyTokenExpiry = 'token_expiry';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // حفظ بيانات المصادقة بعد تسجيل الدخول الناجح
  Future<void> saveAuthData({
    required String token,
    required String userId,
    required String email,
    required String fullName,
    required String expireAt,
  }) async {
    await _prefs.setString(_keyToken, token);
    await _prefs.setString(_keyUserId, userId);
    await _prefs.setString(_keyUserEmail, email);
    await _prefs.setString(_keyUserFullName, fullName);
    await _prefs.setBool(_keyIsLoggedIn, true);
    await _prefs.setString(_keyTokenExpiry, expireAt);
  }

  // الحصول على التوكن
  String? get token => _prefs.getString(_keyToken);

  // الحصول على معرف المستخدم (owner id)
  String? get userId => _prefs.getString(_keyUserId);

  // الحصول على الإيميل
  String? get userEmail => _prefs.getString(_keyUserEmail);

  // الحصول على الاسم الكامل
  String? get userFullName => _prefs.getString(_keyUserFullName);

  // التحقق من حالة تسجيل الدخول
  bool get isLoggedIn => _prefs.getBool(_keyIsLoggedIn) ?? false;

  // الحصول على تاريخ انتهاء التوكن
  String? get tokenExpiry => _prefs.getString(_keyTokenExpiry);

  // تسجيل الخروج - مسح كل البيانات
  Future<void> logout() async {
    await _prefs.remove(_keyToken);
    await _prefs.remove(_keyUserId);
    await _prefs.remove(_keyUserEmail);
    await _prefs.remove(_keyUserFullName);
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyTokenExpiry);
  }

  // التحقق من صلاحية التوكن (اختياري)
  bool get isTokenValid {
    final expiry = tokenExpiry;
    if (expiry == null) return false;

    try {
      final expiryDate = DateTime.parse(expiry);
      return expiryDate.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }
}
