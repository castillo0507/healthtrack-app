class HealthEntry {
  final String id;
  final String categoryType;
  final DateTime timestamp;
  final Map<String, dynamic> data;

  HealthEntry({
    required this.id,
    required this.categoryType,
    required this.timestamp,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryType': categoryType,
      'timestamp': timestamp.toIso8601String(),
      'data': data,
    };
  }

  factory HealthEntry.fromJson(Map<String, dynamic> json) {
    return HealthEntry(
      id: json['id'],
      categoryType: json['categoryType'],
      timestamp: DateTime.parse(json['timestamp']),
      data: Map<String, dynamic>.from(json['data']),
    );
  }
}

class DailyHealthSummary {
  final DateTime date;
  final int steps;
  final double caloriesBurned;
  final double waterIntake;
  final double sleepHours;
  final int heartRate;
  final int restingHeartRate;
  final double temperature;
  final int systolicBP;
  final int diastolicBP;
  final int nutritionCalories;
  final String mood;
  final int stressLevel;
  final int meditationMinutes;
  final int workoutMinutes;
  final String workoutType;
  final double progress;

  DailyHealthSummary({
    required this.date,
    this.steps = 0,
    this.caloriesBurned = 0,
    this.waterIntake = 0,
    this.sleepHours = 0,
    this.heartRate = 0,
    this.restingHeartRate = 0,
    this.temperature = 0,
    this.systolicBP = 0,
    this.diastolicBP = 0,
    this.nutritionCalories = 0,
    this.mood = 'Not tracked',
    this.stressLevel = 0,
    this.meditationMinutes = 0,
    this.workoutMinutes = 0,
    this.workoutType = '',
    this.progress = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'steps': steps,
      'caloriesBurned': caloriesBurned,
      'waterIntake': waterIntake,
      'sleepHours': sleepHours,
      'heartRate': heartRate,
      'restingHeartRate': restingHeartRate,
      'temperature': temperature,
      'systolicBP': systolicBP,
      'diastolicBP': diastolicBP,
      'nutritionCalories': nutritionCalories,
      'mood': mood,
      'stressLevel': stressLevel,
      'meditationMinutes': meditationMinutes,
      'workoutMinutes': workoutMinutes,
      'workoutType': workoutType,
      'progress': progress,
    };
  }

  factory DailyHealthSummary.fromJson(Map<String, dynamic> json) {
    return DailyHealthSummary(
      date: DateTime.parse(json['date']),
      steps: json['steps'] ?? 0,
      caloriesBurned: (json['caloriesBurned'] ?? 0).toDouble(),
      waterIntake: (json['waterIntake'] ?? 0).toDouble(),
      sleepHours: (json['sleepHours'] ?? 0).toDouble(),
      heartRate: json['heartRate'] ?? 0,
      restingHeartRate: json['restingHeartRate'] ?? 0,
      temperature: (json['temperature'] ?? 0).toDouble(),
      systolicBP: json['systolicBP'] ?? 0,
      diastolicBP: json['diastolicBP'] ?? 0,
      nutritionCalories: json['nutritionCalories'] ?? 0,
      mood: json['mood'] ?? 'Not tracked',
      stressLevel: json['stressLevel'] ?? 0,
      meditationMinutes: json['meditationMinutes'] ?? 0,
      workoutMinutes: json['workoutMinutes'] ?? 0,
      workoutType: json['workoutType'] ?? '',
      progress: (json['progress'] ?? 0).toDouble(),
    );
  }

  DailyHealthSummary copyWith({
    DateTime? date,
    int? steps,
    double? caloriesBurned,
    double? waterIntake,
    double? sleepHours,
    int? heartRate,
    int? restingHeartRate,
    double? temperature,
    int? systolicBP,
    int? diastolicBP,
    int? nutritionCalories,
    String? mood,
    int? stressLevel,
    int? meditationMinutes,
    int? workoutMinutes,
    String? workoutType,
    double? progress,
  }) {
    return DailyHealthSummary(
      date: date ?? this.date,
      steps: steps ?? this.steps,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      waterIntake: waterIntake ?? this.waterIntake,
      sleepHours: sleepHours ?? this.sleepHours,
      heartRate: heartRate ?? this.heartRate,
      restingHeartRate: restingHeartRate ?? this.restingHeartRate,
      temperature: temperature ?? this.temperature,
      systolicBP: systolicBP ?? this.systolicBP,
      diastolicBP: diastolicBP ?? this.diastolicBP,
      nutritionCalories: nutritionCalories ?? this.nutritionCalories,
      mood: mood ?? this.mood,
      stressLevel: stressLevel ?? this.stressLevel,
      meditationMinutes: meditationMinutes ?? this.meditationMinutes,
      workoutMinutes: workoutMinutes ?? this.workoutMinutes,
      workoutType: workoutType ?? this.workoutType,
      progress: progress ?? this.progress,
    );
  }
}
