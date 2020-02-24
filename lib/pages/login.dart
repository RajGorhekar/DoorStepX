import 'package:Doorstepx/pages/Register.dart';
import 'package:Doorstepx/pages/home.dart';
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
                          1,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/background.png'),
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
                    )
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
                        Center(
                            child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Color.fromRGBO(196, 135, 198, 1)),
                        ))),
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
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register())),
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, .6)),
                          ),
                        ))),
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } catch (e) {
      print(e);
    }
  }
}
