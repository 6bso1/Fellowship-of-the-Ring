import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sportal/bars/buildAppBar.dart';
import 'package:sportal/model/user_model.dart';

import 'Background.dart';
import 'Login_s.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  Sign_upState createState() => Sign_upState();
}

class Sign_upState extends State<Sign_up> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        style: TextStyle(color: Colors.white),
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
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle, color: Colors.white70),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "İsim",
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
        ));

    //second name field
    final secondNameField = TextFormField(
        autofocus: false,
        controller: secondNameEditingController,
        keyboardType: TextInputType.name,
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (value!.isEmpty) {
            return ("Soyisim boş bırakılamaz");
          }
          return null;
        },
        onSaved: (value) {
          secondNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle, color: Colors.white70),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Soyisim",
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (value!.isEmpty) {
            return ("Email adresi girin");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Lütfen geçerli bir email girin");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail, color: Colors.white70),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        style: TextStyle(color: Colors.white),
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Şifre boş bırakılamaz");
          }
          if (!regex.hasMatch(value)) {
            return ("Geçerli bir şifre giriniz (En az 6 karakter");
          }
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key, color: Colors.white70),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Şifre",
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Şifreler aynı değil";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key, color: Colors.white70),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Şifre tekrar",
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(7),
      color: Color(0xFFCC3DE7),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(firstNameEditingController.text, emailEditingController.text,
                passwordEditingController.text);
          },
          child: Text(
            "Kaydol",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white70),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: buildAppBar(),
      extendBodyBehindAppBar:
          true, //Body'i appbar kısmına çekiyor (Arka planı uzatmak için)
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 65),
                      Text('Hesabını Oluştur',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 30),
                      firstNameField,
                      secondNameField,
                      emailField,
                      passwordField,
                      confirmPasswordField,
                      SizedBox(height: 20),
                      Text(
                          'Kaydolduğunda Hizmet Şartları’nı ve Çerez Kullanımı dahil olmak üzere Gizlilik Politikası’nı kabul etmiş olursun. Gizlilik Seçeneklerini buna göre belirlediğinde başkaları seni e-postan veya telefon numaranla bulabilir.',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white70,
                          )),
                      SizedBox(height: 20),
                      signUpButton,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signUp(String name, String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Email adresiniz geçerli değil.";
            break;
          case "wrong-password":
            errorMessage = "Şifreniz hatalı.";
            break;
          case "user-not-found":
            errorMessage = "Böyle bir kullanıcı yok.";
            break;
          case "user-disabled":
            errorMessage = "Bu hesap kaldırıldı.";
            break;
          case "too-many-requests":
            errorMessage = "Çok fazla istek";
            break;
          case "operation-not-allowed":
            errorMessage = "Görev başarısız.";
            break;
          default:
            errorMessage = "Bilinmeyen bir hata meydana geldi.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Hesap başarıyla oluşturuldu :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => Login_screen()),
        (route) => false);
  }
}
