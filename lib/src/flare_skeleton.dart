import 'package:flutter/material.dart';
import 'skeleton_theme.dart';

/// A single skeleton loading item with shimmer animation.
///
/// Wrap any loading placeholder with [FlareSkeleton] to add shimmer effect.
///
/// ```dart
/// FlareSkeleton(width: 200, height: 16)
/// ```
class FlareSkeleton extends StatefulWidget {
  /// Width of the skeleton item
  final double? width;

  /// Height of the skeleton item
  final double? height;

  /// Border radius (overrides theme)
  final double? borderRadius;

  /// Make it a circle (for avatars)
  final bool isCircle;

  /// Custom theme (uses adaptive theme if not provided)
  final FlareSkeletonTheme? theme;

  /// Child widget — use for custom shapes
  final Widget? child;

  /// Creates a skeleton loading placeholder with shimmer effect.
  const FlareSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.isCircle = false,
    this.theme,
    this.child,
  });

  /// Circular skeleton (perfect for avatars)
  factory FlareSkeleton.circle({
    Key? key,
    required double size,
    FlareSkeletonTheme? theme,
  }) {
    return FlareSkeleton(
      key: key,
      width: size,
      height: size,
      isCircle: true,
      theme: theme,
    );
  }

  @override
  State<FlareSkeleton> createState() => _FlareSkeletonState();
}

class _FlareSkeletonState extends State<FlareSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    final theme = widget.theme ?? const FlareSkeletonTheme();
    _controller = AnimationController(
      vsync: this,
      duration: theme.duration,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? FlareSkeletonTheme.adaptive(context);
    final radius = widget.isCircle
        ? BorderRadius.circular(9999)
        : BorderRadius.circular(widget.borderRadius ?? theme.borderRadius);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: radius,
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: widget.child ??
                CustomPaint(
                  painter: ShimmerPainter(
                    progress: _animation.value,
                    baseColor: theme.baseColor,
                    highlightColor: theme.highlightColor,
                  ),
                  child: const SizedBox.expand(),
                ),
          ),
        );
      },
    );
  }
}
