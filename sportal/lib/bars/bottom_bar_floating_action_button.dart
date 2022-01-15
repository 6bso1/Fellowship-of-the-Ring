import 'package:flutter/material.dart';

import '../screens/HomePage_s.dart';

Widget buildFloating(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
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
