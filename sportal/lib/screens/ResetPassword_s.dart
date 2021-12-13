import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
            body: Column(
              children: [
                SizedBox(
                    height: 200,
                    child: Image.asset(
                      "assets/logobar.png",
                      fit: BoxFit.contain,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(fontSize: 20.0, color: Color(0xFF631FC9)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      child: Text('Şifreyi sıfırla'),
                      onPressed: () {
                        auth.sendPasswordResetEmail(email: _email);
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Login_screen()),
                        );
                      },
                      color: Color(0xFFCC3DE7),
                    ),

                  ],
                ),

              ],),
          )));
  }
}