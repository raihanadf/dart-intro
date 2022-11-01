import 'package:android_intent_plus/android_intent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ongghuen/auth/auth_page.dart';
import 'package:ongghuen/pages/setting_page.dart';

class DashboardPage extends StatefulWidget {
  final String? docId;
  const DashboardPage({Key? key, required this.docId}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // final _user = FirebaseAuth.instance.currentUser!;
  var db = FirebaseFirestore.instance;

  final cari = TextEditingController();
  String titleName = "Home";
  String location = 'lat: long:';
  String address = 'Mencari lokasi...';

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
          titleName = "Welcome, ${data['username']}";
        });
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  //getLongLAT
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //location service not enabled, don't continue
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    //permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
    //continue accessing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // //getAddress
  Future<void> getAddressFromLongLat(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    setState(() {
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }

  Future _signOut() async {
    // FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4E9F3D),
        title: const Text("Dashboard"),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Poin Koordinat',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              location,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            //

            const Text(
              'Address',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text('${address}'),
            ),

            //
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF4E9F3D)),
              onPressed: () async {
                Position position = await _getGeoLocationPosition();
                setState(() {
                  location =
                      'lat:${position.latitude}, long:${position.longitude}';
                });
                getAddressFromLongLat(position);
              },
              child: const Text('Cek Lokasi'),
            ),

//
            SizedBox(
              height: 30,
            ),

//
            const Text(
              'Navigasi',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            //
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                autofocus: false,
                controller: cari,
                decoration: InputDecoration(
                    hintText: "Misal: Eterno Kafe",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32))),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4E9F3D)),
                onPressed: () async {
                  final intent = AndroidIntent(
                      action: 'action_view',
                      data: Uri.encodeFull(
                          'google.navigation:q=${cari.text.trim()}'),
                      package: 'com.google.android.apps.maps');
                  await intent.launch();
                },
                child: const Text("Cari Lokasi"))
          ],
        ),
      )),
    );
  }
}
