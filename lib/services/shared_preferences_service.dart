import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // needs to be late because of async
  SharedPreferences? settings;

  // constructor
  PreferencesService() {
    _createSettings();
  }

  // we need a function because a constructor can not be async
  _createSettings() async {
    settings = await SharedPreferences.getInstance();
    print(settings);
  }

  Future<bool> saveImageMetadata(String storedImage, String key) {
    if (settings != null) {
      return settings!.setString(key, storedImage);
    }
    return Future.value(false);
  }

  String? getFile(String key) {
    return settings?.getString(key);
  }
}
