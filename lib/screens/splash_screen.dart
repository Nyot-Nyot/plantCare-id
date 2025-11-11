import 'package:flutter/material.dart';

import '../theme/colors.dart';

/// Splash screen implemented to match Figma design:
/// - White background
/// - Centered rounded green square with leaf icon
/// - Title "Tanam.in" and subtitle
/// - Version text at the bottom
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward().whenComplete(() {
      if (mounted) Navigator.of(context).pushReplacementNamed('/auth');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: FadeTransition(
        opacity: _opacity,
        child: SafeArea(
          child: Stack(
            children: [
              // Centered main content
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon container
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.08),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.eco_outlined,
                        color: AppColors.onPrimary,
                        size: 42,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Title uses theme headlineLarge
                    Text(
                      'Tanam.in',
                      style: textTheme.headlineLarge?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Kenali & Rawat Tanamanmu 🌿',
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Version at the bottom center
              Positioned(
                left: 0,
                right: 0,
                bottom: 12,
                child: Center(
                  child: Text(
                    'Version 0.1.5',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.muted,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
