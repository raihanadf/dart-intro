import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register.dart';
import 'drawer.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  var whoLoggedIn = await getStringValueSP();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: whoLoggedIn != "null" ? const MyApp() : const Login(),
  ));
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final nameController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 170),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: const Text(
                      "Log in ke BlaBla",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.blue),
                      textAlign: TextAlign.left,
                    )),
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: const Text(
                            "Email",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          )),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your email',
                              filled: true,
                              fillColor: Color(0xfff6f6f6),
                            ),
                            controller: nameController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: const Text(
                            "Password",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          )),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your password',
                            ),
                            controller: passController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child: const Text(
                          "Forgot your password?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue
                          ),
                          textAlign: TextAlign.left,
                        )),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          if (nameController.text == "seer" &&
                              passController.text == "hahaha") {
                            addStringToSP(nameController.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyApp()));
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black),
                        onPressed: () {
                          addStringToSP(nameController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        },
                        child: const Text("Don't have an account?"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

addStringToSP(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('Username', value);
}

getStringValueSP() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String data = preferences.getString('Username').toString();
  return data;
}
