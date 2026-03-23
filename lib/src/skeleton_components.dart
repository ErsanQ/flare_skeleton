import 'package:flutter/material.dart';
import 'flare_skeleton.dart';
import 'skeleton_theme.dart';

/// Pre-built skeleton for a list tile (avatar + lines)
///
/// ```dart
/// SkeletonListTile()
/// ```
class SkeletonListTile extends StatelessWidget {
  /// Custom theme
  final FlareSkeletonTheme? theme;

  /// Whether to show the leading avatar
  final bool showAvatar;

  /// Whether to show the trailing item
  final bool showTrailing;

  /// Creates a skeleton list tile placeholder.
  const SkeletonListTile({
    super.key,
    this.theme,
    this.showAvatar = true,
    this.showTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          if (showAvatar) ...[
            FlareSkeleton.circle(size: 48, theme: theme),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlareSkeleton(
                    width: double.infinity, height: 14, theme: theme),
                const SizedBox(height: 8),
                FlareSkeleton(width: 180, height: 12, theme: theme),
              ],
            ),
          ),
          if (showTrailing) ...[
            const SizedBox(width: 12),
            FlareSkeleton(width: 40, height: 14, theme: theme),
          ],
        ],
      ),
    );
  }
}

/// Pre-built skeleton for a card (image + text lines)
///
/// ```dart
/// SkeletonCard()
/// ```
class SkeletonCard extends StatelessWidget {
  /// Custom theme
  final FlareSkeletonTheme? theme;

  /// Height of the image placeholder
  final double imageHeight;

  /// Card width
  final double? width;

  /// Creates a skeleton card placeholder.
  const SkeletonCard({
    super.key,
    this.theme,
    this.imageHeight = 180,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlareSkeleton(
            width: double.infinity,
            height: imageHeight,
            borderRadius: 16,
            theme: theme,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlareSkeleton(
                    width: double.infinity, height: 16, theme: theme),
                const SizedBox(height: 8),
                FlareSkeleton(width: 140, height: 12, theme: theme),
                const SizedBox(height: 8),
                FlareSkeleton(width: 80, height: 12, theme: theme),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Pre-built skeleton for a paragraph (multiple text lines)
///
/// ```dart
/// SkeletonParagraph(lines: 4)
/// ```
class SkeletonParagraph extends StatelessWidget {
  /// Number of text lines
  final int lines;

  /// Custom theme
  final FlareSkeletonTheme? theme;

  /// Creates a skeleton paragraph placeholder.
  const SkeletonParagraph({
    super.key,
    this.lines = 3,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(lines, (i) {
        final isLast = i == lines - 1;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: FlareSkeleton(
            width: isLast ? 200 : double.infinity,
            height: 14,
            theme: theme,
          ),
        );
      }),
    );
  }
}

/// Pre-built skeleton for a grid of cards
///
/// ```dart
/// SkeletonGrid(crossAxisCount: 2, itemCount: 4)
/// ```
class SkeletonGrid extends StatelessWidget {
  /// Number of columns
  final int crossAxisCount;

  /// Number of items to show
  final int itemCount;

  /// Custom theme
  final FlareSkeletonTheme? theme;

  /// Creates a skeleton grid placeholder.
  const SkeletonGrid({
    super.key,
    this.crossAxisCount = 2,
    this.itemCount = 4,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: itemCount,
      itemBuilder: (_, __) => SkeletonCard(theme: theme),
    );
  }
}

/// Wrapper that shows skeleton while loading, then fades in real content
///
/// ```dart
/// SkeletonLoader(
///   isLoading: _isLoading,
///   skeleton: SkeletonListTile(),
///   child: MyRealWidget(),
/// )
/// ```
class SkeletonLoader extends StatelessWidget {
  /// Whether to show the skeleton
  final bool isLoading;

  /// Skeleton placeholder widget
  final Widget skeleton;

  /// Real content widget
  final Widget child;

  /// Fade animation duration
  final Duration fadeDuration;

  /// Creates a skeleton loader that switches between skeleton and real content.
  const SkeletonLoader({
    super.key,
    required this.isLoading,
    required this.skeleton,
    required this.child,
    this.fadeDuration = const Duration(milliseconds: 400),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: fadeDuration,
      child: isLoading ? skeleton : child,
    );
  }
}
