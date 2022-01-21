import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sportal/bars/bottom_bar_floating_action_button.dart';
import 'package:sportal/bars/bottom_bar_player_search.dart';

import 'Background.dart';

class FieldComments extends StatefulWidget {
  final DocumentSnapshot fieldVar;
  final User? current_user;
  const FieldComments({required this.current_user, required this.fieldVar});
  @override
  _FieldCommentsState createState() =>
      _FieldCommentsState(fieldVar: fieldVar, current_user: current_user);
}

class _FieldCommentsState extends State<FieldComments> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DocumentSnapshot fieldVar;
  final User? current_user;
  TextEditingController reviewController = TextEditingController();
  _FieldCommentsState({required this.current_user, required this.fieldVar});
  double rating = 3.0;
  @override
  Widget build(BuildContext context) {
    int commentNum = fieldVar.get('commenNum');
    double rate = fieldVar.get('rate') + 0.0;
    final _formKey = GlobalKey<FormState>();
    CollectionReference commentRef = fieldVar.reference.collection('Rewieves');
    return Scaffold(
        floatingActionButton:
            true ? buildFloating(context, current_user) : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: buildBottomBar(),
        appBar: buildHeader(),
        extendBodyBehindAppBar:
            true, //Body'i appbar kısmına çekiyor (Arka planı uzatmak için)
        body: Stack(children: <Widget>[
          //Arkaplanın üzerine eklenecek widgetlar için stack kullandım
          const Background(),
          SafeArea(
              child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  fieldVar.get('name') + ' Değerlendirmeler',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                right: -40.0,
                                top: -40.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.close),
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: reviewController,
                                        validator: (value) {
                                          RegExp regex = new RegExp(r'^.{3,}$');
                                          if (value!.isEmpty) {
                                            return ("İsim boş bırakılamaz");
                                          }
                                          if (!regex.hasMatch(value)) {
                                            return ("Geçerli bir isim giriniz (En az 3 karakter)");
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: "Değerlendirmeniz"),
                                      ),
                                    ),
                                    StarRating(
                                      rating: rating,
                                      onRatingChanged: (rating) =>
                                          setState(() => this.rating = rating),
                                      color: Colors.red,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        child: Text("Değerlendir"),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                          }
                                          Map<String, dynamic> reviewData = {
                                            'userID': current_user!.uid,
                                            'userMail': current_user!.email,
                                            'comment': reviewController.text,
                                            'rate': rating,
                                            'date': DateFormat('dd-MM-yyyy')
                                                .format(DateTime.now())
                                          };

                                          await commentRef
                                              .doc()
                                              .set(reviewData);

                                          rate = (rate * commentNum + rating) /
                                              (commentNum + 1);
                                          Map<String, dynamic> dataRate = {
                                            'rate': rate
                                          };

                                          commentNum = commentNum + 1;
                                          Map<String, dynamic> data = {
                                            'commenNum': commentNum
                                          };

                                          await FirebaseFirestore.instance
                                              .collection('sahalar')
                                              .doc(fieldVar.id)
                                              .update(data);

                                          await FirebaseFirestore.instance
                                              .collection('sahalar')
                                              .doc(fieldVar.id)
                                              .update(dataRate);
                                          print(rate);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      Text(
                        "  Yorum Ekleyin",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: commentRef.snapshots(),
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return Center(child: Text("Bir Hata oluştu."));
                  } else {
                    if (asyncSnapshot.hasData) {
                      List<DocumentSnapshot> listOfComments =
                          asyncSnapshot.data.docs;
                      return Flexible(
                        child: ListView.builder(
                            itemCount: listOfComments.length,
                            itemBuilder: (context, index) {
                              return commentCards(
                                current_user: current_user,
                                commentVar: listOfComments[index],
                                fieldVar: fieldVar,
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
        ]));
  }

  AppBar buildHeader() {
    return AppBar(
        elevation: 0.0,
        title: Center(
            child: Image.asset('assets/images/logobar.png',
                height: AppBar()
                    .preferredSize
                    .height)), //image'i app bar'ın yüksekliğine görse resize ediyor
        backgroundColor: Colors.transparent, //AppBar'ı tramsparan yapıyor
        automaticallyImplyLeading: false);
  }
}

class commentCards extends StatelessWidget {
  final DocumentSnapshot commentVar;
  final DocumentSnapshot fieldVar;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? current_user;
  commentCards(
      {required this.current_user,
      required this.fieldVar,
      required this.commentVar});

  @override
  Widget build(BuildContext context) {
    if (commentVar != null) {
      return Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 2, color: Colors.white70),
        )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(commentVar.get('userMail'),
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
                SizedBox(width: 2),
              ],
            ),
            Row(
              children: [
                Text(
                  commentVar.get('rate').toString(),
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                SizedBox(width: 2),
                Image.asset(
                  'assets/images/star.png',
                  height: 16,
                ),
                SizedBox(width: 3),
                Text(
                  commentVar.get('date').toString(),
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  commentVar.get('comment'),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(width: 1),
              ],
            ),
          ]),
        ),
      );
    } else {
      return Text("Hiçbir Yorum Bulunamadı",
          style: TextStyle(color: Colors.white));
    }
  }
}

typedef void RatingChangeCallback(double rating);

class StarRating extends StatefulWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating(
      {this.starCount = 5,
      this.rating = .0,
      required this.onRatingChanged,
      required this.color});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= widget.rating) {
      icon = new Icon(
        Icons.star_border,
        color: Colors.blue,
      );
    } else if (index > widget.rating - 1 && index < widget.rating) {
      icon = new Icon(
        Icons.star_half,
        color: Colors.grey,
      );
    } else {
      icon = new Icon(
        Icons.star,
        color: Colors.grey,
      );
    }
    return new InkResponse(
      onTap: widget.onRatingChanged == null
          ? null
          : () => widget.onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        children: new List.generate(
            widget.starCount, (index) => buildStar(context, index)));
  }
}
