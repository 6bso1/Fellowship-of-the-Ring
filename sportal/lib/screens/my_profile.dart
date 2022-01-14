import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'player_search_buildBody.dart';
import 'edit_profile.dart';
import 'Background.dart';
import '../bars/bottom_bar_player_search.dart';
import '../bars/bottom_bar_floating_action_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyProfileUI extends StatelessWidget {
  int index;
  MyProfileUI(int this.index)
  {
    this.index=index;
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: true ? buildFloating(context) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomBar(),

    body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: StreamBuilder<DocumentSnapshot>(
        stream: usersCollection.doc(user?.uid).snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
              ),
            );
          }
          return Column(
            children: [

              Container(

                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    alignment: Alignment(0.0,3.5),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          PlayerSearchBuildBody.players[index].imageAddress
                      ),
                      radius: 70.0,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 80,
              ),
              Text(
                streamSnapshot.data?['firstName']+" "+ streamSnapshot.data?['secondName']
                ,style: TextStyle(
                  fontSize: 25.0,
                  color:Colors.white,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400
              ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                PlayerSearchBuildBody.players[index].age.toString()+","+PlayerSearchBuildBody.players[index].city+"/"+PlayerSearchBuildBody.players[index].country,
                style: TextStyle(
                    fontSize: 14.0,
                    color:Colors.white,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w300
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ButtonTheme(
                buttonColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), //adds padding inside the button
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, //limits the touch area to the button area
                minWidth: 0, //wraps child's width
                height: 0, //wraps child's height
                child: RaisedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SettingsUI(index)));
                    },
                    child: Text("Profili Düzenle")
                ), //your original button
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  alignment: Alignment(-0.9,3.5),
                  child: Text(
                    "Tercih Edilen Pozisyonlar:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 13.0,
                        color:Colors.white,
                        //letterSpacing: 0.5,
                        fontWeight: FontWeight.w400
                    ),
                  ),

                ),
              ),

              SizedBox(
                width: double.infinity,
                child: Container(
                  //color: Colors.red,
                  alignment: Alignment(-0.9,3.5),
                  child: Text(
                    "Kaleci\nDefans",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 11.0,
                        color:Colors.white,
                        //letterSpacing: 0.5,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Stack(
                children:<Widget>[
                  Positioned(
                    child: Container(
                      alignment: Alignment(-0.9,0.0),
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
                      alignment: Alignment(-0.7,4),
                      child: Text(
                        "0533 027 28 93",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 13.0,
                            color:Colors.white,
                            //letterSpacing: 0.5,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),],),
              SizedBox(
                height: 10,
              ),
              Stack(
                children:<Widget>[
                  Positioned(
                    child: Container(
                      alignment: Alignment(-0.9,0.0),
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
                      alignment: Alignment(-0.7,4),
                      child: Text(
                        "Istanbul/Pendik",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 13.0,
                            color:Colors.white,
                            //letterSpacing: 0.5,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),],),


            ],
          );
        },
    ),
    ),
    );
  }
}
