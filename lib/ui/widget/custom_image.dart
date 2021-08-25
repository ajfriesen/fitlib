import 'dart:io';

import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imagePath;
  const CustomImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.file(
        File(this.imagePath),
        // height: 200,
        // width: 200,
        // fit: BoxFit.contain,
      ),
    );
  }
}
