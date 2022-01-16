import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HomePage_s.dart';
import 'ResetPassword_s.dart';
import 'Signup_s.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({Key? key}) : super(key: key);

  @override
  _Login_screenState createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (value!.isEmpty) {
            return ("Email adresi giriniz");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Geçerli bir email adresi giriniz");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail, color: Colors.white24),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.white24),
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
        controller: passwordController,
        obscureText: true,
        style: TextStyle(color: Colors.white),
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Giriş yapmak için şifre gerekli");
          }
          if (!regex.hasMatch(value)) {
            return ("Geçerli bir şifre giriniz. (En az 6 karakter)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key, color: Colors.white24),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Şifre",
          hintStyle: TextStyle(fontSize: 20.0, color: Colors.white24),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white24, width: 2),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(7),
      color: Color(0xFFCC3DE7),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Giriş Yap",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Colors.white60),
          )),
    );

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(7),
      color: Color(0x5FCC3DE7),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Sign_up()));
          },
          child: Text(
            "Yeni Hesap Oluştur",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Colors.white60),
          )),
    );
    return MaterialApp(
        title: "welcome",
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                            height: 200,
                            child: Image.asset(
                              "assets/logobar.png",
                              fit: BoxFit.contain,
                            )),
                        SizedBox(height: 25),
                        Column(
                          children: [
                            emailField,
                            passwordField,
                            SizedBox(height: 25),
                            loginButton,
                            SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Reset_screen()));
                              },
                              child: Text(
                                "Şifreni mi Unuttun?",
                                style: TextStyle(
                                    color: Colors.white60, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        SizedBox(height: 15),
                        signUpButton,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Giriş Başarılı"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Mail adresiniz geçerli değil";
            break;
          case "wrong-password":
            errorMessage = "Şifreniz yanlış";
            break;
          case "user-not-found":
            errorMessage = "Bu mail adresiyle kullanıcı bulunamadı";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
