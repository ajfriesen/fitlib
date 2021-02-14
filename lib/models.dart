import 'package:flutter/widgets.dart';

class Exercise {
  const Exercise({
    @required this.name,
    this.imageUrl,
  }) : assert(name != null);

  final String name;
  final String imageUrl;
}
