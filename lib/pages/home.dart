import 'dart:io';
import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:Doorstepx/models/user.dart';
import 'package:Doorstepx/pages/discover.dart';
import 'package:Doorstepx/pages/Login.dart';
import 'package:Doorstepx/pages/messages.dart';
import 'package:Doorstepx/pages/welcome.dart';
import 'package:Doorstepx/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// final StorageReference storageRef = FirebaseStorage.instance.ref();
// final usersRef = Firestore.instance.collection('users');

User currentUser;  

class Home extends StatefulWidget {
  final FirebaseUser user;
  const Home({Key key, this.user}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    getBoolValuesSF();
    build(context);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPagechanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          WelcomeScreen(user: widget.user,),
          Discover(),
          MessageScreen(),
          Profile(),
          // Profile(profileId: currentUser?.id),
        ],
        controller: pageController,
        onPageChanged: onPagechanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), title: Text('Discover')),
          BottomNavigationBarItem(
              icon: Icon(Icons.message), title: Text('Messages')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text('Profile')),
        ],
      ),
    );
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Login(),
    );
  }

  void getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('boolValue') == null) {
      setState(() {
        isAuth = false;
      });
    } else {
      setState(() {
        isAuth = prefs.getBool('boolValue');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
