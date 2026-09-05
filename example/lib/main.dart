import 'package:app_image/app_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppImage Package Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final networkImages = [
    'https://picsum.photos/500?random=1',
    'https://picsum.photos/500?random=2',
    'https://picsum.photos/500?random=3',
    'https://picsum.photos/500?random=4',
  ];

  String assetImage = 'assets/elriz-logo.jpg';
  dynamic fileImage;
  Uint8List? memoryImage;
  String svgImageNetwork = 'https://svgur.com/i/18Q4.svg';
  String? svgImageFile;
  String svgImageAsset = 'assets/svg-sample.svg';

  Future<void> loadImage() async {
    // Example: Load an image from assets and convert it to Uint8List
    final ByteData data = await rootBundle.load(assetImage);
    memoryImage = data.buffer.asUint8List();
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadImage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('AppImage Package Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            defaultAppImage(),
            const SizedBox(height: 24),
            customAppImage(),
            const SizedBox(height: 24),
            allSupportedImgProviders()
          ],
        ),
      ),
    );
  }

  Widget defaultAppImage() {
    return Wrap(
      spacing: 18,
      runSpacing: 18,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Default',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            const AppImage(
              image: randomImage,
              width: 200,
              height: 200,
              enableFullScreenView: true,
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Default Error Placeholder',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            AppImage(
              image: '',
              width: 200,
              height: 200,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            ),
          ],
        ),
      ],
    );
  }

  Widget customAppImage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Custom',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 18,
          runSpacing: 18,
          children: [
            AppImage(
              image: networkImages[0],
              allImages: networkImages,
              width: 200,
              height: 200,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(18),
              enableFullScreenView: true,
            ),
            AppImage(
              image: networkImages[1],
              allImages: networkImages,
              width: 200,
              height: 200,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              border: Border.all(
                  width: 8, color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(18),
              enableFullScreenView: true,
            ),
            AppImage(
              image: networkImages[2],
              allImages: networkImages,
              width: 300,
              height: 200,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              border: Border(
                left: BorderSide(
                    width: 8, color: Theme.of(context).colorScheme.primary),
                right: BorderSide(
                    width: 8, color: Theme.of(context).colorScheme.primary),
              ),
              borderRadius: BorderRadius.circular(18),
              enableFullScreenView: true,
            ),
            AppImage(
              image: networkImages[3],
              allImages: networkImages,
              width: 300,
              height: 200,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              border: Border(
                  left: BorderSide(
                      width: 8, color: Theme.of(context).colorScheme.primary)),
              borderRadius:
                  const BorderRadius.only(topRight: Radius.circular(54)),
              enableFullScreenView: true,
              fadeInCurve: Curves.easeInOut,
              fadeInDuration: const Duration(seconds: 3),
            ),
          ],
        ),
      ],
    );
  }

  Widget allSupportedImgProviders() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'All Supported Providers',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 18,
          runSpacing: 18,
          children: [
            imageWidget('Network', networkImages.first),
            pickFileImageWidget('File', fileImage),
            imageWidget('Asset', assetImage),
            imageWidget('Memory', memoryImage),
            imageWidget('SVG Image Network', svgImageNetwork),
            pickSvgFileImageWidget('SVG Image File', svgImageFile),
            imageWidget('SVG Image Asset', svgImageAsset),
          ],
        ),
      ],
    );
  }

  Widget pickFileImageWidget(String title, dynamic image) {
    if (image == null) {
      return GestureDetector(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowMultiple: false,
            allowedExtensions: ['jpg', 'jpeg', 'png'],
          );

          // file image is not supported on the web platform
          // use bytes instead
          fileImage = kIsWeb
              ? result?.files.firstOrNull?.bytes
              : result?.files.firstOrNull?.path;
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'Pick File Image',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      );
    }

    return imageWidget(title, image!);
  }

  Widget pickSvgFileImageWidget(String title, dynamic image) {
    if (image == null) {
      return GestureDetector(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowMultiple: false,
            allowedExtensions: ['svg'],
          );

          svgImageFile = result?.files.firstOrNull?.path;
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'Pick SVG Image',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      );
    }

    return imageWidget(title, image!);
  }

  Widget imageWidget(String title, dynamic image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        AppImage(
          image: image,
          width: 200,
          height: 200,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(18),
          enableFullScreenView: true,
        ),
      ],
    );
  }
}
