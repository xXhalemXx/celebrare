import 'dart:io';
import 'dart:typed_data';

import 'package:celebrare/src/features/home/presentation/pages/photo_editing_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:celebrare/src/core/constants/constants.dart';
import 'package:celebrare/src/core/helpers/spacing.dart';

class SelectImage extends StatelessWidget {
  const SelectImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: imageUploadBoxDecoration(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Upload Image',
                style: AppTextStyles.loraFont16Gray100ItalicRegular1,
              ),
              verticalSpace(5),
              ElevatedButton(
                onPressed: () {
                  // open gallery
                  pickImage(context);
                },
                child: Text(
                  'Choose from Device',
                  style: AppTextStyles.systemFont15White100RegularLight1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // You can use the image file here
      print('Picked image path: ${image.path}');
      final Uint8List imgBytes = await image.readAsBytes();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoEditingPage(
            imgBytes: imgBytes,
          ),
        ),
      );
    } else {
      print('No image selected.');
    }
  }

  BoxDecoration imageUploadBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(
        10,
      ),
      border: Border.all(color: AppColor.lightGray),
    );
  }
}
