import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dcdg/dcdg.dart';
import '../bars/buildAppBar.dart';
import 'Background.dart';
import 'RakipBul_s.dart';
import 'SahaBul_s.dart';
import 'TakimBul_s.dart';
import 'player_search_buildBody.dart';
import '../bars/bottom_bar_player_search.dart';
import '../bars/bottom_bar_floating_action_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sportal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: true
            ? buildFloating(context)
            : null,
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
                  HomePageMenu('assets/images/sahabul.png', 1),
                  const SizedBox(
                    height: 10,
                  ),
                  HomePageMenu('assets/images/takimbul.png', 2),
                  const SizedBox(
                    height: 10,
                  ),
                  HomePageMenu('assets/images/rakipbul.png', 3),
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

  HomePageMenu(String _path, int _mode)
      : path = _path,
        mode = _mode;

  Widget build(BuildContext context) {
    return InkWell(
      //onTap özelliğini kullanarak resim eklemek için InkWell kullandım
      onTap: () {
        if (mode == 1) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => RouteSahaBul(),
              transitionDuration: Duration.zero,
            ),
          );
        } else if (mode == 2) {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => PlayerSearchBuildBody(),
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

FloatingActionButton buildFloatingActionButton(BuildContext context) {
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
          pageBuilder: (context, animation1, animation2) => HomePage(),
          transitionDuration: Duration.zero,
        ),
      );
    },
  );
}
