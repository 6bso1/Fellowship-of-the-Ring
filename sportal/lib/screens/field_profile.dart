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
  late PageController _pageController;
  int activePage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = List.from(fieldVar.get('photos'));

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
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: PageView.builder(
                      itemCount: images.length,
                      pageSnapping: true,
                      controller: _pageController,
                      onPageChanged: (page) {
                        setState(() {
                          activePage = page;
                        });
                      },
                      itemBuilder: (context, pagePosition) {
                        return Container(
                          child: Image.network(images[pagePosition]),
                        );
                      })),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicators(images.length, activePage)),
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
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(children: [
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
                  SizedBox(
                    height: 15,
                  ),
                ]),
              ),
            ],
          ),
        ))
      ]),
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.white : Colors.white24,
            shape: BoxShape.circle),
      );
    });
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
