import 'dart:async';
import 'package:flutter/material.dart';
import 'package:messenger_clone/Screens/signIn.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3), (){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SignIn()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset('assets/madhu.jpeg',fit: BoxFit.cover),
        ),
      ),
    );
  }
}
