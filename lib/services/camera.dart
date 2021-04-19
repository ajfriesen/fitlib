import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class Media {
  //Media(this._picker);

  var _picker = ImagePicker();

  Future getMedia() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return Future.value(pickedFile);
    } else {
      print('No image selected.');
    }
  }
}

class ImagePickerMenu extends StatefulWidget {
  @override
  _ImagePickerMenuState createState() => _ImagePickerMenuState();
}

class _ImagePickerMenuState extends State<ImagePickerMenu> {
  static var _selection = WhyFarther.harder;

  @override
  Widget build(BuildContext context) {
    PopupMenuButton<WhyFarther>(
      onSelected: (WhyFarther result) {
        setState(() {
          _selection = result;
          throw 'This is empty';
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.harder,
          child: Text('Working a lot harder'),
        ),
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.smarter,
          child: Text('Being a lot smarter'),
        ),
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.selfStarter,
          child: Text('Being a self-starter'),
        ),
        const PopupMenuItem<WhyFarther>(
          value: WhyFarther.tradingCharter,
          child: Text('Placed in charge of trading charter'),
        ),
      ],
    );
  }
}
