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

  Future<bool> save(String key, String value) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();
    ExerciseData _exercizeData = ExerciseData(userId: key, imageData: value);
    String _exercizeDataAsJson = json.encode(_exercizeData);
    return settings.setString(key, _exercizeDataAsJson);
  }

  /// read will receive a key (userId) and return object of type ExerciseData
  /// Example json:
  /// ```
  /// {“name”:“Alfonso”,“age”:“21”,“location”:“Portugal”}
  /// ```
  Future<ExerciseData?> read(String key) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();
    final String? _value = settings.getString(key);
    if ( _value != null) {
      final Map<String, dynamic> _valueAsMap = jsonDecode(_value) as Map<String, dynamic>;
      return ExerciseData.fromJson(_valueAsMap);
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
