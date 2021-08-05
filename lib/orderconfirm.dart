import 'package:flutter/material.dart';
import 'package:kaskelimart/bill.dart';
import 'package:kaskelimart/home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaskelimart/login.dart';

TextEditingController _phone = TextEditingController();
TextEditingController _Address = TextEditingController();
TextEditingController _email = TextEditingController(text: finalEmail);
TextEditingController _payment =
    TextEditingController(text: "Cash on  delivary");

class Orderconfirm extends StatefulWidget {
  const Orderconfirm({Key? key}) : super(key: key);

  @override
  _OrderconfirmState createState() => _OrderconfirmState();
}

class _OrderconfirmState extends State<Orderconfirm> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order confirmation"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    hintText: 'Enter',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                  onSaved: (String? phone) {},
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    hintText: 'Enter your phone no',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your phone no ";
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Prease Enter Valid  Phone";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String? phone) {},
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _Address,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.house,
                      color: Colors.black,
                    ),
                    hintText: 'Enter your Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Address ";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String? phone) {},
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _payment,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.money,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                  ),
                  validator: (String? value) {},
                  onSaved: (String? phone) {},
                ),
              ),
              SizedBox(
                  height: 100,
                  child: Center(
                    child: RaisedButton(
                      color: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      onPressed: () {
                        orderconfirm();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Bill()));
                      },
                      child: Text(
                        "Order confirm",
                        style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 2.2,
                            color: Colors.black),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Future orderconfirm() async {
  var apiurl = "https://kaskelimart.company/api/buy.php";
  Map mapdata = {
    'email': finalEmail,
    'Pro_id': a[b]['id'],
    'Address': _Address.text,
    'Phone_Number': _phone.text,
  };
  print("JSON DATA: $mapdata");
  http.Response response = await http.post(Uri.parse(apiurl), body: mapdata);

  if (response.body.isNotEmpty) {
    var data = jsonDecode(response.body)['message'];
    print(data);
  }
}
