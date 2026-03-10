import 'package:flutter/material.dart';

enum HealthCategoryType {
  physicalActivity,
  heartHealth,
  sleepTracking,
  hydration,
  mentalWellness,
  nutrition,
  exerciseWorkouts,
  vitalSigns,
}

class HealthCategory {
  final HealthCategoryType type;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> dataCollected;
  bool isEnabled;

  HealthCategory({
    required this.type,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.dataCollected,
    this.isEnabled = false,
  });

  static List<HealthCategory> getAllCategories() {
    return [
      HealthCategory(
        type: HealthCategoryType.physicalActivity,
        name: 'Physical Activity',
        description: 'Track steps, distance, and calories burned',
        icon: Icons.directions_walk,
        color: const Color(0xFF7C4DFF),
        dataCollected: ['Step count', 'Distance walked', 'Calories burned', 'Active minutes'],
      ),
      HealthCategory(
        type: HealthCategoryType.heartHealth,
        name: 'Heart Health',
        description: 'Monitor heart rate and cardiovascular wellness',
        icon: Icons.favorite_border,
        color: const Color(0xFFE91E63),
        dataCollected: ['Heart rate (BPM)', 'Resting heart rate', 'Heart rate variability'],
      ),
      HealthCategory(
        type: HealthCategoryType.sleepTracking,
        name: 'Sleep Tracking',
        description: 'Analyze sleep patterns and quality',
        icon: Icons.bedtime_outlined,
        color: const Color(0xFF673AB7),
        dataCollected: ['Sleep duration', 'Sleep stages', 'Wake times', 'Sleep quality score'],
      ),
      HealthCategory(
        type: HealthCategoryType.hydration,
        name: 'Hydration',
        description: 'Track daily water intake',
        icon: Icons.water_drop_outlined,
        color: const Color(0xFF03A9F4),
        dataCollected: ['Water intake (ml)', 'Hydration reminders'],
      ),
      HealthCategory(
        type: HealthCategoryType.mentalWellness,
        name: 'Mental Wellness',
        description: 'Monitor mood and stress levels',
        icon: Icons.psychology_outlined,
        color: const Color(0xFF009688),
        dataCollected: ['Mood entries', 'Stress level', 'Meditation minutes'],
      ),
      HealthCategory(
        type: HealthCategoryType.nutrition,
        name: 'Nutrition',
        description: 'Log meals and track calories',
        icon: Icons.restaurant_outlined,
        color: const Color(0xFFFF5722),
        dataCollected: ['Meal logs', 'Calorie intake', 'Macronutrients'],
      ),
      HealthCategory(
        type: HealthCategoryType.exerciseWorkouts,
        name: 'Exercise & Workouts',
        description: 'Record workouts and track progress',
        icon: Icons.fitness_center,
        color: const Color(0xFF2196F3),
        dataCollected: ['Workout type', 'Duration', 'Intensity', 'Sets & Reps'],
      ),
      HealthCategory(
        type: HealthCategoryType.vitalSigns,
        name: 'Vital Signs',
        description: 'Track temperature and blood pressure',
        icon: Icons.thermostat_outlined,
        color: const Color(0xFFF44336),
        dataCollected: ['Body temperature', 'Blood pressure', 'Oxygen saturation'],
      ),
    ];
  }

  HealthCategory copyWith({bool? isEnabled}) {
    return HealthCategory(
      type: type,
      name: name,
      description: description,
      icon: icon,
      color: color,
      dataCollected: dataCollected,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.index,
      'isEnabled': isEnabled,
    };
  }

  static HealthCategory fromJson(Map<String, dynamic> json, HealthCategory template) {
    return template.copyWith(isEnabled: json['isEnabled'] ?? false);
  }
}
