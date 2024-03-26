import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:camera_functions/image_screen/image_controller/image_controller.dart';
import 'package:camera_functions/login_screen/model/authanitaction_model.dart';
import 'package:camera_functions/widgets/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_editor_plus/image_editor_plus.dart';

class ImageView extends StatelessWidget {
  final ImagePickerController controller = Get.put(ImagePickerController());
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    // log("controller.imageModel.value.imagePath ${controller.imageModel.value.imagePath}");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: ((context) => Dilogbox.dialog(
                            content: "Do you want to exit the App",
                            context: context,
                            onYes: () async {
                              await authController.signOut();
                            },
                          )));
                },
                child: const Icon(Icons.logout)),
          )
        ],
      ),
      body: GetBuilder<ImagePickerController>(builder: (controller) {
        return Column(
          children: [
            Center(
              child: Container(
                width: 450.w,
                height: 450.w,
                child: Obx(() {
                  if (controller.imageModel.value.imagePath == null) {
                    return const Align(
                        alignment: Alignment.center,
                        child: Text('No image selected.'));
                  } else {
                    return Image.file(
                      fit: BoxFit.contain,
                      File(controller.imageModel.value.imagePath!),
                      width: 500,
                      height: 500,
                    );
                  }
                }),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      controller.imageModel.value.imagePath != null
                          ? controller.shareEditedImage()
                          : Fluttertoast.showToast(msg: "Please Select Image ");
                    },
                    child: Icon(Icons.share,
                        color: controller.imageModel.value.imagePath != null
                            ? Colors.black
                            : Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      _showImagePickerDialog(context, controller);
                    },
                    child: const Icon(Icons.add_a_photo),
                  ),
                  InkWell(
                    onTap: () async {
                      controller.imageModel.value.imagePath != null
                          ? controller
                              .getImageBytes(
                                  controller.imageModel.value.imagePath!)
                              .then((value) async {
                              if (value != null) {
                                final editedImage = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageEditor(
                                      image: value, // <-- Uint8List of image
                                    ),
                                  ),
                                );
                                if (editedImage != null) {
                                  controller.saveImage(editedImage);
                                }
                              }
                            })
                          : Fluttertoast.showToast(msg: "Please Select Image ");
                    },
                    child: Icon(Icons.edit,
                        color: controller.imageModel.value.imagePath != null
                            ? Colors.black
                            : Colors.grey),
                  ),

                  //Edit Image
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50.w),
            )
          ],
        );
      }),
    );
  }

  void _showImagePickerDialog(
      BuildContext context, ImagePickerController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick Image From'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
                controller.pickImageFromGallery();
              },
              child: const Text('Gallery'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                controller.pickImageFromCamera();
              },
              child: const Text('Camera'),
            ),
          ],
        );
      },
    );
  }
}
