import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum CameraChooser { image, video, imageGallery, videoGallery }

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

  getGalleryImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return Future.value(pickedFile);
    } else {
      print('No image from gallery selected');
    }
  }

  // ? because we might return null
  Future<PickedFile?> chooseImagePicker(BuildContext context) async {
    CameraChooser? index = await showDialog<CameraChooser>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Choose your Image source'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, CameraChooser.image);
                },
                child: const Text('Take picture'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, CameraChooser.imageGallery);
                },
                child: const Text('Choose image from gallery'),
              ),
            ],
          );
        });

    switch (index) {
      case CameraChooser.image:
        return await getCameraImage();
      // print(file.path);
      // PreferencesService.saveFile();
      // break;
      case CameraChooser.video:
        // ...
        return await getCameraImage();
      // print("camera");
      // break;
      case CameraChooser.videoGallery:
        // ...
        return await getCameraImage();
      // break;
      case CameraChooser.imageGallery:
        return await getGalleryImage();
      // print(file.path);

      // break;
      case null:
        return null;
      //

    }
  }
}
