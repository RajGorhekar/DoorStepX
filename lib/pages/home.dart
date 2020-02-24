import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:Doorstepx/models/user.dart';
import 'package:Doorstepx/pages/discover.dart';
import 'package:Doorstepx/pages/Login.dart';
import 'package:Doorstepx/pages/messages.dart';
import 'package:Doorstepx/pages/welcome.dart';
import 'package:Doorstepx/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
// final GoogleSignIn googleSignIn = GoogleSignIn();
// final StorageReference storageRef = FirebaseStorage.instance.ref();
// final usersRef = Firestore.instance.collection('users');

User currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool isAuth = true;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
    // googleSignIn.onCurrentUserChanged.listen((account) {
    //   handleSignIn(account);
    // }, onError: (err) {
    //   print("error signing in : $err");
    // });
    // googleSignIn.signInSilently(suppressErrors: false).then((account) {
    //   handleSignIn(account);
    // }).catchError((err) {
    //   print("error signing in : $err");
    // });
  }

  // handleSignIn(GoogleSignInAccount account) async {
  //   if (account != null) {
  //     await createUserInFirestore();
  //     setState(() {
  //       isAuth = true;
  //     });
  //     configurePushNotification();
  //   } else {
  //     setState(() {
  //       isAuth = false;
  //     });
  //   }
  // }


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
      key: _scaffoldKey,
      body: PageView(
        children: <Widget>[
          WelcomeScreen(),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text('Discover')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Messages')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title: Text('Profile')
          ),
        ],
      ),
    );
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Login(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}