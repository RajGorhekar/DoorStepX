import 'dart:io';
import 'dart:async';

import 'package:Doorstepx/pages/home.dart';
import 'package:Doorstepx/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController locationController = TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
final usersRef = Firestore.instance.collection('users');
String s = 'Register';
String cat = '';
String completeAddress;
String mediaUrl = '';
File file;
File _image;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // handleTakePhoto() async {
  //   Navigator.pop(context);
  //   File f1 = await ImagePicker.pickImage(
  //     source: ImageSource.camera,
  //     maxHeight: 675,
  //     maxWidth: 960,
  //   );
  //   setState(() {
  //     file = f1;
  //   });
  // }

  // handleChooseFromGallery() async {
  //   Navigator.pop(context);
  //   File f1 = await ImagePicker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   setState(() {
  //     file = f1;
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        print('Image path $_image');
      });
    }

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -40,
                  height: 300,
                  width: width,
                  child: FadeAnimation(
                      1,
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/background.png'),
                                fit: BoxFit.fill)),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40, top: 50, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text(
                            "Services At Your DoorStep",
                            style: TextStyle(
                                color: Colors.deepPurple[900], fontSize: 25),
                          )),
                      SizedBox(height: 10),
                      FadeAnimation(
                          1.5,
                          Text(
                            "Register Now !",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          1.7,
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(196, 135, 198, .7),
                                    blurRadius: 17,
                                    offset: Offset(0, 10),
                                  )
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Your Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email ID",
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextField(
                                    controller: locationController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Location",
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => getUserLocation(),
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.blue,
                                            size: 30,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              'Use Current Location',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //selectImage(context);
                                    getImage();
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              _image == null
                                                  ? Icon(
                                                      Icons.image,
                                                      color: Colors.blue,
                                                      size: 30,
                                                    )
                                                  : Image.file(
                                                      _image,
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  'Select Image To Upload',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    createAlert(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Text(
                                            '* Select category',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Icon(
                                          cat == ''
                                              ? null
                                              : Icons.verified_user,
                                          color: Colors.green,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          1.9,
                          GestureDetector(
                            onTap: () {
                              register(context);
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromRGBO(49, 39, 79, 1),
                              ),
                              child: Center(
                                child: Text(
                                  s,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login())),
                            child: Center(
                                child: Text(
                              "Already Have an Account ?",
                              style: TextStyle(
                                  color: Color.fromRGBO(49, 39, 79, .6)),
                            )),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void register(context) async {
    if (passwordController.text.isEmpty || emailController.text.isEmpty||nameController.text.isEmpty||locationController.text.isEmpty||cat==''||_image==null){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Fields Cannot be Empty'),
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
      ));
    } else {
      setState(() {
        s = 'Loading Content ...';
      });
      try {
        StorageReference firebaseStorageRef =
            FirebaseStorage.instance.ref().child(emailController.text +  '-profilepic');
        StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        print(downloadUrl);
        setState(() {
          mediaUrl = downloadUrl;
          print("Profile Picture uploaded");
          print(mediaUrl);
        });
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: emailController.text.trim(),password: passwordController.text);
        createUserInFireStore(user);
        print('user created');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('boolValue', true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home(user: user,)));
        setState(() {
          s = 'Register';
          _image = null;
          mediaUrl = '';
        });
        passwordController.clear();
        emailController.clear();
        cat = '';
      } catch (e) {
        print(e);
      }
    }
  }


  void createUserInFireStore(FirebaseUser user) async {
    await usersRef.document(user.uid).setData({
      "id": user.uid,
      "email": emailController.text,
      "password": passwordController.text,
      "name": nameController.text,
      "location": locationController.text,
      "category": cat,
      "imageUrl": mediaUrl,
      "completeAddress": completeAddress,
    });
  }

  void createAlert(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('What is Your Profession ?',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        cat = "Doctor";
                        s = 'Register as ' + cat;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('Doctor',
                            style: TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 18))),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        cat = 'Electrician';
                        s = 'Register as ' + cat;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('Electrician',
                            style: TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 18))),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        cat = 'Mover';
                        s = 'Register as ' + cat;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('Movers and Packers',
                            style: TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 18))),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        cat = 'Plumber';
                        s = 'Register as ' + cat;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('Plumber',
                            style: TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 18))),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        cat = 'Maintainer';
                        s = 'Register as ' + cat;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('House Maintainance',
                            style: TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 18))),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        cat = 'Other';
                        s = 'Register as ' + cat;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('Other',
                            style: TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 18))),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Register as a Normal User',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                onPressed: () {
                  setState(() {
                    cat = 'User';
                    s = 'Register Now !';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  // selectImage(context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SimpleDialog(
  //           title: Text('Select Profile Picture'),
  //           children: <Widget>[
  //             SimpleDialogOption(
  //                 child: Text("Photo with Camera"), onPressed: handleTakePhoto),
  //             SimpleDialogOption(
  //                 child: Text("Image from Gallery"),
  //                 onPressed: handleChooseFromGallery),
  //             SimpleDialogOption(
  //               child: Text("Cancel"),
  //               onPressed: () => Navigator.pop(context),
  //             )
  //           ],
  //         );
  //       });
  // }


  getUserLocation() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    completeAddress =
        '${placemark.subThoroughfare} ,${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
    print(completeAddress);
    String formattedAddress = "${placemark.locality}, ${placemark.country}";
    locationController.text = formattedAddress;
  }
}

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}
