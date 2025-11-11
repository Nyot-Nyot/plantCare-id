import 'package:flutter/material.dart';

/// App typography tokens — aligned with docs/ux-spec.md
class AppTextStyles {
  AppTextStyles._();

  /// h1: 24sp SemiBold
  static const h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: null,
  );

  /// h2: 20sp SemiBold
  static const h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: null,
  );

  /// h3: 16sp Medium
  static const h3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: null,
  );

  /// body: 14sp Regular
  static const body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: null,
  );

  /// caption: 12sp Regular
  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: null,
  );
}
