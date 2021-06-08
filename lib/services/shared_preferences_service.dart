import 'dart:convert';

import 'package:flutter_app/models/exercise_image_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // needs to be late because of async
  // SharedPreferences? settings;

  // constructor
  // PreferencesService() {
  //   _createSettings();
  // }

  // we need a function because a constructor can not be async
  // _createSettings() async {
  //   settings = await SharedPreferences.getInstance();
  //   print(settings);
  // }

// Revievw key, exercize name, imagePath
// Editing exercizse in the erxercize list of the key (user)
// Instanciate singelton of shared preferences
// get the list
// edit the list
// save the list

  

  /// save will receive a key(userId), imagePath and exerciseName
  /// put these in an instance of ExerciseData _exerciseData
  /// encode the _exerciseData object into _exerciseDataAsJson
  /// and save the key(userId), value (_exerciseDataAsJson) to a SharedPreferencesObject
  Future<bool> save({required String userId, required String imagePath, required String exerciseName}) async {
    //get the list first
    final SharedPreferences settings = await SharedPreferences.getInstance();

      CustomExerciseData _imageData = CustomExerciseData(exerciseName: exerciseName, imagePath: imagePath);
      String? currentValueAsString = settings.getString(userId);


      if (currentValueAsString != null) {
        // dynamic _exerciseMapString = jsonDecode(currentValueAsString);
        // ExerciseData _userData = ExerciseData.fromJson(_exerciseMapString);
        Map<String, dynamic> _exerciseDataAsMap = json.decode(currentValueAsString) as Map<String, dynamic>;
        UserData _userData = UserData.fromJson(_exerciseDataAsMap);

        if (_userData.customExercises == null) {
          _userData.customExercises = <CustomExerciseData>[];
        }

        CustomExerciseData imageDataAlreadyExist = _userData.customExercises!.firstWhere((element) {
          //check for already existing exercise
          if (element.exerciseName != exerciseName) {
            return false;
          }
          return true;
        },
        orElse: () => CustomExerciseData()
        );



        if (imageDataAlreadyExist.imagePath != null) {
          _userData.customExercises!.removeWhere((element) {
            if (element.exerciseName == exerciseName) {
              return true;
            }
            return false;
          });
        }




        _userData.customExercises!.add(_imageData);
        String _exerciseDataAsJson = json.encode(_userData);
        return settings.setString(userId, _exerciseDataAsJson);

      }

      else {
        List<CustomExerciseData> _listOfExercise = List.empty(growable: true);
        _listOfExercise.add(_imageData);
        UserData _exerciseData = UserData(userId: userId, customExercises: _listOfExercise);

        String _exerciseDataAsJson = json.encode(_exerciseData);
        return settings.setString(userId, _exerciseDataAsJson);
      }

    // ImageData _imageData = ImageData(exerciseName: exerciseName, imagePath: imagePath);




    // String _exerciseDataAsJson = json.encode(_userData);
    // print(_exerciseDataAsJson);
    // return settings.setString(userId, _exerciseDataAsJson);



  }
  
  

  /// read will receive a key (userId) and return object of type ExerciseData
  /// Example json:
  /// ```
  /// {“name”:“Alfonso”,“age”:“21”,“location”:“Portugal”}
  /// ```
  Future<UserData?> read({required String userId}) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();
    final String? _rawJsonString = settings.getString(userId);
    if ( _rawJsonString != null) {
      // final Map<String, dynamic> _valueAsMap = jsonDecode(_rawJsonString) as Map<String, dynamic>;
      return UserData.fromJson(jsonDecode(_rawJsonString));
    }
  }

  Future<bool> saveImageMetadata(String storedImage, String key) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();

    if (settings != null) {
      return settings.setString(key, storedImage);
    }
    return Future.value(false);
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
