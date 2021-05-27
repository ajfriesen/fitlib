import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_image.dart';
import 'package:flutter_app/models/exercise.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/services/media_file_service.dart';
import 'package:flutter_app/services/shared_preferences_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:flutter_app/models/exercise_image_list.dart';

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
  String? imagePath;
  String? userId;
  ExerciseData testData = ExerciseData();
  ExerciseData testDataRead = ExerciseData();



  @override
  void initState() {
    loginProvider = context.read<Login>();
    userId = loginProvider.getUser()?.uid;
    super.initState();


    // preferencesServiceService.getFile(loginProvider.getUser()?.uid ?? '').then((value) {
    //   setState(() {
    //     imagePath = value;
    //   });
    // });

    preferencesServiceService.read(userId!).then((value) {
      setState(() {
        //TODO: elvis operator value?.imageData
        if (value?.imageData != null ) {
          imagePath = value!.imageData;
        }

      });
    });

  }


  @override
  Widget build(BuildContext context) {
    String imageurl = widget.exercise.imageUrl ?? placeholderImage;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name!),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                imagePath != null && imagePath != ''
                    ? CustomImage(imagePath: imagePath!)
                    : Text('No images yet'),
              ],
            ),
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

          if (pickedImage != null) {
            testData.userId = userId;
            testData.imageData = pickedImage.path;

            bool successfulSave = false;

            if (testData.imageData != null) {
              successfulSave = await preferencesServiceService.save(
                  testData.userId!, testData.imageData!
              );
            }




            if (successfulSave) {
              setState(() {
                imagePath = testData.imageData;
                print('testdata: ${preferencesServiceService.read(userId!)}');
              });
            }
            //TODO: get a toast widget
          }
        },
        child: const Icon(Icons.add_photo_alternate),
        tooltip: 'Pick Image',
      ),
    );
  }
}
