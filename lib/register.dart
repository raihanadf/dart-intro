import 'package:flutter/material.dart';
import 'main.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: Register(),
  ));
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                      "Register",
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
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black),
                        onPressed: () {},
                        child: const Text("Login pake Apple"),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black),
                        onPressed: () {},
                        child: const Text("Login pake Google"),
                      ),
                    ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                                child: const Text(
                              "----------------- Atau ----------------",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.left,
                            )),
                          ),
                        ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: const Text(
                            "Personal Email*",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
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
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Lanjutkan dengan Email'),
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
