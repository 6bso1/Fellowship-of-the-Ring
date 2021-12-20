import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bars/bottom_bar_floating_action_button.dart';
import '../bars/bottom_bar_player_search.dart';
import 'Background.dart';
import 'HomePage_s.dart';

class RouteRakipBul extends StatelessWidget {
  const RouteRakipBul({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: true
          ? buildFloating(context)
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomBar(),
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
          child: Image.asset('assets/images/Header-Rakip-Bul.png',
              height: AppBar()
                  .preferredSize
                  .height)), //image'i app bar'ın yüksekliğine görse resize ediyor
      backgroundColor: Colors.transparent, //AppBar'ı tramsparan yapıyor
      automaticallyImplyLeading: false);
}
