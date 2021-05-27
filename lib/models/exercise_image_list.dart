/// ExerciseData for saving metaData in sharedPreferences
class ExerciseData {
  String? userId;
  String? imageData;

  ExerciseData({this.userId, this.imageData});


  /// {“userId”:“Alfonso”,“imageData”:“somePath;”}
  /// Encode object to Json string
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'imageData': imageData
  };

  /// Named constructor
  /// Decode from Json string to Object
  ExerciseData.fromJson(Map<String, dynamic> json) {
      userId = json['userId'] as String?;
      imageData = json['imageData'] as String?;
  }

}

// class ImageData {
//   String exerciseName;
//   String imagePath;
//
//   ImageData(this.exerciseName, this.imagePath);
// }


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
