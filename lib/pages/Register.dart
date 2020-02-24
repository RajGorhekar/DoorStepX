import 'package:Doorstepx/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
final usersRef = Firestore.instance.collection('users');
String s = 'Register';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
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
                Positioned(
                  height: 300,
                  width: width + 20,
                  child: FadeAnimation(
                      1.3,
                      GestureDetector(
                        onTap: () => FocusScope.of(context)
                            .requestFocus(new FocusNode()),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/background-2.png'),
                                  fit: BoxFit.fill)),
                        ),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40, top: 100, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeAnimation(
                          1.5,
                          Text(
                            "Register",
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
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Location",
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
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Category",
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Address",
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
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
                            onTap: () => register(context),
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
                            onTap: () => Navigator.pop(context),
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
    if (passwordController.text.isEmpty || emailController.text.isEmpty) {
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
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(), password: passwordController.text);
        createUserInFireStore(user);
        passwordController.clear();
        emailController.clear();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
        setState(() {
          s = 'Register';
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void createUserInFireStore(FirebaseUser user) async {
    await usersRef.document(user.uid).setData({
        "id": user.uid,
        "password": passwordController.text,
        "email": emailController.text,
      });
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
