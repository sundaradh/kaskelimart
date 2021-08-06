import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:kaskelimart/adminhome.dart';
import 'package:kaskelimart/login.dart';

class Loginadmin extends StatefulWidget {
  const Loginadmin({Key? key}) : super(key: key);

  @override
  _LoginadminState createState() => _LoginadminState();
}

class _LoginadminState extends State<Loginadmin> {
  String message = "";
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text("Login"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Image.asset(
                      "images/logo.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Colors.red,
                        ),
                        hintText: 'Email',
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your Email ";
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Prease Enter Valid Emailadmin";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (String? email) {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _password,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: Colors.green,
                        ),
                        hintText: 'Password',
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please Enter a Password";
                        }
                        if (value.length < 5) {
                          return "Password Length must be more than 5";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(
                    child: RaisedButton(
                      color: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      onPressed: () {
                        if (_fromKey.currentState!.validate()) {
                          login();
                          print("Sucessful");
                        } else {
                          print("Unsucessful");
                        }
                        Future.delayed(const Duration(seconds: 5), () {
                          //asynchronous delay
                          if (this.mounted) {
                            //checks if widget is still active and not disposed
                            setState(() {
                              //tells the widget builder to rebuild again because ui has updated
                              message =
                                  ""; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
                            });
                          }
                        });
                      },
                      child: Text("Login"),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do you havenot an Admin  account?"),
                      GestureDetector(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future login() async {
    var apiurl = "https://kaskelimart.company/api/adminlogin.php";
    Map mapdata = {
      'email': _email.text,
      'password': _password.text,
    };
    print("JSON DATA: $mapdata");
    http.Response response = await http.post(Uri.parse(apiurl), body: mapdata);

    if (response.body.isNotEmpty) {
      var data = jsonDecode(response.body);
      print("DATA:$data");
      if (data.length == 1) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AdminHome()));
      } else {
        setState(() {
          message = "Invalid email or password";
        });
      }
    }
  }
}
