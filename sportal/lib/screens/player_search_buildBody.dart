import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Player.dart';
import 'player_profile.dart';
import '../bars/bottom_bar_floating_action_button.dart';
import '../bars/bottom_bar_player_search.dart';
import 'HomePage_s.dart';

enum SingingCharacter { lafayette, jefferson }

class PlayerSearchBuildBody extends StatefulWidget {
  const PlayerSearchBuildBody({Key? key}) : super(key: key);

  @override
  _PlayerSearchBuildBodyState createState() => _PlayerSearchBuildBodyState();
}

class _PlayerSearchBuildBodyState extends State<PlayerSearchBuildBody> {
  // form key
  bool firstEntry = true;
  final rb1 = 'Oyuncu Arıyorum';
  final rb2 = 'Takım Arıyorum';
  var status1 = 1;
  var status2 = 0;
  final descrController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  TextEditingController emailController = TextEditingController();
  SingingCharacter? _character = SingingCharacter.lafayette;

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
                    builder: (context) => HomePage(
                          current_user: null,
                        )));
          },
        ),
        title: Center(
            child: Image.asset('assets/images/Header-Takim-Bul.png',
                height: AppBar()
                    .preferredSize
                    .height)), //image'i app bar'ın yüksekliğine görse resize ediyor
        backgroundColor: Colors.transparent, //AppBar'ı tramsparan yapıyor
        automaticallyImplyLeading: false);
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference annRef = firestore.collection('announcement');
    final anncText = Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        hintColor: Colors.grey,
      ),
      child: Center(
        child: TextFormField(
          key: _formKey,
          controller: descrController,
          obscureText: false,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            color: Color(0xffffffff),
            height: 1.5,
          ),
          onSaved: (value) {
            descrController.text = value!;
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 1.0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomRight: Radius.circular(10),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 1.0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomRight: Radius.circular(10),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(),
            ),
            labelText: "Mesaj",
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Mesaj içeriği",
          ),
        ),
      ),
    );
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Colors.grey[300],
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    return Scaffold(
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
                if (firstEntry) {
                  if (streamSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    firstEntry = false;
                  }
                }

                if (usersCollection == null) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
                }

                return Column(
                  children: [
                    Container(
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(12.0),
                          color: const Color.fromRGBO(255, 255, 255, 0.4),
                        ),
                        height: MediaQuery.of(context).size.height / 2.5,
                        margin: const EdgeInsets.only(top: 150.0),
                        padding: const EdgeInsets.only(left: 30.0, right: 30),
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(streamSnapshot.data?['image']),
                                radius: 30.0,
                              ),
                            ),
                            anncText,
                            ListTile(
                              title: Text(rb1),
                              leading: Radio<SingingCharacter>(
                                value: SingingCharacter.lafayette,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value;
                                    status1 = 1;
                                    status2 = 0;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text(rb2),
                              leading: Radio<SingingCharacter>(
                                value: SingingCharacter.jefferson,
                                groupValue: _character,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value;
                                    status1 = 0;
                                    status2 = 1;
                                  });
                                },
                              ),
                            ),
                            ButtonTheme(
                              buttonColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal:
                                      8.0), //adds padding inside the button
                              materialTapTargetSize: MaterialTapTargetSize
                                  .shrinkWrap, //limits the touch area to the button area
                              minWidth: 0, //wraps child's width
                              height: 0, //wraps child's height
                              child: RaisedButton(
                                  onPressed: () {
                                    final firstName =
                                        streamSnapshot.data?['firstName'];
                                    final secondName =
                                        streamSnapshot.data?['secondName'];
                                    final age = streamSnapshot.data?['age'];
                                    final image = streamSnapshot.data?['image'];
                                    final email = streamSnapshot.data?['email'];
                                    final position =
                                        streamSnapshot.data?['position'];
                                    final phoneNumber =
                                        streamSnapshot.data?['phoneNumber'];
                                    final country =
                                        streamSnapshot.data?['country'];
                                    final city = streamSnapshot.data?['city'];
                                    final town = streamSnapshot.data?['town'];
                                    if (status1 == 1) {
                                      addAnnouncement(
                                          descrController.text,
                                          rb1,
                                          firstName,
                                          secondName,
                                          phoneNumber,
                                          town,
                                          city,
                                          country,
                                          age,
                                          email,
                                          position,
                                          image);
                                    }
                                    if (status2 == 1) {
                                      addAnnouncement(
                                          descrController.text,
                                          rb2,
                                          firstName,
                                          secondName,
                                          phoneNumber,
                                          town,
                                          city,
                                          country,
                                          age,
                                          email,
                                          position,
                                          image);
                                    }
                                    descrController.clear();
                                  },
                                  child: Text("Gönder")), //your original button
                            ),
                          ],
                        )),
                    StreamBuilder<QuerySnapshot>(
                        stream: annRef.snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot asyncSnapshot) {
                          List<DocumentSnapshot> listOfFields = [];
                          if (asyncSnapshot.data != null) {
                            if (asyncSnapshot.data.docs != null) {
                              listOfFields = asyncSnapshot.data.docs;
                            }
                          }
                          return Expanded(
                            child: Container(
                                child: listOfFields.isNotEmpty
                                    ? ListView.builder(
                                        itemCount: listOfFields.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return index >= 0 &&
                                                  listOfFields[index]
                                                          .get("validity") ==
                                                      "1"
                                              ? ListTile(
                                                  title: Text(
                                                    listOfFields[index]
                                                            .get("firstName") +
                                                        " " +
                                                        listOfFields[index]
                                                            .get("secondName"),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    "Açıklama:" +
                                                        listOfFields[index]
                                                            .get("desc") +
                                                        "\nYaş:" +
                                                        listOfFields[index]
                                                            .get("age") +
                                                        "\nPozisyon:" +
                                                        listOfFields[index]
                                                            .get("position") +
                                                        "\nStatus:" +
                                                        listOfFields[index]
                                                            .get("status") +
                                                        "\ne-mail:" +
                                                        listOfFields[index]
                                                            .get("email"),
                                                    style: const TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  trailing:
                                                      FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid ==
                                                              listOfFields[
                                                                      index]
                                                                  .get("uid")
                                                          ? GestureDetector(
                                                              onTap:
                                                                  () =>
                                                                      showDialog<
                                                                          String>(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext context) =>
                                                                                AlertDialog(
                                                                          title:
                                                                              const Text('Dikkat'),
                                                                          content:
                                                                              const Text('İlanı kaldırmak istediğinize emein misiniz ?'),
                                                                          actions: <
                                                                              Widget>[
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                              child: const Text('Hayır'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                String? docId = listOfFields[index].get("docId");
                                                                                annRef
                                                                                    .doc(
                                                                                        docId) // <-- Doc ID where data should be updated.
                                                                                    .update({
                                                                                  'validity': '0'
                                                                                });
                                                                                Navigator.pop(context, 'Cancel');
                                                                                Fluttertoast.showToast(msg: "İlan başarıyla silindi ");
                                                                              },
                                                                              child: const Text('Evet'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                              child: const Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .white))
                                                          : GestureDetector(
                                                              onTap: () {},
                                                              child: const Icon(
                                                                  Icons.message,
                                                                  color: Colors
                                                                      .white)),
                                                  leading: CircleAvatar(
                                                      radius: 25.0,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              listOfFields[
                                                                      index]
                                                                  .get(
                                                                      "image"))),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ProfileUI(
                                                                listOfFields[index].get(
                                                                    "firstName"),
                                                                listOfFields[index].get(
                                                                    "secondName"),
                                                                listOfFields[index]
                                                                    .get("age"),
                                                                listOfFields[index]
                                                                    .get(
                                                                        "city"),
                                                                listOfFields[index]
                                                                    .get(
                                                                        "town"),
                                                                listOfFields[
                                                                        index]
                                                                    .get(
                                                                        "country"),
                                                                listOfFields[index].get(
                                                                    "phoneNumber"),
                                                                listOfFields[index].get(
                                                                    "position"),
                                                                listOfFields[
                                                                        index]
                                                                    .get(
                                                                        "image"),
                                                                listOfFields[
                                                                        index]
                                                                    .get(
                                                                        "email"))));
                                                  },
                                                )
                                              : const SizedBox(
                                                  height: 0,
                                                  width: 0,
                                                );
                                        },
                                      )
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      )),
                          );
                        })
                  ],
                );
              })),
      floatingActionButton: buildFloating(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomBar(),
    );
  }

  void addAnnouncement(
      String descr,
      String status,
      String firstName,
      String secondName,
      String phoneNumber,
      String town,
      String city,
      String country,
      String age,
      String email,
      String position,
      String image) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference announcementRef =
        FirebaseFirestore.instance.collection("announcement");
    String docId = announcementRef.doc().id;

    announcementRef.doc(docId).set({
      'desc': '$descr',
      'status': '$status',
      'firstName': '$firstName',
      'secondName': '$secondName',
      'phoneNumber': '$phoneNumber',
      'age': '$age',
      'town': '$town',
      'city': '$city',
      'country': '$country',
      'email': '$email',
      'position': '$position',
      'image': '$image',
      'validity': '1',
      'docId': docId,
      'uid': FirebaseAuth.instance.currentUser!.uid
    });
    Fluttertoast.showToast(msg: "İlan başarıyla paylaşıldı ");
  }
}
