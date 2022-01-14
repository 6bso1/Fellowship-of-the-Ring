// ignore_for_file: unnecessary_new, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
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
  static List<Player> players = [
    Player(
        1,
        "Okan",
        "Torun",
        22,
        "SLA",
        "https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg",
        "Türkiye",
        "Bursa"),
    Player(
        2,
        "Samet",
        "Nalbant",
        27,
        "MO",
        "https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg",
        "Türkiye",
        "Bilecik"),
    Player(
        3,
        "Mehmet Yalçın",
        "Alaman",
        18,
        "STP",
        "https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg",
        "Almanya",
        "Hamburg"),
    Player(
        4,
        "Ömer Faruk",
        "Erol",
        35,
        "SLB",
        "https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg",
        "Türkiye",
        "İstanbul"),
    Player(
        5,
        "Ahmet Fırat",
        "İdi",
        24,
        "STP",
        "https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg",
        "Türkiye",
        "Tokat"),
  ];

  @override
  _PlayerSearchBuildBodyState createState() => _PlayerSearchBuildBodyState();
}

class _PlayerSearchBuildBodyState extends State<PlayerSearchBuildBody> {
  // form key
  final rb1 = 'Oyuncu Arıyorum';
  final rb2 = 'Takım Arıyorum';
  var status1=1;
  var status2=0;
  final descrController = new TextEditingController();

  static List<Player> players = [
    Player(
        1,
        "Okan",
        "Torun",
        22,
        "SLA",
        "https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg",
        "Türkiye",
        "Bursa"),
    Player(
        2,
        "Samet",
        "Nalbant",
        27,
        "MO",
        "https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg",
        "Türkiye",
        "Bilecik"),
    Player(
        3,
        "Mehmet Yalçın",
        "Alaman",
        18,
        "STP",
        "https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg",
        "Almanya",
        "Hamburg"),
    Player(
        4,
        "Ömer Faruk",
        "Erol",
        35,
        "SLB",
        "https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg",
        "Türkiye",
        "İstanbul"),
    Player(
        5,
        "Ahmet Fırat",
        "İdi",
        24,
        "STP",
        "https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg",
        "Türkiye",
        "Tokat"),
  ];
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyApp()));
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

  @override
  Widget build(BuildContext context) {
    final anncText = Theme(
      data: new ThemeData(
        primaryColor: Colors.green,
        hintColor: Colors.grey,
      ),
      child: Center(
        child: TextFormField(
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
            image: NetworkImage(
                "https://github.com/okantorun/Vector-Graphics-Libraray-C/blob/main/JPGs/background%20(1).png?raw=true"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg"),
                        radius: 30.0,
                      ),
                    ),
                    Center(child: anncText),
                    ListTile(
                      title:  Text(rb1),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.lafayette,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                            status1=1;
                            status2=0;
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
                            status1=0;
                            status2=1;
                          });
                        },
                      ),
                    ),
                    ButtonTheme(
                      buttonColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), //adds padding inside the button
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, //limits the touch area to the button area
                      minWidth: 0, //wraps child's width
                      height: 0, //wraps child's height
                      child: RaisedButton(
                          onPressed: (){
                            if(status1==1){
                              addAnnouncement(descrController.text,rb1);
                            }
                            if(status2==1) {
                              addAnnouncement(descrController.text, rb1);
                              print(descrController.text);
                            }
                            descrController.clear();

                          },
                          child: Text("Gönder")
                      ), //your original button
                    ),
                   /*ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {},
                      child: const Text('Send'),
                    ),*/
                  ],
                )),
            Expanded(
              child: Container(
                  child: players.isNotEmpty
                      ? ListView.builder(
                    itemCount: players.length,
                    itemBuilder: (BuildContext context, int index) {
                      return index >= 0
                          ? ListTile(
                        title: Text(
                          players[index].firstName +
                              " " +
                              players[index].lastName,
                          style: const TextStyle(
                            //fontSize: 10.0,
                            color: Colors.white,
                            //letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Yaş:" +
                              players[index].age.toString() +
                              "\nPozisyon:" +
                              players[index].position,
                          style: const TextStyle(
                            fontSize: 13.0,
                            color: Colors.white,

                            //letterSpacing: 2.0,
                            //fontWeight: FontWeight.w400
                          ),
                        ),
                        trailing: GestureDetector(
                            onTap: () {
                              ///do something heres
                              // print("okan");
                            },
                            child: const Icon(Icons.message,
                                color: Colors.white)),
                        leading: CircleAvatar(
                            radius: 25.0,
                            backgroundImage: NetworkImage(
                                players[index].imageAddress)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileUI(index)));
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
                  )
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: buildFloating(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomBar(),
    );
  }
  void addAnnouncement(String descr,String status){
     FirebaseFirestore firestore = FirebaseFirestore.instance;
     CollectionReference announcementRef =
            FirebaseFirestore.instance.collection("announcement");
     announcementRef.add({'desc': '$descr','status': '$status'});
     Fluttertoast.showToast(msg: "İlan başarıyla paylaşıldı ");
  }

}
