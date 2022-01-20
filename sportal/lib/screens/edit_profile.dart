import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'HomePage_s.dart';
import 'my_profile.dart';

class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _image = File("not updated");
  int flagImage = 0;
  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController town = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController position = TextEditingController();

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image!.path);
        print('Image Path $_image');
      });

      flagImage = 1;
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(new DateTime.now().millisecondsSinceEpoch.toString() +
              "." +
              _image.path);
      UploadTask uploadTask = reference.putFile(_image);
      fileName = await (await uploadTask).ref.getDownloadURL();
      DatabaseReference databaseReference =
          FirebaseDatabase.instance.ref().child("Data");
      String? uploadID = databaseReference.push().key;

      FirebaseFirestore.instance
          .collection('users')
          .doc(MyProfileUI.myMap["uid"])
          .update({'image': fileName});
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
      appBar: buildHeader(context),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Profili Düzenle",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Color(0xff476cfb),
                        child: ClipOval(
                          child: SizedBox(
                              width: 180.0,
                              height: 180.0,
                              child: (flagImage == 0)
                                  ? Image.network(
                                      MyProfileUI.myMap["image"].toString(),
                                      fit: BoxFit.fill,
                                    )
                                  : Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    )),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 100,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: IconButton(
                            //Icons.edit,
                            icon: Icon(Icons.edit),
                            color: Colors.white,
                            onPressed: () {
                              getImage();
                            },
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              buildTextField(1, MyProfileUI.myMap["firstName"].toString(),
                  false, firstName),
              buildTextField(2, MyProfileUI.myMap["secondName"].toString(),
                  false, secondName),
              buildTextField(
                  3, MyProfileUI.myMap["email"].toString(), false, email),
              buildTextField(
                  5, MyProfileUI.myMap["town"].toString(), false, town),
              buildTextField(
                  6, MyProfileUI.myMap["city"].toString(), false, city),
              buildTextField(
                  7, MyProfileUI.myMap["phone"].toString(), false, phone),
              buildTextField(
                  8, MyProfileUI.myMap["age"].toString(), false, age),
              buildTextField(
                  9, MyProfileUI.myMap["position"].toString(), false, position),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                    current_user: null,
                                  )));
                    },
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      uploadPic(context);
                      updateInformation();
                      child:
                      CircularProgressIndicator(
                        color: Colors.blue,
                      );

                      Future.delayed(
                          Duration(seconds: 5),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyProfileUI())));
                    },
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(int labelText, String placeholder,
      bool isPasswordTextField, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: ctrl,
        style: TextStyle(color: Colors.white),
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            prefixIcon: labelText == 1
                ? Icon(Icons.account_circle, color: Colors.white)
                : labelText == 2
                    ? Icon(Icons.account_circle, color: Colors.white)
                    : labelText == 3
                        ? Icon(Icons.mail, color: Colors.white)
                        : labelText == 4
                            ? Icon(Icons.lock, color: Colors.white)
                            : labelText == 5
                                ? Icon(Icons.location_on, color: Colors.white)
                                : labelText == 6
                                    ? Icon(Icons.location_on,
                                        color: Colors.white)
                                    : labelText == 7
                                        ? Icon(Icons.phone, color: Colors.white)
                                        : labelText == 8
                                            ? Icon(Icons.calendar_today,
                                                color: Colors.white)
                                            : labelText == 9
                                                ? Icon(Icons.sports_football,
                                                    color: Colors.white)
                                                : null,

            // prefixIcon: Icon(Icons.mail) ,
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 1),
            //labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.3),
            )),
      ),
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyProfileUI()));
          },
        ),
        backgroundColor: Colors.transparent, //AppBar'ı tramsparan yapıyor
        automaticallyImplyLeading: false);
  }

  void updateInformation() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userRef = firestore.collection('users');
    if (firstName.text != "") MyProfileUI.myMap["firstName"] = firstName.text;
    if (secondName.text != "")
      MyProfileUI.myMap["secondName"] = secondName.text;
    if (age.text != "") MyProfileUI.myMap["age"] = age.text;
    if (town.text != "") MyProfileUI.myMap["town"] = town.text;
    if (city.text != "") MyProfileUI.myMap["city"] = city.text;
    if (phone.text != "") MyProfileUI.myMap["phone"] = phone.text;
    if (email.text != "") MyProfileUI.myMap["email"] = email.text;
    if (position.text != "") MyProfileUI.myMap["position"] = position.text;
    print("bbbbbbbbb   " + MyProfileUI.myMap["docId"].toString());
    userRef
        .doc(MyProfileUI
            .myMap["docId"]) // <-- Doc ID where data should be updated.
        .update({
      'firstName': MyProfileUI.myMap["firstName"],
      'secondName': MyProfileUI.myMap["secondName"],
      'town': MyProfileUI.myMap["town"],
      'city': MyProfileUI.myMap["city"],
      'age': MyProfileUI.myMap["age"],
      'phoneNumber': MyProfileUI.myMap["phone"],
      'email': MyProfileUI.myMap["email"],
      'position': MyProfileUI.myMap["position"]
    });
  }
}
