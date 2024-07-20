import 'dart:io';
import 'dart:typed_data';

/// Enum representing different types of image providers.
enum ImgProvider {
  networkImage,
  assetImage,
  fileImage,
  memoryImage,
  svgImageNetwork,
  svgImageFile,
  svgImageAsset,
}

/// Determines the type of image provider based on the given [image] source.
///
/// The [image] can be a [Uint8List] for memory images, or a [String] for network,
/// asset, file, or SVG images.
///
/// Returns the corresponding [ImgProvider] enum value, or null if the image source
/// is invalid or empty.
ImgProvider? getImageProvider(dynamic image) {
  if (image is Uint8List) {
    return ImgProvider.memoryImage;
  }

  if (image is String) {
    if (image.isEmpty) {
      return null;
    }

    if (image.startsWith('http')) {
      if (image.endsWith('.svg')) {
        return ImgProvider.svgImageNetwork;
      } else {
        return ImgProvider.networkImage;
      }
    }

    if (_isFileExists(image)) {
      if (image.endsWith('.svg')) {
        return ImgProvider.svgImageFile;
      } else {
        return ImgProvider.fileImage;
      }
    }

    if (image.endsWith('.svg')) {
      return ImgProvider.svgImageAsset;
    } else {
      return ImgProvider.assetImage;
    }
  }

  return null;
}

/// Checks if a file exists at the given [path].
///
/// Returns true if the file exists, false otherwise.
bool _isFileExists(String path) {
  final directory = File(path);
  return directory.existsSync();
}
