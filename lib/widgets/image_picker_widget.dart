import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    super.key,
    this.pickedImage,
    required this.func
  });

  final XFile? pickedImage;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: pickedImage == null
                   ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue,width: 2,),
                      borderRadius: BorderRadius.circular(25.0)
                    ),
                  )
                : Image.file(
              File(pickedImage!.path),
              fit: BoxFit.fill,
            )
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.blue,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () {
                func();
              },
              splashColor: Colors.red,
              child: const Padding(
                padding: EdgeInsets.all(6.0),
                child: Icon(Icons.image,size: 30,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
