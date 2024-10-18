import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box getUserData() => Hive.box("userInfo");
}
