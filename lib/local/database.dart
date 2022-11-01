import 'package:hive/hive.dart';

class UserHiveDatabase {
  final _myBox = Hive.box("users");

  String? user;

  void loadDB() {
    user = _myBox.get("username");
  }

  void updateDB() {
    _myBox.put("username", user);
  }

  void removeUser() {
    _myBox.delete("username");
  }
}
