import 'dart:developer';
import 'dart:io';

import 'package:camera_functions/image_screen/image_model/image_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_editor_plus/options.dart';
import 'package:image_picker/image_picker.dart';
import "package:path_provider/path_provider.dart";
import 'package:share_plus/share_plus.dart';

class ImagePickerController extends GetxController {
  var imageModel = Rx<ImageModel>(ImageModel());

  final picker = ImagePicker();
  XFile? savedEditedFile;
  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageModel.value.imagePath = pickedFile.path;
      savedEditedFile = pickedFile;
      log("imageModel.value.imagePath ${imageModel.value.imagePath}");
      update();
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageModel.value.imagePath = pickedFile.path;
      savedEditedFile = pickedFile;
      update();
    }
  }

  Future<Uint8List?> getImageBytes(String imagePath) async {
    try {
      // Read the file as bytes
      File imageFile = File(imagePath);
      Uint8List bytes = await imageFile.readAsBytes();
      return bytes;
    } catch (e) {
      print("Error loading image: $e");
      return null;
    }
  }

  Future<String?> saveImage(Uint8List imageBytes) async {
    try {
      // Get the temporary directory where the edited image will be saved
      List<int> compressedBytes = await FlutterImageCompress.compressWithList(
        imageBytes,
        minHeight: 1920, // Adjust as needed
        minWidth: 1080, // Adjust as needed
        quality: 90, // Adjust as needed
      );

      // Create a temporary directory
      Directory tempDir = await getTemporaryDirectory();

      // Generate a unique filename for the compressed image
      String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";

      // Create the file path
      String filePath = '${tempDir.path}/$fileName';

      // Write the compressed bytes to a file
      File compressedFile = File(filePath);
      final compressedpath = await compressedFile.writeAsBytes(compressedBytes);
      savedEditedFile = XFile(compressedpath.path);
      imageModel.value.imagePath = compressedpath.path;
      update();
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<void> shareEditedImage() async {
    try {
      // Share the locally saved edited image
      await Share.shareXFiles([savedEditedFile!], text: 'Share Edited Image');
    } catch (e) {
      print("Error sharing edited image: $e");
    }
  }
}
