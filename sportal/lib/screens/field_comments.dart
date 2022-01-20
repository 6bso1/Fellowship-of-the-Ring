import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportal/bars/bottom_bar_floating_action_button.dart';
import 'package:sportal/bars/bottom_bar_player_search.dart';

import 'Background.dart';

class FieldComments extends StatefulWidget {
  final DocumentSnapshot fieldVar;
  final User? current_user;
  const FieldComments({required this.current_user, required this.fieldVar});
  @override
  _FieldCommentsState createState() =>
      _FieldCommentsState(fieldVar: fieldVar, current_user: current_user);
}

class _FieldCommentsState extends State<FieldComments> {
  final DocumentSnapshot fieldVar;
  final User? current_user;
  _FieldCommentsState({required this.current_user, required this.fieldVar});

  @override
  Widget build(BuildContext context) {
    CollectionReference commentRef = fieldVar.reference.collection('Rewieves');
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
              child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  fieldVar.get('name') + ' Değerlendirmeler',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.blue,
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    Text(
                      "  Yorum Ekleyin",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: commentRef.snapshots(),
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return Center(child: Text("Bir Hata oluştu."));
                  } else {
                    if (asyncSnapshot.hasData) {
                      List<DocumentSnapshot> listOfComments =
                          asyncSnapshot.data.docs;
                      return Flexible(
                        child: ListView.builder(
                            itemCount: listOfComments.length,
                            itemBuilder: (context, index) {
                              return commentCards(
                                current_user: current_user,
                                commentVar: listOfComments[index],
                                fieldVar: fieldVar,
                              );
                            }),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
                },
              )
            ],
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

class commentCards extends StatelessWidget {
  final DocumentSnapshot commentVar;
  final DocumentSnapshot fieldVar;

  final User? current_user;
  commentCards(
      {required this.current_user,
      required this.fieldVar,
      required this.commentVar});

  @override
  Widget build(BuildContext context) {
    if (commentVar != null) {
      return Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 2, color: Colors.white70),
        )),
        child: Column(children: [
          Text(commentVar.get('userID'),
              style: TextStyle(color: Colors.white, fontSize: 20)),
          Text(
            commentVar.get('comment'),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ]),
      );
    } else {
      return Text("Hiçbir Yorum Bulunamadı",
          style: TextStyle(color: Colors.white));
    }
  }

  Widget rate() {
    String r = commentVar.get('rate').toString();

    if (r.length < 3) {
      r = r + '.0';
    }

    if (r.length > 3) {
      r = r[0] + r[1] + r[2];
    }
    return Text(
      r,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
