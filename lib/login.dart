import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:kaskelimart/home.dart';
import 'package:kaskelimart/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String message = "";
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Login",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _fromKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Image(
                      image: AssetImage("images/login.jpg"),
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
                          color: Colors.yellow,
                        ),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your Email ";
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Prease Enter Valid Email or Phone";
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
                          color: Colors.red,
                        ),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
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
                    height: 40,
                    width: 150,
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
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      borderSide: BorderSide(color: Colors.black),
                      child: Text("Sign Up"),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Forget Password?"),
                      GestureDetector(
                        child: Text(
                          'Click here',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Signup()));
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
    var apiurl = "https://kaskelimart.company/api/login.php";
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
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("email", _email.text);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      } else {
        setState(() {
          message = "Invalid email or password";
        });
      }
    }
  }
}
