import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bars/bottom_bar_floating_action_button.dart';
import '../bars/bottom_bar_player_search.dart';
import 'player_search_buildBody.dart';

class ProfileUI extends StatelessWidget {
  String firstName;
  String secondName;
  String age;
  String city;
  String town;
  String phoneNumber;
  String position;
  String image;
  String email;
  User? current_user;
  ProfileUI(
      String this.firstName,
      String this.secondName,
      String this.age,
      String this.city,
      String this.town,
      String this.phoneNumber,
      String this.position,
      String this.image,
      String this.email,
      User? this.current_user) {
    this.firstName = firstName;
    this.secondName = secondName;
    this.age = age;
    this.city = city;
    this.town = town;
    this.phoneNumber = phoneNumber;
    this.position = position;
    this.image = image;
    this.email = email;
  }
  AppBar buildHeader(BuildContext context) {
    return AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PlayerSearchBuildBody()));
          },
        ),
        backgroundColor: Colors.transparent, //AppBar'ı tramsparan yapıyor
        automaticallyImplyLeading: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildHeader(context),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Container(
              child: Container(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: Alignment(0.0, 3.5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(image),
                    radius: 70.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Text(
              firstName + " " + secondName,
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              age + "," + city,
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                alignment: Alignment(-0.9, 3.5),
                child: Text(
                  "Tercih Edilen Pozisyonlar:",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                      //letterSpacing: 0.5,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                //color: Colors.red,
                alignment: Alignment(-0.9, 3.5),
                child: Text(
                  position,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.white,
                      //letterSpacing: 0.5,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    alignment: Alignment(-0.9, 0.0),
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    //color: Colors.red,
                    alignment: Alignment(-0.7, 4),
                    child: Text(
                      phoneNumber,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white,
                          //letterSpacing: 0.5,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    alignment: Alignment(-0.90, 0.0),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    //color: Colors.red,
                    alignment: Alignment(-0.65, 4),
                    child: Text(
                      city + "/" + town,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white,
                          //letterSpacing: 0.5,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    alignment: Alignment(-0.90, 0.0),
                    child: Icon(
                      Icons.mail,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    //color: Colors.red,
                    alignment: Alignment(-0.65, 4),
                    child: Text(
                      email,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white,
                          //letterSpacing: 0.5,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: true ? buildFloating(context, current_user) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomBar(),
    );
  }
}
