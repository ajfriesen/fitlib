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

  Future<bool> saveImageMetadata(String storedImage, String key) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();

    if (settings != null) {
      return settings.setString(key, storedImage);
    }
    return Future.value(false);
  }

  Future<String?> getFile(String key) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();

    return settings.getString(key);
  }
}
