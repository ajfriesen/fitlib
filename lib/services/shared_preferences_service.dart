import 'dart:convert';

import 'package:flutter_app/models/exercise_image_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  /// save will receive a key(userId), imagePath and exerciseName
  /// put these in an instance of ExerciseData _exerciseData
  /// encode the _exerciseData object into _exerciseDataAsJson
  /// and save the key(userId), value (_exerciseDataAsJson) to a SharedPreferencesObject
  Future<bool> save(
      {required String userId, required String imagePath, required String exerciseName}) async {
    //get the list first
    final SharedPreferences settings = await SharedPreferences.getInstance();
    String? currentValueAsString = settings.getString(userId);

    CustomExerciseData exerciseData =
        CustomExerciseData(exerciseName: exerciseName, imagePath: imagePath);

    if (currentValueAsString != null) {
      UserData _userData = _buildUserData(currentValueAsString);
      _deleteIfExists(_userData, exerciseName);
      return _addExercise(_userData, exerciseData);
    } else {
      UserData userData = UserData(userId: userId, customExercises: List.empty(growable: true));
      return _addExercise(userData, exerciseData);
    }
  }

  void _deleteIfExists(UserData _userData, String exerciseName) {
    CustomExerciseData imageDataAlreadyExist = _userData.customExercises!.firstWhere((element) {
      //check for already existing exercise
      if (element.exerciseName != exerciseName) {
        return false;
      }
      return true;
    },

        ///If nothing is found just return an empty object otherwise it will crash
        orElse: () => CustomExerciseData());

    if (imageDataAlreadyExist.imagePath != null) {
      _userData.customExercises!.removeWhere((element) {
        if (element.exerciseName == exerciseName) {
          return true;
        }
        return false;
      });
    }
  }

  UserData _buildUserData(String userDataJson) {
    Map<String, dynamic> _exerciseDataAsMap = json.decode(userDataJson) as Map<String, dynamic>;
    UserData _userData = UserData.fromJson(_exerciseDataAsMap);

    if (_userData.customExercises == null) {
      _userData.customExercises = <CustomExerciseData>[];
    }
    return _userData;
  }

  Future<bool> _addExercise(UserData userData, CustomExerciseData exerciseData) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();

    userData.customExercises!.add(exerciseData);
    String _exerciseDataAsJson = json.encode(userData);

    /// Condition ? first 1. result : 2. result
    return userData.userId != null
        ? settings.setString(userData.userId!, _exerciseDataAsJson)
        : Future.value(false);
  }

  /// read will receive a key (userId) and return object of type ExerciseData
  /// Example json:
  /// ```
  /// {“name”:“Alfonso”,“age”:“21”,“location”:“Portugal”}
  /// ```
  Future<UserData?> read({required String userId}) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();
    final String? _rawJsonString = settings.getString(userId);
    if (_rawJsonString != null) {
      // final Map<String, dynamic> _valueAsMap = jsonDecode(_rawJsonString) as Map<String, dynamic>;
      return UserData.fromJson(jsonDecode(_rawJsonString));
    }
  }

  Future<bool> saveImageMetadata(String storedImage, String key) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();
    return settings.setString(key, storedImage);
  }

  // Recieve key and exercizse name
  // key: 198273981234
  // value:
  //   - Exercize data 1
  //   - Exercize data 2
  // Go through list of exercises and search / find for Erxercizse name
  Future<String?> getFile(String key) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();

    return settings.getString(key);
  }
}
