import 'package:flutter/foundation.dart';
import '../services/storage_service.dart';

class SettingsProvider with ChangeNotifier {
  bool _hasCompletedOnboarding = false;
  bool _isInitialized = false;
  
  // Data collection consent toggles
  bool _stepCounterEnabled = true;
  bool _sleepTrackingEnabled = true;
  bool _heartRateEnabled = true;
  bool _hydrationEnabled = true;
  bool _nutritionEnabled = true;
  bool _mentalWellnessEnabled = true;
  bool _workoutEnabled = true;
  bool _vitalSignsEnabled = true;

  bool get hasCompletedOnboarding => _hasCompletedOnboarding;
  bool get isInitialized => _isInitialized;
  bool get stepCounterEnabled => _stepCounterEnabled;
  bool get sleepTrackingEnabled => _sleepTrackingEnabled;
  bool get heartRateEnabled => _heartRateEnabled;
  bool get hydrationEnabled => _hydrationEnabled;
  bool get nutritionEnabled => _nutritionEnabled;
  bool get mentalWellnessEnabled => _mentalWellnessEnabled;
  bool get workoutEnabled => _workoutEnabled;
  bool get vitalSignsEnabled => _vitalSignsEnabled;

  SettingsProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    _hasCompletedOnboarding = await StorageService.getOnboardingComplete();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _hasCompletedOnboarding = true;
    await StorageService.setOnboardingComplete(true);
    notifyListeners();
  }

  Future<void> resetOnboarding() async {
    _hasCompletedOnboarding = false;
    await StorageService.setOnboardingComplete(false);
    notifyListeners();
  }

  void toggleStepCounter(bool value) {
    _stepCounterEnabled = value;
    notifyListeners();
  }

  void toggleSleepTracking(bool value) {
    _sleepTrackingEnabled = value;
    notifyListeners();
  }

  void toggleHeartRate(bool value) {
    _heartRateEnabled = value;
    notifyListeners();
  }

  void toggleHydration(bool value) {
    _hydrationEnabled = value;
    notifyListeners();
  }

  void toggleNutrition(bool value) {
    _nutritionEnabled = value;
    notifyListeners();
  }

  void toggleMentalWellness(bool value) {
    _mentalWellnessEnabled = value;
    notifyListeners();
  }

  void toggleWorkout(bool value) {
    _workoutEnabled = value;
    notifyListeners();
  }

  void toggleVitalSigns(bool value) {
    _vitalSignsEnabled = value;
    notifyListeners();
  }

  Future<void> exportData() async {
    final jsonData = await StorageService.exportAllData();
    // In a real app, this would trigger a file download or share dialog
    debugPrint('Exported data: $jsonData');
  }

  Future<void> deleteAllData() async {
    await StorageService.clearAllData();
    notifyListeners();
  }
}
