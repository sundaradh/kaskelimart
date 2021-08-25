import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kaskelimart/favorite.dart';
import 'package:kaskelimart/login.dart';
import 'package:http/http.dart' as http;
import 'package:kaskelimart/myorder.dart';
import 'package:kaskelimart/orderconfirm.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:kaskelimart/setting.dart';

List a = [];
int b = 0;
String? finalEmail, message;
int currentindex = 0;
var name = "Home";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getloginvalidatordata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString("email");
    setState(() {
      finalEmail = obtainedEmail;
    });
  }

  Widget product() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: FutureBuilder(
          future: getProduct(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return createGridView(snapshot.data, context);
            }
            return CircularProgressIndicator();
          }),
    );
  }

  Future<List> getProduct() async {
    var response = await http
        .get(Uri.parse('https://kaskelimart.company/api/product.php'));
    var data = jsonDecode(response.body);
    print(data);
    return data;
  }

  @override
  void initState() {
    getProduct();
    getloginvalidatordata();
    super.initState();
  }

  Widget category(Icon icon, String name) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Login()));
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.lightBlueAccent,
                    blurRadius: 5.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                  )
                ],
              ),
              height: 80,
              width: 80,
              child: Card(
                child: Center(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          icon,
                          SizedBox(
                            height: 10,
                          ),
                          Text(name)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getProduct();
    });
    final screen = [
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Form(
              child: Container(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      contentPadding: new EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 5.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   'Category',
            //   style: TextStyle(fontSize: 25.0),
            // ),
            // Container(
            //   height: 140,
            //   child: Container(
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: [
            //           // category(Icon(Icons.food_bank), 'food'),
            //           // category(Icon(Icons.computer), 'Computer'),
            //           // category(Icon(Icons.phone), 'Mobile'),
            //           // category(Icon(Icons.food_bank), 'food'),
            //           // category(Icon(Icons.computer), 'Computer'),
            //           // category(Icon(Icons.phone), 'Mobile'),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            product(),
          ],
        ),
      ),
      Favorite(),
      MyOrder(),
      Setting()
    ];
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80))),
            centerTitle: true,
            backgroundColor: Colors.green,
            title: Text(name),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    viewcart();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart()));
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 20,
                  ))
            ],
          ),
        ),
        drawer: Maindrawer(),
        body: screen[currentindex],
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 20.0,
          currentIndex: currentindex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'favorite',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.badge),
              label: 'my order',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.green,
            ),
          ],
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            setState(() {
              currentindex = index;
              if (index == 0) {
                name = "Home";
              } else if (index == 1) {
                name = "Favorite";
              } else if (index == 2) {
                name = "My Order";
              } else if (index == 3) {
                name = "Setting";
              }
            });
          },
        ),
      ),
    );
  }

  Widget createGridView(List data, BuildContext context) {
    return SingleChildScrollView(
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 280,
              crossAxisSpacing: 0.7,
              mainAxisSpacing: 10),
          itemCount: data.length,
          itemBuilder: (BuildContext context, index) {
            return InkWell(
              onTap: () {
                a = data;
                b = index;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Productview(data, context)));
              },
              child: Container(
                child: Card(
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Image(
                        height: 100.0,
                        width: 100.00,
                        image: NetworkImage(
                            "https://kaskelimart.company/api/image/" +
                                data[index]['image_name']),
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(data[index]['Pro_name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              overflow: TextOverflow.ellipsis),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Rs:" + data[index]['price'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              IconButton(
                                  onPressed: () {
                                    a = data;
                                    b = index;
                                    addcart();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'This Product added to your cart')));
                                  },
                                  icon: Icon(Icons.add_shopping_cart)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future addcart() async {
    var apiurl = "https://kaskelimart.company/api/addcart.php";
    Map mapdata = {
      'email': finalEmail,
      'Pro_id': a[b]['id'],
    };
    print("JSON DATA: $mapdata");
    http.Response response = await http.post(Uri.parse(apiurl), body: mapdata);

    if (response.body.isNotEmpty) {
      var data = jsonDecode(response.body)['message'];

      setState(() {
        message = data;
        print(message);
      });
    }
  }
}

class Maindrawer extends StatefulWidget {
  Maindrawer({Key? key}) : super(key: key);

  @override
  _MaindrawerState createState() => _MaindrawerState();
}

class _MaindrawerState extends State<Maindrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // header
          UserAccountsDrawerHeader(
            accountName: Text('$finalEmail'),
            accountEmail: Text('$finalEmail'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.green),
          ),

          // body

          Divider(),

          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("My account"),
              leading: Icon(
                Icons.person,
                color: Colors.red,
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("My order"),
              leading: Icon(
                Icons.shopping_basket,
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("categories"),
              leading: Icon(
                Icons.dashboard,
                color: Colors.orange,
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("favourites"),
              leading: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Setting()));
            },
            child: ListTile(
              title: Text("Setting"),
              leading: Icon(
                Icons.settings,
                color: Colors.deepOrange,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("about"),
              leading: Icon(
                Icons.help,
                color: Colors.pink,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove('email');
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: ListTile(
              title: Text("Logout"),
              leading: Icon(
                Icons.logout,
                color: Colors.deepOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Productview extends StatefulWidget {
  Productview(List data, BuildContext context);

  @override
  _ProductviewState createState() => _ProductviewState();
}

class _ProductviewState extends State<Productview> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.green,
            title: Text('product'),
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
                        IconButton(
                            color: Colors.red,
                            onPressed: () {
                              favurite();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'this product is added to your favurite')));
                            },
                            icon: Icon(Icons.favorite)),
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
                    "\nFeatures:\n" + a[b]['description'],
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.fade,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlineButton(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          onPressed: () {
                            addcart();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'This Product added to your cart')));
                          },
                          borderSide: BorderSide(color: Colors.black),
                          child: Text("Add cart"),
                        ),
                        RaisedButton(
                          color: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Orderconfirm()));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Confirm Your Order')));
                          },
                          child: Text("Buy Now"),
                        )
                      ])
                ],
              ),
            ),
          )),
    );
  }

  Future addcart() async {
    var apiurl = "https://kaskelimart.company/api/addcart.php";
    Map mapdata = {
      'email': finalEmail,
      'Pro_id': a[b]['id'],
    };

    print("JSON DATA: $mapdata");
    http.Response response = await http.post(Uri.parse(apiurl), body: mapdata);

    if (response.body.isNotEmpty) {
      var data = jsonDecode(response.body)['message'];

      setState(() {
        message = data;
        print(message);
      });
    }
  }
}

Future favurite() async {
  var apiurl = "https://kaskelimart.company/api/addfav.php";
  Map mapdata = {
    'email': finalEmail,
    'Pro_id': a[b]['id'],
  };

  print("JSON DATA: $mapdata");
  http.Response response = await http.post(Uri.parse(apiurl), body: mapdata);

  if (response.body.isNotEmpty) {
    var data = jsonDecode(response.body)['message'];

    message = data;
    print(message);
  }
}

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      viewcart();
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: viewcart(),
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
                          a = snapshot.data;
                          b = index;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Productview(snapshot.data, context)));
                        },
                        child: Container(
                          child: Card(
                            // color: Colors.red,
                            child: Column(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.select_all_outlined)),
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
                                      ],
                                    ),
                                  ],
                                )
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
        ));
  }
}

Future<List> viewcart() async {
  var apiurl = "https://kaskelimart.company/api/cartview.php";
  Map mapdata = {
    'email': finalEmail,
    'Pro_id': a[b]['id'],
  };
  print("JSON DATA: $mapdata");
  http.Response response = await http.post(Uri.parse(apiurl), body: mapdata);
  var data = jsonDecode(response.body);
  print(data);
  return data;
}
