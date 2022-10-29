import 'package:android_intent_plus/android_intent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

void main(List<String> args) {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _user = FirebaseAuth.instance.currentUser!;
  final cari = TextEditingController();
  String location = 'lat: long:';
  String address = 'Mencari lokasi...';

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
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("signed in as: ${_user.email!}"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 58),
              width: double.infinity,
              child: MaterialButton(
                onPressed: _signOut,
                color: Colors.blue,
                child: Text("Sign Out"),
              ),
            ),
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
              height: 20.0,
            ),
            //

            const Text(
              'Address',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text('${address}'),
            ),

            //
            ElevatedButton(
              onPressed: () async {
                Position position = await _getGeoLocationPosition();
                setState(() {
                  location =
                      'lat:${position.latitude}, long:${position.longitude}';
                });
                getAddressFromLongLat(position);
              },
              child: const Text('y'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                autofocus: false,
                controller: cari,
                decoration: InputDecoration(
                    hintText: "apaan tuh",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32))),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  final intent = AndroidIntent(
                      action: 'action_view',
                      data: Uri.encodeFull(
                          'google.navigation:q=${cari.text.trim()}'),
                      package: 'com.google.android.apps.maps');
                  await intent.launch();
                },
                child: const Text("eyes wide open when youre dreaming"))
          ],
        ),
      )),
    );
  }
}
