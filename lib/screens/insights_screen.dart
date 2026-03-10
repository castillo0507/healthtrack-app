import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/health_provider.dart';
import '../models/health_entry.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  String _selectedPeriod = 'Week';

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthProvider>(
      builder: (context, healthProvider, child) {
        final weeklyHistory = healthProvider.weeklyHistory;
        
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: AppBar(
            backgroundColor: const Color(0xFF3366FF),
            title: const Text(
              'Insights',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Period Selector
                Row(
                  children: [
                    _buildPeriodChip('Day'),
                    const SizedBox(width: 8),
                    _buildPeriodChip('Week'),
                    const SizedBox(width: 8),
                    _buildPeriodChip('Month'),
                    const SizedBox(width: 8),
                    _buildPeriodChip('Year'),
                  ],
                ).animate().fadeIn(),
                const SizedBox(height: 24),
                // Steps Chart
                _buildChartCard(
                  context,
                  title: 'Steps Overview',
                  subtitle: 'Daily step count for the past week',
                  chart: _buildStepsChart(weeklyHistory),
                  delay: 200,
                ),
                const SizedBox(height: 20),
                // Sleep Chart
                _buildChartCard(
                  context,
                  title: 'Sleep Patterns',
                  subtitle: 'Hours of sleep per night',
                  chart: _buildSleepChart(weeklyHistory),
                  delay: 400,
                ),
                const SizedBox(height: 20),
                // Heart Rate Chart
                _buildChartCard(
                  context,
                  title: 'Heart Rate Trends',
                  subtitle: 'Average resting heart rate',
                  chart: _buildHeartRateChart(weeklyHistory),
                  delay: 600,
                ),
                const SizedBox(height: 20),
                // Summary Stats
                _buildSummaryStats(context, weeklyHistory),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPeriodChip(String label) {
    final isSelected = _selectedPeriod == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedPeriod = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3366FF) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF3366FF) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildChartCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Widget chart,
    required int delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: chart,
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).slideY(begin: 0.1);
  }

  Widget _buildStepsChart(List<DailyHealthSummary> weeklyHistory) {
    // Get max steps for dynamic Y axis
    double maxSteps = 10000;
    for (var day in weeklyHistory) {
      if (day.steps > maxSteps) maxSteps = day.steps.toDouble();
    }
    maxSteps = ((maxSteps / 2000).ceil() * 2000).toDouble();
    if (maxSteps < 2000) maxSteps = 2000;
    
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxSteps,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.toInt()} steps',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < weeklyHistory.length) {
                  final date = weeklyHistory[index].date;
                  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  return Text(
                    days[date.weekday - 1],
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${(value / 1000).toInt()}k',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxSteps / 4,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.shade200,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(show: false),
        barGroups: weeklyHistory.asMap().entries.map((entry) {
          return _makeBarGroup(entry.key, entry.value.steps.toDouble());
        }).toList(),
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: const Color(0xFF3366FF),
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    );
  }

  Widget _buildSleepChart(List<DailyHealthSummary> weeklyHistory) {
    // Build spots from actual data
    final spots = <FlSpot>[];
    for (int i = 0; i < weeklyHistory.length; i++) {
      spots.add(FlSpot(i.toDouble(), weeklyHistory[i].sleepHours));
    }
    
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 2,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.shade200,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < weeklyHistory.length) {
                  final date = weeklyHistory[index].date;
                  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  return Text(
                    days[date.weekday - 1],
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}h',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (weeklyHistory.length - 1).toDouble(),
        minY: 0,
        maxY: 12,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  '${spot.y.toStringAsFixed(1)} hrs',
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots.isEmpty ? [const FlSpot(0, 0)] : spots,
            isCurved: true,
            color: const Color(0xFF673AB7),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFF673AB7).withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeartRateChart(List<DailyHealthSummary> weeklyHistory) {
    // Build spots from actual data
    final spots = <FlSpot>[];
    double minHR = 50;
    double maxHR = 100;
    
    for (int i = 0; i < weeklyHistory.length; i++) {
      final hr = weeklyHistory[i].heartRate.toDouble();
      spots.add(FlSpot(i.toDouble(), hr > 0 ? hr : 0));
      if (hr > 0 && hr < minHR) minHR = hr;
      if (hr > maxHR) maxHR = hr;
    }
    
    // Adjust bounds
    minHR = (minHR - 10).clamp(40, 60);
    maxHR = (maxHR + 10).clamp(100, 150);
    
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.shade200,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < weeklyHistory.length) {
                  final date = weeklyHistory[index].date;
                  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  return Text(
                    days[date.weekday - 1],
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (weeklyHistory.length - 1).toDouble(),
        minY: minHR,
        maxY: maxHR,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  '${spot.y.toInt()} BPM',
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots.isEmpty ? [const FlSpot(0, 70)] : spots,
            isCurved: true,
            color: const Color(0xFFE91E63),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFFE91E63).withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStats(BuildContext context, List<DailyHealthSummary> weeklyHistory) {
    // Calculate real averages from weekly history
    int totalSteps = 0;
    double totalSleep = 0;
    int totalHeartRate = 0;
    int activeDays = 0;
    int stepsCount = 0;
    int sleepCount = 0;
    int heartRateCount = 0;
    
    for (var day in weeklyHistory) {
      if (day.steps > 0) {
        totalSteps += day.steps;
        stepsCount++;
        activeDays++;
      }
      if (day.sleepHours > 0) {
        totalSleep += day.sleepHours;
        sleepCount++;
      }
      if (day.heartRate > 0) {
        totalHeartRate += day.heartRate;
        heartRateCount++;
      }
    }
    
    final avgSteps = stepsCount > 0 ? (totalSteps / stepsCount).round() : 0;
    final avgSleep = sleepCount > 0 ? (totalSleep / sleepCount) : 0.0;
    final avgHeartRate = heartRateCount > 0 ? (totalHeartRate / heartRateCount).round() : 0;
    
    // Format steps with comma
    String formatNumber(int number) {
      if (number >= 1000) {
        return '${(number / 1000).toStringAsFixed(1)}k';
      }
      return number.toString();
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Summary',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ).animate().fadeIn(delay: 800.ms),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                'Average Steps',
                avgSteps > 0 ? formatNumber(avgSteps) : '--',
                Icons.directions_walk,
                const Color(0xFF3366FF),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSummaryCard(
                'Avg Sleep',
                avgSleep > 0 ? '${avgSleep.toStringAsFixed(1)} hrs' : '--',
                Icons.bedtime,
                const Color(0xFF673AB7),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 900.ms),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                'Avg Heart Rate',
                avgHeartRate > 0 ? '$avgHeartRate BPM' : '--',
                Icons.favorite,
                const Color(0xFFE91E63),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSummaryCard(
                'Active Days',
                '$activeDays/${weeklyHistory.length}',
                Icons.check_circle,
                const Color(0xFF4CAF50),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 1000.ms),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
