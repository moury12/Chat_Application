import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box getUserToken() => Hive.box("userInfo");
}
