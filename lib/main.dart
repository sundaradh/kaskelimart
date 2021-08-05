import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kaskelimart/home.dart';
import 'package:kaskelimart/login.dart';

import 'package:shared_preferences/shared_preferences.dart';

String? finalEmail;
void main() {
  runApp(MaterialApp(
    title: "Kaskeli Mart",
    home: Splash(),
    debugShowCheckedModeBanner: false,
  ));
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  @override
  void initState() {
    super.initState();
    getloginvalidatordata().whenComplete(() async {
      Timer(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => finalEmail != null ? Home() : Login()));
      });
    });
  }

  Future getloginvalidatordata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString("email");
    setState(() {
      finalEmail = obtainedEmail;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250.0,
              height: 250.0,
              margin: EdgeInsets.only(top: 30.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("images/logo.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
