import 'package:flutter/material.dart';
import 'package:advanced_basic_money_tracker_2/_csvStuff.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    startupCheck(context).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Placeholder()),
      );
    });
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      )
    )
  }
}
