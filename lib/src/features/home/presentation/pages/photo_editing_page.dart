import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_editor_plus/data/image_item.dart';
import 'package:image_editor_plus/data/layer.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/layers_viewer.dart';
import 'package:image_editor_plus/loading_screen.dart';
import 'package:image_editor_plus/options.dart';
import 'package:image_picker/image_picker.dart';

import 'package:celebrare/src/features/home/presentation/widgets/screenshot.dart';

class PhotoEditingPage extends StatelessWidget {
  const PhotoEditingPage({super.key, required this.imgBytes});
  final Uint8List imgBytes;

  @override
  Widget build(BuildContext context) {
    return SingleImageEditor(image: imgBytes);
  }
}

class SingleImageEditor extends StatefulWidget {
  final dynamic image;
  final String? savePath;
  // final o.OutputFormat outputFormat;
  final CropOption? cropOption;
  final FlipOption? flipOption;
  final RotateOption? rotateOption;

  const SingleImageEditor({
    super.key,
    this.image,
    this.savePath,
    // this.outputFormat = OutputFormat.jpeg,
    this.cropOption = const CropOption(),
    this.flipOption = const FlipOption(),
    this.rotateOption = const RotateOption(),
  });

  @override
  createState() => _SingleImageEditorState();
}

class _SingleImageEditorState extends State<SingleImageEditor> {
  ImageItem currentImage = ImageItem();

  // PermissionStatus galleryPermission = PermissionStatus.permanentlyDenied,
  //     cameraPermission = PermissionStatus.permanentlyDenied;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void dispose() {
    layers.clear();
    super.dispose();
  }

  List<Widget> get filterActions {
    return [
      const BackButton(),
      SizedBox(
        width: MediaQuery.of(context).size.width - 48,
        child: const SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            // write top icons here
          ]),
        ),
      ),
    ];
  }

  @override
  void initState() {
    if (widget.image != null) {
      loadImage(widget.image!);
    }
    super.initState();
  }

  double flipValue = 0;
  int rotateValue = 0;

  double x = 0;
  double y = 0;
  double z = 0;

  double lastScaleFactor = 1, scaleFactor = 1;
  double widthRatio = 1, heightRatio = 1, pixelRatio = 1;

  resetTransformation() {
    scaleFactor = 1;
    x = 0;
    y = 0;
    setState(() {});
  }

  Future<Uint8List?> getMergedImage([
    OutputFormat format = OutputFormat.png,
  ]) async {
    Uint8List? image;

    if (flipValue != 0 || rotateValue != 0 || layers.length > 1) {
      image = await screenshotController.capture(pixelRatio: pixelRatio);
    } else if (layers.length == 1) {
      if (layers.first is BackgroundLayerData) {
        image = (layers.first as BackgroundLayerData).image.bytes;
      } else if (layers.first is ImageLayerData) {
        image = (layers.first as ImageLayerData).image.bytes;
      }
    }

    // conversion for non-png
    if (image != null && format == OutputFormat.jpeg) {
      var decodedImage = img.decodeImage(image);

      if (decodedImage == null) {
        throw Exception('Unable to decode image for conversion.');
      }

      return img.encodeJpg(decodedImage);
    }

    return image;
  }

  @override
  Widget build(BuildContext context) {
    viewportSize = MediaQuery.of(context).size;
    pixelRatio = MediaQuery.of(context).devicePixelRatio;

    // widthRatio = currentImage.width / viewportSize.width;
    // heightRatio = currentImage.height / viewportSize.height;
    // pixelRatio = math.max(heightRatio, widthRatio);

    return Theme(
      data: ImageEditor.theme,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  resetTransformation();
                  var loadingScreen = showLoadingScreen(context);
                  var mergedImage = await getMergedImage();
                  loadingScreen.hide();

                  if (!mounted) return;

                  Uint8List? croppedImage = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageCropper(
                        image: mergedImage!,
                        reversible: widget.cropOption!.reversible,
                        availableRatios: widget.cropOption!.ratios,
                      ),
                    ),
                  );

                  if (croppedImage == null) return;

                  flipValue = 0;
                  rotateValue = 0;

                  await currentImage.load(croppedImage);
                  setState(() {});
                },
                icon: const Icon(Icons.crop)),
            IconButton(
              onPressed: () {
                setState(() {
                  flipValue = flipValue == 0 ? math.pi : 0;
                });
              },
              icon: Icon(Icons.flip),
            ),
            IconButton(
                onPressed: () {
                  var t = currentImage.width;
                  currentImage.width = currentImage.height;
                  currentImage.height = t;

                  rotateValue++;
                  setState(() {});
                },
                icon: Icon(Icons.rotate_right)),
          ],
        ),
        body: Stack(children: [
          Center(
            child: SizedBox(
              height: currentImage.height.toDouble(),
              width: currentImage.width.toDouble(),
              child: Screenshot(
                controller: screenshotController,
                child: RotatedBox(
                  quarterTurns: rotateValue,
                  child: Transform(
                    transform: Matrix4(
                      1,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                      x,
                      y,
                      0,
                      1,
                    )..rotateY(flipValue),
                    alignment: FractionalOffset.center,
                    child: LayersViewer(
                      layers: layers,
                      onUpdate: () {
                        setState(() {});
                      },
                      editable: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  final picker = ImagePicker();

  Future<void> loadImage(dynamic imageFile) async {
    await currentImage.load(imageFile);

    layers.clear();

    layers.add(BackgroundLayerData(
      image: currentImage,
    ));

    setState(() {});
  }
}




//  ProImageEditor.file(
//         File(path),
//         configs: const ProImageEditorConfigs(
//           textEditorConfigs: TextEditorConfigs(
//             enabled: false,
//           ),
//           paintEditorConfigs: PaintEditorConfigs(
//             enabled: false,
//           ),
//           tuneEditorConfigs: TuneEditorConfigs(
//             enabled: false,
//           ),
//           filterEditorConfigs: FilterEditorConfigs(
//             enabled: false,
//           ),
//           blurEditorConfigs: BlurEditorConfigs(
//             enabled: false,
//           ),
//           emojiEditorConfigs: EmojiEditorConfigs(
//             enabled: false,
//           ),
//         ),
//         callbacks: ProImageEditorCallbacks(
//           onImageEditingComplete: (Uint8List bytes) async {
//             Navigator.pop(context);
//           },
//         ),
//       ),