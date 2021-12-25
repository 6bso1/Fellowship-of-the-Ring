import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bars/bottom_bar_floating_action_button.dart';
import '../bars/bottom_bar_player_search.dart';
import 'Background.dart';

class RouteSahaBul extends StatelessWidget {
  RouteSahaBul({Key? key}) : super(key: key);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference sahaRef = firestore.collection('sahalar');
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
                              fieldVar: listOfFields[index],
                            );
                            /*Card(
                              color: Colors.red,
                              child: ListTile(
                                title: Text(
                                    '${listOfFields[index].get('name')}',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white)),
                                subtitle: Text(
                                    '${listOfFields[index].get('adress')}',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                              ),
                            );*/
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
  fieldCards({required this.fieldVar});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(children: <Widget>[
            Image.asset('assets/images/Header-Saha-Bul.png')
          ]),
          Container(
            color: Colors.white70,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      fieldVar.get('name'),
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    )
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        fieldVar.get('adress'),
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
