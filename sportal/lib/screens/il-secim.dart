import 'package:flutter/material.dart';

class IlSecimiSayfasi extends StatefulWidget {
  final List ilIsimleri;

  const IlSecimiSayfasi({required this.ilIsimleri});
  @override
  _IlSecimiSayfasiState createState() => _IlSecimiSayfasiState();
}

class _IlSecimiSayfasiState extends State<IlSecimiSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.ilIsimleri.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                widget.ilIsimleri[index],
              ),
              onTap: () {
                Navigator.pop(context, index);
              },
            );
          }),
    );
  }
}
