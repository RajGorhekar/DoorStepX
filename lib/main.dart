import 'package:flutter/material.dart';
import 'package:Doorstepx/pages/home.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      title: 'FlutterFeed',
      debugShowCheckedModeBanner: true,
      home: Home(),
    );
  }
}