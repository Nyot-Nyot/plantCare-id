import 'package:flutter/material.dart';

import '../theme/colors.dart';

/// A small reusable decorated container used for input fields across the app.
/// Keeps background, border and radius consistent with design tokens.
class DecoratedField extends StatelessWidget {
  final Widget child;
  final double height;
  final double radius;

  const DecoratedField({
    super.key,
    required this.child,
    this.height = 48,
    this.radius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: const Color(0xFFE8F8F5), width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}
