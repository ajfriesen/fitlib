/// ExerciseData for saving metaData in sharedPreferences
class UserData {
  String? userId;
  List<CustomExerciseData>? customExercises;

  UserData({this.userId, this.customExercises});

  // {“userId”:“Alfonso”,“imageData”:“somePath;”}
  // Encode object to Json string
  Map<String, dynamic> toJson() => {'userId': userId, 'imageData': customExercises};

  // Named constructor
  // Decode from Json string to Object
  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] as String?;

    customExercises = json['imageData'].map<CustomExerciseData>((e) {
      return CustomExerciseData.fromJson(e);
    }).toList();
  }
}

class CustomExerciseData {
  String? exerciseName;
  //TODO: This needs to be a list
  String? imagePath;

  CustomExerciseData({this.exerciseName, this.imagePath});

  Map<String, dynamic> toJson() => {'exerciseName': exerciseName, 'imagePath': imagePath};

  CustomExerciseData.fromJson(Map<String, dynamic> json) {
    exerciseName = json['exerciseName'];
    imagePath = json['imagePath'];
  }
}
