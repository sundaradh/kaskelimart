import 'dart:convert';

import 'package:carousel_images/carousel_images.dart';
import 'package:flutter/material.dart';
import 'package:kaskelimart/login.dart';
import 'package:http/http.dart' as http;

List a = [];
int b = 0;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> listImages = [
    'https://cdn.flixbus.de/2018-01/munich-header-d8_0.jpg',
    'https://cdn.flixbus.de/2018-01/munich-header-d8_0.jpg',
  ];
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
    getProduct();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: Maindrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              child: Container(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 150.0,
                width: 300.0,
                child: CarouselImages(
                  scaleFactor: 0.6,
                  listImages: listImages,
                  height: 300.0,
                  borderRadius: 30.0,
                  cachedNetworkImage: true,
                  verticalAlignment: Alignment.topCenter,
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Category',
              style: TextStyle(fontSize: 25.0),
            ),
            Container(
                height: 140,
                child: Container(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            category(Icon(Icons.food_bank), 'food'),
                            category(Icon(Icons.computer), 'Computer'),
                            category(Icon(Icons.phone), 'Mobile'),
                            category(Icon(Icons.food_bank), 'food'),
                            category(Icon(Icons.computer), 'Computer'),
                            category(Icon(Icons.phone), 'Mobile'),
                          ],
                        )))),
            product()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: null,
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
              maxCrossAxisExtent: 250,
              crossAxisSpacing: 0.5,
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
                      height: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(data[index]['Pro_name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.fade),
                        Text(
                          "Rs:" + data[index]['price'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
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
            accountName: Text('sanjay'),
            accountEmail: Text('sanjayrawal411@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),

          // body
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text("Home page"),
              leading: Icon(
                Icons.home,
                color: Colors.green,
              ),
            ),
          ),
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
            onTap: () {},
            child: ListTile(
              title: Text("setting"),
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
          )
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
    return Scaffold(
        appBar: AppBar(
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
