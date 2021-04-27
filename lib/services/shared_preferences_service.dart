import 'package:image_picker/image_picker.dart';
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

  saveImageMetadata(PickedFile storedImage /*, String key*/) {
    //#TODO: settings.setString(key, value);
  }

  PickedFile? getFile(String key) {
    //
    settings.getString(key);
    // #TODO:find a way to return the picked image
    // return image
  }
}
