import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
      elevation: 0.0,
      title: Center(
          child: Image.asset('assets/images/logobar.png',
              height: AppBar()
                  .preferredSize
                  .height)), //image'i app bar'ın yüksekliğine görse resize ediyor
      backgroundColor: Colors.transparent, //AppBar'ı tramsparan yapıyor
      automaticallyImplyLeading: false);
}
