import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/HomePage_s.dart';

Widget buildFloating(BuildContext context, User? current_user) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(current_user: current_user)));
    },
    child: CircleAvatar(
      radius: 30,
      backgroundColor: Colors.purple,
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/images/swirl_and_ball.png'),
        radius: 20,
      ),
    ),
  );
}
