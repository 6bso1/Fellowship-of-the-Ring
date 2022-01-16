import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Login_s.dart';

class Reset_screen extends StatefulWidget {
  @override
  _Reset_screenState createState() => _Reset_screenState();
}

class _Reset_screenState extends State<Reset_screen> {
  late String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "welcome",
        home: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/logobar.png",
                            fit: BoxFit.contain,
                          )),
                    ),
                    Expanded(
                      flex:1,
                      child: Column(
                        children: [
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Mail Adresi',
                              hintStyle:
                                  TextStyle(fontSize: 20.0, color: Colors.white60),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white24, width: 2),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.cyan, width: 2),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _email = value.trim();
                              });
                            },
                          ),
                          SizedBox(height: 25),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(7),
                            color: Color(0xFFCC3DE7),
                            child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  auth.sendPasswordResetEmail(email: _email);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => Login_screen()),
                                  );
                                },
                                child: Text(
                                  "Şifreyi Sıfırla",
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontSize: 25, color: Colors.white60),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
