import 'dart:async';
import 'package:Doorstepx/pages/Register.dart'; 
import 'package:Doorstepx/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey1,
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 300,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -40,
                      height: 300,
                      width: width,
                      child: FadeAnimation(
                          01,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/background.png'),
                                    fit: BoxFit.fill)),
                          )),
                    ),
                    FadeAnimation(
                      1,
                      Column(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(50, 20, 50, 2),
                            child: Image.asset(
                              './assets/images/icon.png',
                              height: 50,
                              width: 50,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Get All Services\nAt Your DoorStep                                                                      ",
                            style: TextStyle(
                              color: Colors.deepPurple[900],
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        
                      ]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1.5,
                        Text(
                          "Login",
                          style: TextStyle(
                              color: Color.fromRGBO(49, 39, 79, 1),
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
                                  blurRadius: 20,
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
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email ID",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: passwordController,
                                  autofocus: false,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey)),
                                ),
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        1.7,
                        GestureDetector(
                          onTap: () => resetPassword(emailController.text),
                          child: Center(
                              child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Color.fromRGBO(196, 135, 198, 1)),
                          )),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        1.9,
                        GestureDetector(
                          onTap: () => login(context),
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromRGBO(49, 39, 79, 1),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
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
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register())),
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, .6)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
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


void login(context) async {
  if (passwordController.text.isEmpty || emailController.text.isEmpty) {
    _scaffoldKey1.currentState.showSnackBar(SnackBar(
      content: Text('Fields Cannot be Empty'),
      duration: Duration(seconds: 2),
      backgroundColor: Color.fromRGBO(49, 39, 79, 1),
    ));
  } else {
    try {
      FirebaseUser user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('boolValue', true);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(user: user,)));
    } catch (e) {
      print(e);
    }
  }
}

@override
Future<void> resetPassword(String email) async {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  await _firebaseAuth.sendPasswordResetEmail(email: email);
}
