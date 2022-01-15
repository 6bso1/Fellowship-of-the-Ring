import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportal/bars/bottom_bar_floating_action_button.dart';
import 'package:sportal/bars/bottom_bar_player_search.dart';

import 'Background.dart';

class FieldComments extends StatefulWidget {
  final DocumentSnapshot fieldVar;

  const FieldComments({required this.fieldVar});
  @override
  _FieldCommentsState createState() => _FieldCommentsState(fieldVar: fieldVar);
}

class _FieldCommentsState extends State<FieldComments> {
  final DocumentSnapshot fieldVar;

  _FieldCommentsState({required this.fieldVar});

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
          const Background(),
          SafeArea(
              child: SingleChildScrollView(
                  /* child: ListView.builder(
                itemCount: listOfFields.length,
                itemBuilder: (context, index) {
                  return fieldCards(
                    fieldVar: listOfFields[index],
                  );
                }),*/
                  ))
        ]));
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
