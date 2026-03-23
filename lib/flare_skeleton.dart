/// A beautiful shimmer skeleton loading library for Flutter.
///
/// ## Quick Start
///
/// ```dart
/// import 'package:flare_skeleton/flare_skeleton.dart';
///
/// // Basic skeleton
/// FlareSkeleton(width: 200, height: 16)
///
/// // Circle (avatar)
/// FlareSkeleton.circle(size: 48)
///
/// // Pre-built components
/// SkeletonListTile()
/// SkeletonCard()
/// SkeletonParagraph(lines: 4)
///
/// // Loader wrapper
/// SkeletonLoader(
///   isLoading: _loading,
///   skeleton: SkeletonListTile(),
///   child: MyWidget(),
/// )
/// ```
library flare_skeleton;

export 'src/flare_skeleton.dart';
export 'src/skeleton_theme.dart';
export 'src/skeleton_components.dart';
