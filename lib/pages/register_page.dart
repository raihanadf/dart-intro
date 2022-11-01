import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // controllers
  final _usernameController = TextEditingController();
  final _namaController = TextEditingController();
  final _telpController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _namaController.dispose();
    _telpController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_usernameController.text.isNotEmpty &&
        _namaController.text.isNotEmpty &&
        _telpController.text.isNotEmpty &&
        _passController.text.isNotEmpty &&
        _confirmPassController.text.isNotEmpty) {
      var db = FirebaseFirestore.instance;
      try {
// Create a new user with a first and last name
        final user = <String, dynamic>{
          "username": _usernameController.text.trim(),
          "nama": _namaController.text,
          "password": _passController.text.trim(),
          "no_telp": _telpController.text.trim()
        };

        if (_passController.text.trim() == _confirmPassController.text.trim()) {
          db.collection("users").add(user).then((DocumentReference doc) =>
              print('DocumentSnapshot added with ID: ${doc.id}'));
          widget.showLoginPage();
        }

        // if (_passController.text.trim() == _confirmPassController.text.trim()) {
        //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //       email: _emailController.text.trim(),
        //       password: _passController.text.trim());
        // }
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Format Username atau Password salah!'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      Get.snackbar("Mohon Isi Semua Field!", "Data Anda tidak lengkap");
    }
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
                // const Icon(
                //   Icons.android_outlined,
                //   size: 100,
                // ),
                // text di atas
                const Text(
                  "Register",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                ),

                // sized box cuma buat margin, idk any alternatives
                const SizedBox(
                  height: 10,
                ),

                // ini input text atau form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Username',
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
                    controller: _namaController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nama',
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
                    controller: _telpController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'No Telpon',
                    ),
                  ),
                ),

                //
                const SizedBox(
                  height: 10,
                ),
                //
                // ini input text atau form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    obscureText: true,
                    controller: _passController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),

                //
                const SizedBox(
                  height: 10,
                ),
                //
                // ini input text atau form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    obscureText: true,
                    controller: _confirmPassController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),

                //
                const SizedBox(
                  height: 30,
                ),
                //

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4E9F3D)),
                        onPressed: _signUp,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        )),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Saya userrr! ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        "Login sini",
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
