import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../bars/bottom_bar_floating_action_button.dart';
import '../bars/bottom_bar_player_search.dart';
import '../bars/buildAppBar.dart';
import 'Background.dart';
import 'Login_s.dart';
import 'RakipBul_s.dart';
import 'SahaBul_s.dart';
import 'player_search_buildBody.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sportal',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Login_screen());
  }
}

class HomePage extends StatefulWidget {
  final User? current_user;

  HomePage({required this.current_user});
  @override
  State<HomePage> createState() => _HomePageState(current_user: current_user);
}

class _HomePageState extends State<HomePage> {
  final User? current_user;

  _HomePageState({required this.current_user});

  @override
  Widget build(BuildContext context) {
    print(current_user!.uid);
    print(current_user);
    return Scaffold(
        floatingActionButton:
            true ? buildFloating(context, current_user) : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: buildBottomBar(),
        appBar: buildAppBar(),
        extendBodyBehindAppBar:
            true, //Body'i appbar kısmına çekiyor (Arka planı uzatmak için)
        body: Stack(children: <Widget>[
          //Arkaplanın üzerine eklenecek widgetlar için stack kullandım
          Background(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomePageMenu(current_user, 'assets/images/sahabul.png', 1),
                  const SizedBox(
                    height: 10,
                  ),
                  HomePageMenu(current_user, 'assets/images/takimbul.png', 2),
                  const SizedBox(
                    height: 10,
                  ),
                  HomePageMenu(current_user, 'assets/images/rakipbul.png', 3),
                ],
              ),
            ),
          )
        ]));
  }
}

BottomAppBar buildBottomAppBar() {
  return BottomAppBar(
    shape: CircularNotchedRectangle(),
    color: Colors.blue,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.home,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.show_chart,
          ),
          onPressed: () {},
        ),
        SizedBox(width: 48.0),
        IconButton(
          icon: Icon(
            Icons.account_circle,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.account_circle,
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
}

class HomePageMenu extends StatelessWidget {
  final String path;
  final int mode;
  final User? current_user;

  HomePageMenu(User? current_user, String _path, int _mode)
      : current_user = current_user,
        path = _path,
        mode = _mode;

  Widget build(BuildContext context) {
    return InkWell(
      //onTap özelliğini kullanarak resim eklemek için InkWell kullandım
      onTap: () {
        if (mode == 1) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  RouteSahaBul(current_user: current_user),
              transitionDuration: Duration.zero,
            ),
          );
        } else if (mode == 2) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  PlayerSearchBuildBody(),
              transitionDuration: Duration.zero,
            ),
          );
        } else if (mode == 3) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => RouteRakipBul(),
              transitionDuration: Duration.zero,
            ),
          );
        }
      },
      child: Image.asset(
        path,
        fit: BoxFit.fill,
      ),
    );
  }
}

FloatingActionButton buildFloatingActionButton(
    User? current_user, BuildContext context) {
  return FloatingActionButton(
    child: Tab(
      icon: Image.asset('assets/images/swirl_and_ball.png'),
      height: 34444,
      iconMargin: EdgeInsetsGeometry.infinity,
    ),
    backgroundColor: Color(0xffcc3de7),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => HomePage(
            current_user: current_user,
          ),
          transitionDuration: Duration.zero,
        ),
      );
    },
  );
}
