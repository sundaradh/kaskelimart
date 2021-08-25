import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kaskelimart/main.dart';

var a, b;

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: favurite(),
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
                                builder: (context) => Favorite()));
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

Future favurite() async {
  var apiurl = "https://kaskelimart.company/api/favview.php";
  Map mapdata = {
    'email': finalEmail,
  };
  print("JSON DATA: $mapdata");
  http.Response response = await http.post(Uri.parse(apiurl), body: mapdata);
  var data = jsonDecode(response.body);
  print(data);
  return data;
}
