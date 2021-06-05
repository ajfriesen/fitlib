// import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
// part 'exercise_image_list.g.dart';

/// ExerciseData for saving metaData in sharedPreferences
// @JsonSerializable(explicitToJson: true)
class ExerciseData {
  String? userId;
  List<ImageData>? imageData;

  ExerciseData({this.userId, this.imageData});

  // factory ExerciseData.fromJson(Map<String, dynamic> data) => _$ExerciseDataFromJson(data);
  //
  // Map<String, dynamic> toJson() => _$ExerciseDataToJson(this);


  // {“userId”:“Alfonso”,“imageData”:“somePath;”}
  // Encode object to Json string
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'imageData': imageData
  };

  // Named constructor
  // Decode from Json string to Object
  ExerciseData.fromJson(Map<String, dynamic> json) {
      userId = json['userId'] as String?;

      imageData = json['imageData'].map<ImageData>((e){
        return ImageData.fromJson(e);
      }).toList();
  }
}

// @JsonSerializable()
class ImageData {
  String? exerciseName;
  //TODO: This needs to be a list
  String? imagePath;

  ImageData({this.exerciseName, this.imagePath});

  // factory ImageData.fromJson(Map<String, dynamic> data) => _$ImageDataFromJson(data);
  //
  // Map<String, dynamic> toJson() => _$ImageDataToJson(this);

  Map<String, dynamic> toJson() => {
    'exerciseName': exerciseName,
    'imagePath': imagePath
  };

  ImageData.fromJson(Map<String, dynamic> json) {
    exerciseName = json['exerciseName'];
    imagePath = json['imagePath'];
  }
}


/*
- userId: jsonString


jsonString
{
  "usreId": "1234",
  "imageData": "/path/"
}

{
  "usreId": "1234",
  "imageData": [

  ]
}

*/

/*
*
*
*
* */

//
// class PreferencesData {
//   List<ExerciseData> exerciseList;
// }

/*

1. Add photo
2. save photo to file
3. save path to exerciseList

exerciseList
- path: /asdf
  name: burpee
- id: 09asd (document id)
  path: /asdfklf
  name: push-up



 */
