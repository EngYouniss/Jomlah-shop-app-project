import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  String? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Products"),
      ),
      body: path == null ? ElevatedButton(
          onPressed: () {
            loadImage();
          }, child: Text(" اظافة منتج")) : Image.file(
          File(path!)),
    );
  }

  loadImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        path = image.path;
      });
    } else {
      // المستخدم لم يختر صورة
      print("لم يتم اختيار صورة");
    }
  }

}