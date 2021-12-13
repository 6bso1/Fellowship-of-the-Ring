import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Background.dart';
import 'HomePage_s.dart';

class RouteTakimBul extends StatelessWidget {
  const RouteTakimBul({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildFloatingActionButton(context),
      appBar: buildHeader(),
      extendBodyBehindAppBar:
          true, //Body'i appbar kısmına çekiyor (Arka planı uzatmak için)
      body: Stack(children: <Widget>[
        //Arkaplanın üzerine eklenecek widgetlar için stack kullandım
        Background(),
        SafeArea(child: SingleChildScrollView(child: Column()))
      ]),
    );
  }
}

AppBar buildHeader() {
  return AppBar(
      elevation: 0.0,
      title: Center(
          child: Image.asset('assets/images/Header-Takim-Bul.png',
              height: AppBar()
                  .preferredSize
                  .height)), //image'i app bar'ın yüksekliğine görse resize ediyor
      backgroundColor: Colors.transparent, //AppBar'ı tramsparan yapıyor
      automaticallyImplyLeading: false);
}
