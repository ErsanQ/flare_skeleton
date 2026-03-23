# ✨ flare_skeleton

A beautiful shimmer skeleton loading library for Flutter with pre-built components and full customization.

## Preview

![flare_skeleton demo](https://github.com/ErsanQ/flare_skeleton/raw/main/preview.gif)

## Features

- ✨ **Smooth shimmer animation** — fluid left-to-right gradient sweep
- 🌙 **Adaptive dark/light mode** — auto-detects theme
- 🎨 **Fully customizable** — colors, speed, border radius
- 📦 **Pre-built components** — ListTile, Card, Paragraph, Grid
- 🔄 **SkeletonLoader** — animated fade between skeleton and content
- 🚫 **Zero dependencies**

## Installation

```yaml
dependencies:
  flare_skeleton: ^1.0.0
```

## Usage

### Basic

```dart
import 'package:flare_skeleton/flare_skeleton.dart';

// Rectangle
FlareSkeleton(width: 200, height: 16)

// Full width line
FlareSkeleton(width: double.infinity, height: 14)

// Circle (avatar)
FlareSkeleton.circle(size: 48)
```

### Pre-built Components

```dart
// List tile with avatar + lines
SkeletonListTile()

// Card with image + text
SkeletonCard(imageHeight: 180)

// Text paragraph
SkeletonParagraph(lines: 4)

// Grid of cards
SkeletonGrid(crossAxisCount: 2, itemCount: 4)
```

### SkeletonLoader — Fade between skeleton and content

```dart
SkeletonLoader(
  isLoading: _isLoading,
  skeleton: const SkeletonListTile(),
  child: ListTile(
    leading: CircleAvatar(child: Icon(Icons.person)),
    title: Text('John Doe'),
    subtitle: Text('iOS Developer'),
  ),
)
```

### Custom Theme

```dart
FlareSkeleton(
  width: 200,
  height: 16,
  theme: FlareSkeletonTheme(
    baseColor: Colors.blue.shade100,
    highlightColor: Colors.blue.shade50,
    duration: Duration(milliseconds: 1000),
    borderRadius: 12,
  ),
)
```

### Dark Mode

```dart
// Automatic adaptive theme
FlareSkeleton(width: 200, height: 16)  // auto-adapts

// Manual dark theme
FlareSkeleton(
  width: 200,
  height: 16,
  theme: FlareSkeletonTheme.dark,
)
```

## Components Reference

| Component | Description |
|-----------|-------------|
| `FlareSkeleton` | Core shimmer rectangle |
| `FlareSkeleton.circle` | Circle variant for avatars |
| `SkeletonListTile` | Avatar + two text lines |
| `SkeletonCard` | Image + text lines |
| `SkeletonParagraph` | Multiple text lines |
| `SkeletonGrid` | Grid of card skeletons |
| `SkeletonLoader` | Animated content switcher |

## License

MIT
