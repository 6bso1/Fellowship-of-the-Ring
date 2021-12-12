import 'package:flutter/material.dart';

Widget buildFloating(){
  return FloatingActionButton(
    onPressed: () {},
    child: CircleAvatar(
      radius: 30,
      backgroundColor: Colors.purple,
      child: CircleAvatar(
        child: Image.asset("assets/swirl_and_ball.png"),
        //backgroundImage: NetworkImage("https://github.com/okantorun/Vector-Graphics-Libraray-C/blob/main/JPGs/swirl_and_ball.png?raw=true"),
        radius:30,
      ),
    ),
  );
}