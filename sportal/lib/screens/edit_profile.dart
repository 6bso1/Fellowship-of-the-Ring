import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'my_profile.dart';
import 'my_profile.dart';
import 'dart:io';
import 'dart:async';
import 'HomePage_s.dart';

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


  File _image = File('your initial file');
  String? firstName = MyProfileUI.myMap["firstName"];
  String? secondName = MyProfileUI.myMap["secondName"];
  String? age = MyProfileUI.myMap["age"];
  String? mail = MyProfileUI.myMap["email"];
  String? imageURL = MyProfileUI.myMap["image"];
  String? uid = MyProfileUI.myMap["uid"];

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image!.path);
        print('Image Path $_image');
      });
    }
    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      Reference reference = FirebaseStorage.instance.ref().child("images").child(
          new DateTime.now().millisecondsSinceEpoch.toString() +
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
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }
    return Scaffold(
      appBar: buildHeader(context),
      extendBodyBehindAppBar:
      true,

      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)
        ),
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Profili Düzenle",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,color: Colors.white ),
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
                          child: new SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: (_image!=null)?Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ):Image.network(
                              "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              fit: BoxFit.fill,
                            ),
                          ),
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
                            onPressed: (){
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
              buildTextField(1, "Ad", false),
              buildTextField(2, "Soyad", false),
              buildTextField(3, "E-mail", false),
              buildTextField(4, "Şifre", true),
              buildTextField(5, "Pendik", false),
              buildTextField(6, "İstanbul", false),
              buildTextField(7, "Telefon", false),
              buildTextField(8, "Yaş", false),
              buildTextField(9, "Mevki", false),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {

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

  Widget buildTextField(
      int labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        obscureText: isPasswordTextField ? showPassword : false,
        onChanged: (text) {
          print('First text field: $text');
        },
        decoration: InputDecoration(
            prefixIcon: labelText==1 ? Icon(Icons.account_circle,color: Colors.white): labelText==2 ? Icon(Icons.account_circle,color: Colors.white):
            labelText==3 ? Icon(Icons.mail,color: Colors.white):labelText==4 ? Icon(Icons.lock,color: Colors.white):
            labelText==5 ? Icon(Icons.location_on,color: Colors.white): labelText==6 ? Icon(Icons.location_on,color: Colors.white):
            labelText==7 ? Icon(Icons.phone,color: Colors.white): labelText==8 ? Icon(Icons.calendar_today,color: Colors.white):
            labelText==9 ? Icon(Icons.sports_football,color: Colors.white):null,

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
              color: Colors.white,
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyProfileUI()));
          },
        ),

        backgroundColor: Colors.transparent, //AppBar'ı tramsparan yapıyor
        automaticallyImplyLeading: false);
  }
}