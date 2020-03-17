import 'package:Doorstepx/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  @override
  void initState(){
    super.initState();
  }


  logout() async {
    await auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', false);
  }

  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
      onTap: logout,
      child: Center(
        child: Text('Logout'),
      ),
    ));
  }
}
