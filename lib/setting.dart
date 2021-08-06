import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaskelimart/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "ACCOUNT",
                  style: TextStyle(fontSize: 22),
                )
              ],
            ),
            Divider(
              height: 20,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountoption(context, "Change password"),
            buildAccountoption(context, "Privacy and security"),
            SizedBox(height: 40),
            SizedBox(height: 20),
            buildNotificationOption(
                "Theme Dark", valNotify1, onChangeFunction1),
            buildNotificationOption(
                "Account Active", valNotify2, onChangeFunction2),
            SizedBox(height: 150),
            Center(
              child: RaisedButton(
                color: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))),
                onPressed: () async {
                  final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove('email');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 16, letterSpacing: 2.2, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding buildNotificationOption(
      String title, bool value, Function onchangeMethod) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600])),
            Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                activeColor: Colors.blue,
                trackColor: Colors.grey,
                value: value,
                onChanged: (bool newValue) {
                  onchangeMethod(newValue);
                },
              ),
            )
          ],
        ));
  }

  GestureDetector buildAccountoption(BuildContext context, title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("DONE"), Text("BACK")],
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            Icon(Icons.arrow_forward_ios, color: Colors.black)
          ],
        ),
      ),
    );
  }
}
