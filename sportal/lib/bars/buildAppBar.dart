import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
      elevation: 0.0,
      /*leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Color(0xFF4AC5F6),),
        onPressed: () {
          // passing this to our root
          Navigator.of(context).pop();
        },
      ),*/
      title: Center(
          child: Image.asset('assets/images/logobar.png',
              height: AppBar()
                  .preferredSize
                  .height)), //image'i app bar'ın yüksekliğine görse resize ediyor
      backgroundColor: Colors.transparent, //AppBar'ı tramsparan yapıyor
      automaticallyImplyLeading: false);
}
