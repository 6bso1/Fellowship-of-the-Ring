import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/Chat_s.dart';
import 'package:sportal/model/user_model.dart';

class MessageSearchScreen extends StatefulWidget {
  @override
  _MessageSearchScreenState createState() => _MessageSearchScreenState();
}

class _MessageSearchScreenState extends State<MessageSearchScreen>
    with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  Map<String, dynamic>? userMap2;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    getCurrentUser();
    userMap = null;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    isLoading = true;
    setState(() {
      isLoading = true;
    });
    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        isLoading = false;
      } else {
        setState(() {
          if (!value.docs[0].data().isEmpty) {
            userMap = value.docs[0].data();
          }
          isLoading = false;
        });
      }
      print(userMap);
    });
  }

  void getCurrentUser() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    User? user = _auth.currentUser;
    print(user!.uid);
    final uuid = user.uid;
    print(uuid);

    await _firestore
        .collection('users')
        .where("uid", isEqualTo: uuid)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        isLoading = false;
      } else {
        setState(() {
          if (!value.docs[0].data().isEmpty) {
            userMap2 = value.docs[0].data();
          }
          isLoading = false;
        });
      }
      print(userMap2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
        title: "welcome",
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Color(0xFF631FC9),
              title: Text("Kullanıcı ara",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF4AC5F6),
                      fontWeight: FontWeight.bold)),
            ),
            body: isLoading
                ? Center(
                    child: Container(
                      height: size.height / 20,
                      width: size.height / 20,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: size.height / 20,
                      ),
                      Container(
                        height: size.height / 14,
                        width: size.width,
                        alignment: Alignment.center,
                        child: Container(
                          height: size.height / 14,
                          width: size.width / 1.15,
                          child: TextField(
                            controller: _search,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: "Mail adresi",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      ElevatedButton(
                        onPressed: onSearch,
                        child: Text("Search"),
                      ),
                      SizedBox(
                        height: size.height / 30,
                      ),
                      if (userMap != null)
                        ListTile(
                          onTap: () {
                            String roomId = chatRoomId(
                                userMap2!['firstName'], userMap!['firstName']);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChatRoom(
                                  chatRoomId: roomId,
                                  userMap: userMap!,
                                  currentName: userMap2!['firstName'],
                                ),
                              ),
                            );
                          },
                          leading: Icon(Icons.account_box, color: Colors.white),
                          title: Text(
                            userMap!['firstName'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            userMap!['email'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Icon(Icons.chat, color: Colors.white),
                        )
                      else
                        Container(),
                    ],
                  ),
          ),
        ));
  }
}
