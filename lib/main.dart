import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      appBar: AppBar(
        title: const Text("lol kids"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                      ),
                      controller: nameController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          if (nameController.text == "seer" &&
                              passController.text == "hahaha") {
                            addStringToSP(nameController.text);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
                          }
                        },
                        child: const Text('Submit'),
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
