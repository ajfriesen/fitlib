import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum CameraChooser { image, video }

// create constructor without arguments for understanding
// Service rename
class Media {
  // Media(this._picker);

  ImagePicker _picker = ImagePicker();

  Future getCameraImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return Future.value(pickedFile);
    } else {
      print('No image selected.');
    }
  }
}

Future<void> chooseImagePicker(BuildContext context) async {
  CameraChooser? index = await showDialog<CameraChooser>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select assignment'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, CameraChooser.image);
              },
              child: const Text('Take picture'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, CameraChooser.video);
              },
              child: const Text('Record video'),
            ),
          ],
        );
      });

  Media mediaService = Media();

  switch (index) {
    case CameraChooser.image:
      PickedFile file = await mediaService.getCameraImage();
      print(file.path);
      break;
    case CameraChooser.video:
      // ...
      print("camera");
      break;
    case null:
      // dialog dismissed
      break;
  }
}
