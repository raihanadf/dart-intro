import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongghuen/local/database.dart';
import 'package:ongghuen/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserHiveDatabase udb = UserHiveDatabase();
  // controllers
  final _usernameController = TextEditingController();
  final _passController = TextEditingController();

  Future _signIn() async {
    var db = FirebaseFirestore.instance;
    try {
      // await FirebaseAuth.instance.signInWithEmailAndPassword(
      //     email: _emailController.text.trim(),
      //     password: _passController.text.trim());

      await db.collection("users").get().then((event) {
        for (var doc in event.docs) {
          if (_usernameController.text.trim() == doc.data()["username"] &&
              _passController.text.trim() == doc.data()["password"]) {
            udb.user = doc.id;
            udb.updateDB();
            return Get.off(HomePage(
              docId: doc.id,
            ));
          }
        }
        return Get.snackbar("Login", "Username atau Password salah");
      });
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('Login gagal!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "TSA: End Game",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                ),

                // sized box cuma buat margin, idk any alternatives
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Selamat datang!",
                  style: TextStyle(fontSize: 20),
                ),

                //
                const SizedBox(
                  height: 20,
                ),

                // ini input text atau form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Username Anda',
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // ini input text atau form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    obscureText: true,
                    controller: _passController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Password Anda',
                    ),
                  ),
                ),

                //
                const SizedBox(
                  height: 20,
                ),
                //

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4E9F3D)),
                        onPressed: _signIn,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Sign In",
                            style: TextStyle(fontSize: 24),
                          ),
                        )),
                  ),
                ),

                //
                const SizedBox(
                  height: 20,
                ),
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum register? ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: const Text(
                        "Register sekarang",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4E9F3D)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
