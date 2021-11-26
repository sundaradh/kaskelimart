import 'package:flutter/material.dart';
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
                      onTap: () {
                        b = index;
                        a = snapshot.data;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Orderdetail()));
                      },
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
                                    children: [],
                                  ),
                                ],
                              ),
                              Text(
                                "Status:" + snapshot.data[index]['Status'],
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

class Orderdetail extends StatefulWidget {
  const Orderdetail({Key? key}) : super(key: key);

  @override
  _OrderdetailState createState() => _OrderdetailState();
}

class _OrderdetailState extends State<Orderdetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Orderupdate()));
          },
          tooltip: 'Pick Image',
          child: Icon(Icons.edit),
        ),
        appBar: AppBar(
          title: Text('Order details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Image(
                        height: MediaQuery.of(context).size.width / 1.25,
                        width: MediaQuery.of(context).size.width,
                        image: NetworkImage(
                            "https://kaskelimart.company/api/image/" +
                                a[b]['image_name']),
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Rs:" + a[b]['price'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  a[b]['Pro_name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  "email:" + a[b]['email'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  "status:" + a[b]['Status'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  "phone no:" + a[b]['Phone_Number'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  "Adress:" + a[b]['Address'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  "\nFeatures:\n" + a[b]['description'],
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ));
  }
}

class Orderupdate extends StatefulWidget {
  const Orderupdate({Key? key}) : super(key: key);

  @override
  _OrderupdateState createState() => _OrderupdateState();
}

class _OrderupdateState extends State<Orderupdate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "status:" + a[b]['Status'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
    );
  }
}
