import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // needs to be late because of async
  late SharedPreferences settings;

  // constructor
  PreferencesService() {
    _createSettings();
  }

  // we need a function because a constructor can not be async
  _createSettings() async {
    settings = await SharedPreferences.getInstance();
  }

  getFile() {}
}
