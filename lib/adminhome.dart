import 'package:flutter/material.dart';
import 'package:kaskelimart/producteditandelete.dart';
import 'package:kaskelimart/productenter.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Productenter()));
              },
              child: Text('Enter Product'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Productedit()));
              },
              child: Text('Edit Product'),
            ),
          ],
        ),
      ),
    );
  }
}
