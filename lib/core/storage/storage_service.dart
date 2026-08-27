import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final _secure = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ── Token ─────────────────────────────────────────────────────────────────

  Future<void> saveToken(String token) =>
      _secure.write(key: AppConstants.tokenKey, value: token);

  Future<String?> getToken() =>
      _secure.read(key: AppConstants.tokenKey);

  Future<void> saveRefreshToken(String token) =>
      _secure.write(key: AppConstants.refreshTokenKey, value: token);

  Future<String?> getRefreshToken() =>
      _secure.read(key: AppConstants.refreshTokenKey);

  Future<void> clearTokens() async {
    await _secure.delete(key: AppConstants.tokenKey);
    await _secure.delete(key: AppConstants.refreshTokenKey);
  }

  // ── User ──────────────────────────────────────────────────────────────────

  Future<void> saveUser(String userJson) =>
      _prefs.setString(AppConstants.userKey, userJson);

  String? getUser() => _prefs.getString(AppConstants.userKey);

  Future<void> removeUser() => _prefs.remove(AppConstants.userKey);

  // ── General ───────────────────────────────────────────────────────────────

  Future<void> clear() async {
    await _secure.deleteAll();
    await _prefs.clear();
  }

  bool get isLoggedIn => _prefs.containsKey(AppConstants.userKey);
}
