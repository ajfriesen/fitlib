import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/services/media_file_service.dart';
import 'package:flutter_app/services/shared_preferences_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Detail extends StatefulWidget {
  //Object to handle view
  final Exercise exercise;

  Detail({required this.exercise});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Login loginProvider;
  static const String placeholderImage = 'images/placeholder.png';
  final Media mediaService = Media();
  final PreferencesService preferencesServiceService = PreferencesService();

  @override
  void initState() {
    loginProvider = context.read<Login>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String imageurl = widget.exercise.imageUrl ?? placeholderImage;

    String? imagePath =
        preferencesServiceService.getFile(loginProvider.getUser()?.uid ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name!),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              imageurl == placeholderImage || imageurl.isEmpty
                  ? Image.asset(placeholderImage, fit: BoxFit.fitWidth)
                  : Image.network(imageurl, fit: BoxFit.fitWidth),
              SizedBox(height: 40),
              Text(
                'My saved Images',
                style: TextStyle(fontSize: 30),
              ),
              Text(imagePath ?? 'No images yet')
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final User? loggedInUser = loginProvider.getUser();

          if (loggedInUser == null) {
            //TODO: Add Modal alert
            return;
          }
          print('User ID is: ${loggedInUser.uid}');

          PickedFile? pickedImage =
              await mediaService.chooseImagePicker(context);
          print(pickedImage);

          // #TODO:get userId from provider

          if (pickedImage != null) {
            preferencesServiceService.saveImageMetadata(
                pickedImage.path, loggedInUser.uid);
            setState(() {});
          }
        },
        child: const Icon(Icons.add_photo_alternate),
        tooltip: 'Pick Image',
      ),
    );
  }
}
