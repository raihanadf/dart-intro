import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ongghuen/auth/auth_page.dart';
import 'package:ongghuen/local/database.dart';
import 'package:ongghuen/pages/home_page.dart';

void main(List<String> args) {
  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  UserHiveDatabase udb = UserHiveDatabase();
  @override
  Widget build(BuildContext context) {
    udb.loadDB();
    return Scaffold(
        body: udb.user == null
            ? const AuthPage()
            : HomePage(
                docId: udb.user,
              ));
  }
}
