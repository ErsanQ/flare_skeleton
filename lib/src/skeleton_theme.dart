import 'package:flutter/material.dart';

/// Theme configuration for skeleton loading
class FlareSkeletonTheme {
  /// Base color of the skeleton
  final Color baseColor;

  /// Highlight color for the shimmer effect
  final Color highlightColor;

  /// Duration of one shimmer cycle
  final Duration duration;

  /// Border radius for skeleton items
  final double borderRadius;

  const FlareSkeletonTheme({
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.duration = const Duration(milliseconds: 1400),
    this.borderRadius = 8,
  });

  /// Dark mode theme
  static const dark = FlareSkeletonTheme(
    baseColor: Color(0xFF2A2A2A),
    highlightColor: Color(0xFF3D3D3D),
  );

  /// Adapts automatically to light/dark mode
  static FlareSkeletonTheme adaptive(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? dark : const FlareSkeletonTheme();
  }

  FlareSkeletonTheme copyWith({
    Color? baseColor,
    Color? highlightColor,
    Duration? duration,
    double? borderRadius,
  }) {
    return FlareSkeletonTheme(
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
      duration: duration ?? this.duration,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}

/// Custom painter that draws the shimmer gradient
class ShimmerPainter extends CustomPainter {
  final double progress;
  final Color baseColor;
  final Color highlightColor;

  ShimmerPainter({
    required this.progress,
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final shimmerX = size.width * (progress * 2 - 0.5);

    final gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [baseColor, highlightColor, baseColor],
      stops: const [0.0, 0.5, 1.0],
    ).createShader(
      Rect.fromLTWH(shimmerX - size.width, 0, size.width * 2, size.height),
    );

    final paint = Paint()..shader = gradient;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(ShimmerPainter old) =>
      old.progress != progress ||
      old.baseColor != baseColor ||
      old.highlightColor != highlightColor;
}
