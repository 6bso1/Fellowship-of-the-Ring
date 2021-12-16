import 'package:flutter/material.dart';
import '../screens/player_screen.dart';

Widget buildBottomBar() {
  return _DemoBottomAppBar(
    fabLocation: FloatingActionButtonLocation.centerDocked,
    shape: true ? const CircularNotchedRectangle() : null,
  );
}

class _DemoBottomAppBar extends StatelessWidget {
  const _DemoBottomAppBar({
    this.fabLocation = FloatingActionButtonLocation.endDocked,
    this.shape = const CircularNotchedRectangle(),
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;

  static final List<FloatingActionButtonLocation> centerLocations =
  <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: shape,
      color: Color(0xFF4AC5F6),
      child: IconTheme(
        data: IconThemeData(color: Theme
            .of(context)
            .colorScheme
            .onPrimary),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.favorite),
              iconSize: 35,
              color: Colors.black,
              onPressed: () {},
            ),
            if (centerLocations.contains(fabLocation)) const Spacer(),
            IconButton(
              tooltip: 'Message',
              icon: const Icon(Icons.message),
              iconSize: 35,
              color: Colors.black,
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Profile',
              icon: const Icon(Icons.account_circle),
              iconSize: 35,
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfileUI(0)));
              },
            ),
          ],
        ),
      ),
    );
  }
}



