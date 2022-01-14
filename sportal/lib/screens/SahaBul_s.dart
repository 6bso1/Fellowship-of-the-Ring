import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bars/bottom_bar_floating_action_button.dart';
import '../bars/bottom_bar_player_search.dart';
import 'Background.dart';
import 'field_profile.dart';

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
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FieldProfile(
                      fieldVar: fieldVar,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Image.network(
                fieldVar.get('photos')[0],
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.white70,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text(
                          fieldVar.get('name'),
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        padding: EdgeInsets.all(10.0),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          fieldVar.get('adress'),
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                      ),
                      Align(
                        child: SafeArea(
                          child: Container(
                              child: Text(fieldVar.get('cost')),
                              padding:
                                  EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0)),
                        ),
                        alignment: Alignment.centerRight,
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
