import 'package:flutter/material.dart';
import 'player_search_buildBody.dart';
import 'player_profile.dart';
import 'my_profile.dart';

//import 'package:settings_ui/pages/settings.dart';

class SettingsUI extends StatelessWidget {
  int index;
  SettingsUI(int this.index)
  {
    this.index=index;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(index),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  int index;
  EditProfilePage(int this.index)
  {
    this.index=index;
  }
  @override
  _EditProfilePageState createState() => _EditProfilePageState(index);
}

class _EditProfilePageState extends State<EditProfilePage> {
  int index;
  _EditProfilePageState(int this.index)
  {
    this.index=index;
  }
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildHeader(context, index),
      extendBodyBehindAppBar:
                            true,

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://github.com/okantorun/Vector-Graphics-Libraray-C/blob/main/JPGs/background%20(1).png?raw=true"),
            fit: BoxFit.cover,
          ),
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
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                PlayerSearchBuildBody.players[index].imageAddress,
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
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
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
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
                    onPressed: () {},
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
                    onPressed: () {},
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
  AppBar buildHeader(BuildContext context,int index) {
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
                        MyProfileUI(index)));
          },
        ),
        /*title: Center(
            child: Image.asset('assets/images/Header-Takim-Bul.png',
                height: AppBar()
                    .preferredSize
                    .height)),*///image'i app bar'ın yüksekliğine görse resize ediyor
        backgroundColor: Colors.transparent, //AppBar'ı tramsparan yapıyor
        automaticallyImplyLeading: false);
  }
}