import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bars/bottom_bar_floating_action_button.dart';
import '../bars/bottom_bar_player_search.dart';
import 'Background.dart';
import 'field_profile.dart';

class RouteSahaBul extends StatefulWidget {
  final User? current_user;
  RouteSahaBul({required this.current_user});

  @override
  State<RouteSahaBul> createState() => _RouteSahaBulState();
}

class _RouteSahaBulState extends State<RouteSahaBul> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    print(widget.current_user!.uid);
    CollectionReference sahaRef = firestore.collection('sahalar');
    return Scaffold(
      floatingActionButton:
          true ? buildFloating(context, widget.current_user) : null,
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
            StreamBuilder<QuerySnapshot>(
              stream: sahaRef.snapshots(),
              builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                if (asyncSnapshot.hasError) {
                  return Center(child: Text("Bir Hata oluştu."));
                } else {
                  if (asyncSnapshot.hasData) {
                    List<DocumentSnapshot> listOfFields =
                        asyncSnapshot.data.docs;
                    return Flexible(
                      child: ListView.builder(
                          itemCount: listOfFields.length,
                          itemBuilder: (context, index) {
                            return fieldCards(
                              current_user: widget.current_user,
                              fieldVar: listOfFields[index],
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
      ]),
    );
  }

  AppBar buildHeader() {
    return AppBar(
        elevation: 0.0,
        title: Center(
            child: Image.asset('assets/images/Header-Saha-Bul.png',
                height: AppBar()
                    .preferredSize
                    .height)), //image'i app bar'ın yüksekliğine görse resize ediyor
        backgroundColor: Colors.transparent, //AppBar'ı tramsparan yapıyor
        automaticallyImplyLeading: false);
  }
}

class fieldCards extends StatelessWidget {
  final DocumentSnapshot fieldVar;
  final User? current_user;
  fieldCards({required this.current_user, required this.fieldVar});
  Image fav = Image.asset(
    'assets/images/heart.png',
    height: 35,
  );
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FieldProfile(
                        current_user: current_user,
                        fieldVar: fieldVar,
                      )));
        },
        child: Container(
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                  child: Image.network(
                    fieldVar.get('photos')[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: Colors.white70,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10.0, 10, 10, 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              fieldVar.get('name'),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Container(
                              color: Colors.green,
                              padding: EdgeInsets.all(3),
                              child: Row(
                                children: [
                                  rate(),
                                  SizedBox(width: 2),
                                  Image.asset(
                                    'assets/images/star.png',
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              fieldVar.get('mahalle') +
                                  " / " +
                                  fieldVar.get('ilce') +
                                  " / " +
                                  fieldVar.get('il'),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          ),
                          Text(
                            fieldVar.get('cost'),
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            '₺',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        right: 15,
        top: 15,
        child: InkWell(
          onTap: () {
            print(fieldVar.id);

            Map<String, dynamic> tempField = {
              'fieldID': fieldVar.id,
              'adress': fieldVar.get('adress'),
              'commenNum': fieldVar.get('commenNum'),
              'cost': fieldVar.get('cost'),
              'end': fieldVar.get('end'),
              'favNum': fieldVar.get('favNum'),
              'il': fieldVar.get('il'),
              'ilce': fieldVar.get('ilce'),
              'mahalle': fieldVar.get('mahalle'),
              'mail': fieldVar.get('mail'),
              'name': fieldVar.get('name'),
              'phone': fieldVar.get('phone'),
              'photos': fieldVar.get('photos'),
              'properties': fieldVar.get('properties'),
              'rate': fieldVar.get('rate'),
              'start': fieldVar.get('start'),
              'type': fieldVar.get('type'),
            };
            FirebaseFirestore.instance
                .collection('users')
                .doc(current_user!.uid)
                .collection('favoriteFields')
                .doc(fieldVar.id)
                .set(tempField);

            if (firestore
                    .collection('users')
                    .doc(current_user!.uid)
                    .collection('favoriteFields')
                    .doc(fieldVar.id)
                    .id ==
                fieldVar.id) {
              fav = Image.asset(
                'assets/images/red-heart.png',
                height: 35,
              );
            }
          },
          child: fav,
        ),
      ),
    ]);
  }

  Widget rate() {
    String r = fieldVar.get('rate').toString();
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
