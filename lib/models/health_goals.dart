class HealthGoals {
  int stepsGoal;
  double waterGoal; // in liters
  double sleepGoal; // in hours
  int caloriesGoal;
  int workoutMinutesGoal;
  int heartRateMin;
  int heartRateMax;
  double temperatureMin;
  double temperatureMax;

  HealthGoals({
    this.stepsGoal = 10000,
    this.waterGoal = 2.5,
    this.sleepGoal = 8.0,
    this.caloriesGoal = 2000,
    this.workoutMinutesGoal = 30,
    this.heartRateMin = 60,
    this.heartRateMax = 100,
    this.temperatureMin = 97.0,
    this.temperatureMax = 99.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'stepsGoal': stepsGoal,
      'waterGoal': waterGoal,
      'sleepGoal': sleepGoal,
      'caloriesGoal': caloriesGoal,
      'workoutMinutesGoal': workoutMinutesGoal,
      'heartRateMin': heartRateMin,
      'heartRateMax': heartRateMax,
      'temperatureMin': temperatureMin,
      'temperatureMax': temperatureMax,
    };
  }

  factory HealthGoals.fromJson(Map<String, dynamic> json) {
    return HealthGoals(
      stepsGoal: json['stepsGoal'] ?? 10000,
      waterGoal: (json['waterGoal'] ?? 2.5).toDouble(),
      sleepGoal: (json['sleepGoal'] ?? 8.0).toDouble(),
      caloriesGoal: json['caloriesGoal'] ?? 2000,
      workoutMinutesGoal: json['workoutMinutesGoal'] ?? 30,
      heartRateMin: json['heartRateMin'] ?? 60,
      heartRateMax: json['heartRateMax'] ?? 100,
      temperatureMin: (json['temperatureMin'] ?? 97.0).toDouble(),
      temperatureMax: (json['temperatureMax'] ?? 99.0).toDouble(),
    );
  }
}
