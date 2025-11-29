# App Image

`app_image` is a powerful Flutter package that simplifies image handling with a single, highly customizable widget. It automatically detects and handles all image sources (network, assets, files, memory) and formats (PNG, JPG, SVG) without switching widgets or providers. Features include smooth fade-in animations, customizable placeholders and error widgets, built-in full-screen gallery viewer with swipe navigation, seamless SVG support, and intelligent pre-caching for optimal performance.

<img src="https://github.com/elrizwiraswara/app_image/blob/main/examples.gif?raw=true" alt="Sample">

## Why App Image?

When building Flutter apps, handling images from different sources (network, assets, files, SVG) often requires boilerplate code, manual error handling, and separate implementations for each source type. **App Image** solves these common pain points:

### Problems This Package Solves

- **Repetitive Boilerplate**: No more writing the same placeholder/error handling logic for every image
- **Source Type Switching**: Automatically detects and handles different image sources (network, asset, file, memory, SVG) without changing your code
- **Poor Loading Experience**: Provides smooth fade-in animations and customizable placeholders out of the box
- **No Gallery View**: Built-in full-screen viewer with swipe navigation for image galleries
- **SVG Complexity**: Seamlessly handles SVG images alongside raster formats without conditional logic
- **Performance Issues**: Includes pre-caching capabilities to improve load times

### App Image vs Standard Flutter Widgets

| Feature | App Image | Standard Image Widget |
|---------|-----------|----------------------|
| Auto-detect image source | ✅ Yes | ❌ Manual provider selection |
| Built-in placeholder | ✅ Customizable | ❌ Requires FadeInImage or manual setup |
| Built-in error widget | ✅ Customizable | ❌ Manual ErrorBuilder |
| Fade-in animation | ✅ Built-in | ❌ Requires FadeInImage |
| SVG support | ✅ Automatic | ❌ Separate package & widget |
| Full-screen viewer | ✅ Built-in | ❌ Custom implementation needed |
| Gallery navigation | ✅ Swipe between images | ❌ Build from scratch |
| Pre-caching | ✅ Built-in | ✅ Available but manual setup |
| Single API for all sources | ✅ One widget | ❌ Different widgets/providers |

## Features

- **Fade-in Animations**: Apply smooth fade-in effects with customizable durations and curves to enhance the visual experience.
- **Placeholder and Error Widgets**: Display custom placeholder and error widgets while the image loads or if an error occurs.
- **Full-Screen Image Viewer**: Enable full-screen viewing of images with a simple tap gesture.
- **SVG Support**: Seamlessly handle SVG images from network, asset, and file sources.
- **Pre-caching**: Pre-cache images to improve loading performance and provide a smoother user experience.
- **Automatic Image Provider Selection**: Automatically determine the appropriate image provider based on the image source, with the option to define the `ImgProvider` explicitly if needed.


## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  app_image: any  # Replace with the latest version
```

Then run `flutter pub get` to install the package.

## Usage

### Basic Usage

The simplest way to display an image from any source:

```dart
import 'package:app_image/app_image.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: AppImage(
            image: 'https://example.com/image.jpg',
          ),
        ),
      ),
    );
  }
}
```

### Real-World Use Cases

#### 1. E-commerce Product Gallery

Display product images with smooth loading and full-screen gallery view:

```dart
AppImage(
  image: product.imageUrl,
  allImages: product.allImageUrls, // Swipe through all product images on fullscreen view
  enableFullScreenView: true, // Enable fullscreen view on tap
  width: 200,
  height: 200,
  placeHolderWidget: CircularProgressIndicator(),
  errorWidget: Icon(Icons.shopping_bag, size: 50),
)
```

#### 2. Social Media Profile Picture

Handle user avatars with circular shape and fallback:

```dart
AppImage(
  image: user.avatarUrl ?? 'assets/default_avatar.png',
  width: 50,
  height: 50,
  borderRadius: BorderRadius.circular(100),
  placeHolderWidget: CircularProgressIndicator(strokeWidth: 2),
  errorWidget: Icon(Icons.person, size: 30),
)
```

#### 3. Chat Media with Full-Screen Preview

Display chat images with tap-to-expand functionality:

```dart
AppImage(
  image: message.imageUrl,
  enableFullScreenView: true,
  width: 250,
  height: 250,
  borderRadius: BorderRadius.circular(12),
  placeHolderWidget: CircularProgressIndicator(),
)
```

#### 4. One Widget, All Image Sources

The same `AppImage` widget automatically handles **any** image source - no need to switch between different widgets or providers:

```dart
// Network images - Auto-detected
AppImage(image: 'https://api.com/photo.jpg')

// Network SVG - Auto-detected
AppImage(image: 'https://example.com/icon.svg')

// Asset images - Auto-detected
AppImage(image: 'assets/banner.png')

// Asset SVG - Auto-detected
AppImage(image: 'assets/logo.svg')

// File paths - Auto-detected
AppImage(image: File('/path/to/image.jpg').path)

// File SVG - Auto-detected
AppImage(image: File('/path/to/logo.svg').path)

// Memory/Uint8List - Auto-detected
AppImage(image: uint8List)
```

**No conditional logic needed!** Just pass the image source and `AppImage` automatically:
- Detects the source type (network, asset, file, memory)
- Determines if it's SVG or raster format
- Selects the appropriate image provider
- Handles loading, errors, and animations consistently

**Need more control?** You can manually specify the provider:

```dart
// Explicitly set the image provider type
AppImage(
  image: 'https://api.com/photo.jpg',
  imgProvider: ImgProvider.networkImage, // Manual override
)

// Available providers:
// - ImgProvider.networkImage
// - ImgProvider.assetImage
// - ImgProvider.fileImage
// - ImgProvider.memoryImage
// - ImgProvider.networkImageSvg
// - ImgProvider.assetImageSvg
// - ImgProvider.fileImageSvg
```

## Full Example
Check out the [example](example) directory for a complete sample app demonstrating the use of the app_image package.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.