import 'package:android_intent_plus/android_intent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ongghuen/auth/auth_page.dart';
import 'package:ongghuen/local/database.dart';
import 'package:ongghuen/pages/dashboard_page.dart';
import 'package:ongghuen/pages/login_page.dart';
import 'package:ongghuen/pages/setting_page.dart';

class HomePage extends StatefulWidget {
  final String? docId;
  const HomePage({Key? key, required this.docId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final _user = FirebaseAuth.instance.currentUser!;
  UserHiveDatabase udb = UserHiveDatabase();
  var db = FirebaseFirestore.instance;

  final cari = TextEditingController();
  String titleName = "Home";

  @override
  initState() {
    _getUsername();
  }

  // getUser
  _getUsername() async {
    final docRef = db.collection("users").doc(widget.docId);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        setState(() {
          titleName = data['nama'];
        });
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future _signOut() async {
    // FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const SingleChildScrollView(
              child: Text("Home"), scrollDirection: Axis.horizontal),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: GestureDetector(
                child: const Icon(Icons.logout),
                onTap: () {
                  udb.removeUser();
                  Get.off(const AuthPage());
                },
              ),
            )
          ],
          // leading: GestureDetector(
          //   child: Icon(Icons.settings),
          //   onTap: () => Get.to(SettingPage(docId: widget.docId)),
          // ),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(''),
              ),
              ListTile(
                title: Row(
                  children: [
                    const Icon(Icons.dashboard),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: const Text('Dashboard'),
                    ),
                  ],
                ),
                onTap: () {
                  Get.to(DashboardPage(docId: widget.docId));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    const Icon(Icons.commit),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: const Text('Profile'),
                    ),
                  ],
                ),
                onTap: () {
                  Get.to(SettingPage(docId: widget.docId));
                },
              ),
            ],
          ),
        ),
        body: Center(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Text(
                  "Selamat Datang",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  titleName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        )));
  }
}
