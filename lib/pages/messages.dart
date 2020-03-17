import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

  
 
class MessageScreen extends StatefulWidget {
  MessageScreen({Key key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('Messages'),
    );
  }
}