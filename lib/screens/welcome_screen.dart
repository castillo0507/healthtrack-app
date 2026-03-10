import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'category_selection_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Logo
              Container(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  Icons.medical_services_outlined,
                  size: 80,
                  color: const Color(0xFF3366FF),
                ).animate().fadeIn(duration: 500.ms).scale(delay: 200.ms),
              ),
              const SizedBox(height: 16),
              // App Name
              Text(
                'HealTrack',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: const Color(0xFF3366FF),
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 8),
              Text(
                'Your health, your data, your control',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 48),
              // Privacy Features
              _buildFeatureCard(
                context,
                icon: Icons.lock_outline,
                iconColor: const Color(0xFF3366FF),
                title: '100% Private',
                description: 'All data stored locally on your device. We never send your health data to servers.',
                delay: 500,
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                context,
                icon: Icons.toggle_on_outlined,
                iconColor: const Color(0xFF7C4DFF),
                title: 'Full Control',
                description: 'You decide what to track. Enable or disable features anytime without penalty.',
                delay: 600,
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                context,
                icon: Icons.visibility_outlined,
                iconColor: const Color(0xFF00BCD4),
                title: 'Total Transparency',
                description: 'Clear explanations of what we collect, why, and how you can manage it.',
                delay: 700,
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                context,
                icon: Icons.person_outline,
                iconColor: const Color(0xFF4CAF50),
                title: 'Your Consent Matters',
                description: 'Granular opt-in controls. Withdraw consent for any feature instantly.',
                delay: 800,
              ),
              const SizedBox(height: 48),
              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CategorySelectionScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3366FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue to Privacy Settings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 900.ms).slideY(begin: 0.3),
              const SizedBox(height: 16),
              Text(
                'By continuing, you agree to review and customize your privacy preferences',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[500],
                ),
              ).animate().fadeIn(delay: 1000.ms),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required int delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: iconColor.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).slideX(begin: -0.1);
  }
}
