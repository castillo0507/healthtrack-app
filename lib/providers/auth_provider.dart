import 'package:flutter/foundation.dart';
import '../services/storage_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isInitialized = false;
  String? _userEmail;
  bool _isLoading = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get isInitialized => _isInitialized;
  String? get userEmail => _userEmail;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Check if user was previously logged in
    _isAuthenticated = await StorageService.getIsLoggedIn();
    _userEmail = await StorageService.getUserEmail();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // For demo purposes, accept any valid-looking credentials
    // In a real app, this would validate against a backend
    _isAuthenticated = true;
    _userEmail = email;
    
    await StorageService.setIsLoggedIn(true);
    await StorageService.setUserEmail(email);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // For demo purposes, automatically log in after sign up
    _isAuthenticated = true;
    _userEmail = email;
    
    await StorageService.setIsLoggedIn(true);
    await StorageService.setUserEmail(email);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _userEmail = null;
    
    await StorageService.setIsLoggedIn(false);
    await StorageService.setUserEmail(null);
    
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    // In a real app, this would send a password reset email
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
