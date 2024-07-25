# App Image

`app_image` is a versatile Flutter package designed to simplify image handling within your applications. It provides a highly customizable `AppImage` widget that supports various image sources, including network URLs, asset paths, file paths, and memory images. This package features fade-in animations, custom placeholder and error widgets, full-screen image viewing, SVG support, and pre-caching capabilities.

<img src="https://github.com/elrizwiraswara/app_image/blob/main/examples.gif?raw=true" alt="Sample">

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
  app_image: ^1.0.8
```

Then run `flutter pub get` to install the package.

## Usage
### Basic Usage

```
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
            placeHolderWidget: CircularProgressIndicator(),
            errorWidget: Icon(Icons.error),
            fadeInDuration: Duration(milliseconds: 300),
            fadeInCurve: Curves.easeIn,
            enableFullScreenView: true,
          ),
        ),
      ),
    );
  }
}
```

### Full-Screen Viewer
To enable full-screen viewing of images:

```
AppImage(
  image: 'https://example.com/image.jpg',
  enableFullScreenView: true,
  allImages: [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
    'https://example.com/image3.jpg',
  ],
);
```

### Custom Placeholder and Error Widgets
You can customize the placeholder and error widgets:

```
AppImage(
  image: 'https://example.com/image.jpg',
  placeHolderWidget: CircularProgressIndicator(),
  errorWidget: Icon(Icons.broken_image),
);
```

### SVG Support
To display SVG images:

```
AppImage(
  image: 'assets/image.svg',
);
```

## Example
Check out the [example](example) directory for a complete sample app demonstrating the use of the app_image package.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

<a href="https://trakteer.id/elrizwiraswara/tip" target="_blank"><img id="wse-buttons-preview" src="https://cdn.trakteer.id/images/embed/trbtn-red-6.png?date=18-11-2023" height="40" style="border:0px;height:40px;margin-top:14px" alt="Trakteer Saya"></a>
