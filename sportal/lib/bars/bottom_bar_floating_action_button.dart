import 'package:flutter/material.dart';
import '../screens/HomePage_s.dart';

Widget buildFloating(BuildContext context){
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => MyApp(),
          transitionDuration: Duration.zero,
        ),
      );
    },
    child: CircleAvatar(
      radius: 30,
      backgroundColor: Colors.purple,
      child: CircleAvatar(
        //child: Image.asset("assets/swirl_and_ball.png"),
        backgroundImage: NetworkImage("https://github.com/okantorun/Vector-Graphics-Libraray-C/blob/main/JPGs/swirl_and_ball.png?raw=true"),
        radius:20,
      ),
    ),
  );
}