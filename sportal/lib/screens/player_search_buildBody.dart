import 'package:flutter/material.dart';
import 'Player.dart';
import 'player_profile.dart';
import '../bars/bottom_bar_floating_action_button.dart';
import '../bars/bottom_bar_player_search.dart';
import 'HomePage_s.dart';
import '../screens/Background.dart';
import '../bars/local_search_appbar_page.dart';

class PlayerSearchBuildBody extends StatelessWidget{

  static List<Player> players = [
    Player(1, "Okan", "Torun", 22,"SLA","https://pbs.twimg.com/profile_images/1334061742742245376/XIEEBIvv_400x400.jpg","Türkiye","Bursa"),
    Player(2, "Samet", "Nalbant", 27,"MO","https://pbs.twimg.com/profile_images/1410182514652729345/lwIVc69M_400x400.jpg","Türkiye","Bilecik"),
    Player(3, "Mehmet Yalçın", "Alaman",18,"STP","https://media-exp1.licdn.com/dms/image/C4D03AQFzwdfVGxWbvQ/profile-displayphoto-shrink_200_200/0/1616803707483?e=1640822400&v=beta&t=3z4zEBDHf7IU7REmO_skD1OcU-kf5cKR3xY-Ru8AIlI","Almanya","Hamburg"),
    Player(4, "Ömer Faruk", "Erol", 35,"SLB","https://media-exp1.licdn.com/dms/image/C5603AQHxk_oVYQkleA/profile-displayphoto-shrink_200_200/0/1623238342293?e=1640217600&v=beta&t=baRNJMLuBd7MhLrim2q8aBGgMPWD-NvgXIHHRx1dbpU","Türkiye","İstanbul"),
    Player(5, "Ahmet Fırat", "İdi", 24,"STP","https://pbs.twimg.com/profile_images/1299400134447382530/nYQXld7P_400x400.jpg","Türkiye","Tokat"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildHeader(context),
      extendBodyBehindAppBar:
                        true,
        body: buildBody(),
        floatingActionButton: true
        ? buildFloating(context)
        : null,
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: buildBottomBar(),
    );
  }
  Widget buildBody(){
    return Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://github.com/okantorun/Vector-Graphics-Libraray-C/blob/main/JPGs/background%20(1).png?raw=true"),
            fit: BoxFit.cover,
          ),
        ),

        child:Column(children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: players.length ,
              itemBuilder: (BuildContext context, int index)
              {
                return ListTile(
                  title: Text(players[index].firstName+" "+players[index].lastName,
                    style: TextStyle(
                        //fontSize: 10.0,
                        color:Colors.white,
                        //letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Yaş:"+players[index].age.toString()+"\nPozisyon:"+players[index].position,
                      style: TextStyle(
                      fontSize: 13.0,
                      color:Colors.white,

                      //letterSpacing: 2.0,
                      //fontWeight: FontWeight.w400
                  ),
                ),

                  trailing: GestureDetector(onTap: (){
                    ///do something heres
                      print("okan");
                  },child: Container(child: Icon(Icons.message,color: Colors.white))),

                  leading: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(players[index].imageAddress)

                  ),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileUI(index)));
                  },

                );
              },
            ),

          )

        ]

    )
    );
  }
  AppBar buildHeader(BuildContext context) {
    return AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyApp()));
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

}
