import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportal/bars/bottom_bar_floating_action_button.dart';
import 'package:sportal/bars/bottom_bar_player_search.dart';

import 'Background.dart';

class FieldProfile extends StatefulWidget {
  final DocumentSnapshot fieldVar;

  const FieldProfile({required this.fieldVar});

  @override
  FieldProfileState createState() => FieldProfileState(fieldVar: fieldVar);
}

class FieldProfileState extends State<FieldProfile> {
  final DocumentSnapshot fieldVar;

  FieldProfileState({required this.fieldVar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: true ? buildFloating(context) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomBar(),
      appBar: buildHeader(),
      extendBodyBehindAppBar:
          true, //Body'i appbar kısmına çekiyor (Arka planı uzatmak için)
      body: Stack(children: <Widget>[
        //Arkaplanın üzerine eklenecek widgetlar için stack kullandım
        Background(),
        SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 250,
              width: double.infinity,
              child: ImageCarousel(fieldVar: fieldVar),
              /*
              child: Image.network(
                fieldVar.get('photos')[0],
                fit: BoxFit.cover,
              ),*/
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              fieldVar.get('name'),
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fieldVar.get('commenNum').toString(),
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  ' Değerlendirme   ',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  fieldVar.get('rate').toString(),
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                SizedBox(width: 2),
                Image.asset(
                  'assets/images/star.png',
                  height: 16,
                ),
                SizedBox(width: 4),
                Text(
                  fieldVar.get('favNum').toString(),
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                SizedBox(width: 2),
                Image.asset(
                  'assets/images/fav.png',
                  height: 16,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              fieldVar.get('properties'),
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            Column(children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/location.png',
                    height: 25,
                  ),
                  SizedBox(width: 4),
                  Text(
                    fieldVar.get('adress').toString(),
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/price.png',
                    height: 25,
                  ),
                  SizedBox(width: 4),
                  Text(
                    fieldVar.get('cost').toString(),
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/clock.png',
                    height: 25,
                  ),
                  SizedBox(width: 4),
                  Text(
                    fieldVar.get('adress').toString(),
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/phone.png',
                    height: 25,
                  ),
                  SizedBox(width: 4),
                  Text(
                    fieldVar.get('phone').toString(),
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ]),
          ],
        ))
      ]),
    );
  }

  AppBar buildHeader() {
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
}

class ImageCarousel extends StatelessWidget {
  final DocumentSnapshot fieldVar;

  ImageCarousel({required this.fieldVar});

  @override
  Widget build(BuildContext context) {
    return Container();
    /*return CarouselImages(
      height: 150.0,
      listImages: fieldVar.get('photos'),
      scaleFactor: 0.7,
      borderRadius: 30.0,
      cachedNetworkImage: true,
      verticalAlignment: Alignment.bottomCenter,
      onTap: (index) {
        print('Tapped on page $index');
      },
    );*/
  }
}
