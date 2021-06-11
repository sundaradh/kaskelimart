import 'dart:async';

import 'package:flutter/material.dart';

import 'package:kaskelimart/signup.dart';

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
    Timer(Duration(seconds: 4), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Signup()));
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
            Text(
              "Kaskeli Mart",
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
