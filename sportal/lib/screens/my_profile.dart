import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportal/screens/player_search_buildBody.dart';
import 'edit_profile.dart';
import '../bars/bottom_bar_player_search.dart';
import '../bars/bottom_bar_floating_action_button.dart';
import 'HomePage_s.dart';

class MyProfileUI extends StatelessWidget {

  static Map<String, String> myMap={};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  AppBar buildHeader(BuildContext context) {
    return AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PlayerSearchBuildBody()));
          },
        ),
       
        backgroundColor: Colors.transparent, //AppBar'ı tramsparan yapıyor
        automaticallyImplyLeading: false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: true ? buildFloating(context) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomBar(),

      appBar: buildHeader(context),
      extendBodyBehindAppBar: true,
    body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: StreamBuilder<DocumentSnapshot>(
        stream: usersCollection.doc(user?.uid).snapshots(),
        builder: (ctx, streamSnapshot) {
          myMap["uid"]=streamSnapshot.data?['uid'];
          myMap["firstName"]=streamSnapshot.data?['firstName'];
          myMap["secondName"]=streamSnapshot.data?['secondName'];
          myMap["age"]=streamSnapshot.data?['age'];
          myMap["image"]=streamSnapshot.data?['image'];
          myMap["position"]=streamSnapshot.data?['position'];
          myMap["phone"]=streamSnapshot.data?['phoneNumber'];
          myMap["town"]=streamSnapshot.data?['town'];
          myMap["city"]=streamSnapshot.data?['city'];
          myMap["email"]=streamSnapshot.data?['email'];
          myMap["password"]=streamSnapshot.data?['password'];
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
              ),
            );
          }
          return Column(
            children: [

              SizedBox(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: const Alignment(0.0,3.5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        streamSnapshot.data?['image']
                    ),
                    radius: 70.0,
                  ),
                ),
              ),

              const SizedBox(
                height: 80,
              ),
              Text(
                streamSnapshot.data?['firstName']+" "+ streamSnapshot.data?['secondName']
                ,style: const TextStyle(
                  fontSize: 25.0,
                  color:Colors.white,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400
              ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                streamSnapshot.data?['age']+","+streamSnapshot.data?['city']+"/"+streamSnapshot.data?['country'],
                style: const TextStyle(
                    fontSize: 14.0,
                    color:Colors.white,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w300
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonTheme(
                buttonColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), //adds padding inside the button
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, //limits the touch area to the button area
                minWidth: 0, //wraps child's width
                height: 0, //wraps child's height
                child: RaisedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SettingsUI()));
                    },
                    child: const Text("Profili Düzenle")
                ), //your original button
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  alignment: const Alignment(-0.9,3.5),
                  child: const Text(
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
                  alignment: const Alignment(-0.9,3.5),
                  child: Text(
                    streamSnapshot.data?['position'],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 11.0,
                        color:Colors.white,
                        //letterSpacing: 0.5,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Stack(
                children:<Widget>[
                  Positioned(
                    child: Container(
                      alignment: const Alignment(-0.9,0.0),
                      child: const Icon(
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
                      alignment: const Alignment(-0.7,4),
                      child: Text(
                        streamSnapshot.data?['phoneNumber'],
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 13.0,
                            color:Colors.white,
                            //letterSpacing: 0.5,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),],),
              const SizedBox(
                height: 10,
              ),
              Stack(
                children:<Widget>[
                  Positioned(
                    child: Container(
                      alignment: const Alignment(-0.9,0.0),
                      child: const Icon(
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
                      alignment: const Alignment(-0.7,4),
                      child: Text(
                        streamSnapshot.data?['town']+"/"+streamSnapshot.data?['city'],
                        textAlign: TextAlign.left,
                        style: const TextStyle(
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
