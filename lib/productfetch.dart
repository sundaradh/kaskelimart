import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kaskelimart/login.dart';
import 'package:http/http.dart' as http;

class Productfetch extends StatefulWidget {
  const Productfetch({Key? key}) : super(key: key);

  @override
  _ProductfetchState createState() => _ProductfetchState();
}

class _ProductfetchState extends State<Productfetch> {
  Widget product() {
    return Padding(
      padding: EdgeInsets.all(40),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        child: Card(
          // color: Colors.red,
          child: Column(
            children: [
              Image(
                  image: NetworkImage(
                      'https://static.remove.bg/remove-bg-web/2e3a8aa57bcd08605c78f95f1c4bd007b07a5100/assets/start_remove-79a4598a05a77ca999df1dcb434160994b6fde2c3e9101984fb1be0f16d0a74e.png')),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    data['name'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(
                    'price',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  var data;
  Future<List>? productlist;
  Future<List> getProduct() async {
    var response = await http
        .get(Uri.parse('https://kaskelimart.company/api/product.php'));
    data = jsonDecode(response.body);
    return data;
  }

  @override
  void initState() {
    productlist = getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return product();
  }
}
