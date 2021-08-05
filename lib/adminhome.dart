import 'package:flutter/material.dart';
import 'package:kaskelimart/home.dart';
import 'package:kaskelimart/producteditandelete.dart';
import 'package:kaskelimart/productenter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

var a, b;

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
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ViewAllOrder()));
              },
              child: Text('View Order'),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewAllOrder extends StatefulWidget {
  const ViewAllOrder({Key? key}) : super(key: key);

  @override
  _ViewAllOrderState createState() => _ViewAllOrderState();
}

class _ViewAllOrderState extends State<ViewAllOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View All Order"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: orderview(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 280,
                      crossAxisSpacing: 0.7,
                      mainAxisSpacing: 10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      child: Container(
                        child: Card(
                          // color: Colors.red,
                          child: Column(
                            children: [
                              Image(
                                height: 60.0,
                                width: 80.00,
                                image: NetworkImage(
                                    "https://kaskelimart.company/api/image/" +
                                        snapshot.data[index]['image_name']),
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(snapshot.data[index]['Pro_name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      overflow: TextOverflow.fade),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Rs:" + snapshot.data[index]['price'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "count:" +
                                            snapshot.data[index]['count'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                "Status:" + snapshot.data[index]['Status'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "Address:" + snapshot.data[index]['Address'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "Phone_Number:" +
                                    snapshot.data[index]['Phone_Number'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(
                                "email:" + snapshot.data[index]['email'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              // Text(
                              //   "Category:" + snapshot.data[index]['Category'],
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.bold, fontSize: 15),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

Future<List> orderview() async {
  var response = await http
      .get(Uri.parse('https://kaskelimart.company/api/orderview.php'));
  var data = jsonDecode(response.body);
  print(data);
  return data;
}
