import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Background.dart';
import 'HomePage_s.dart';

class RouteSahaBul extends StatelessWidget {
  RouteSahaBul({Key? key}) : super(key: key);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference sahaRef = firestore.collection('user');
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
                            return Card(
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
