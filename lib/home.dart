import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: Maindrawer(),
      body: Center(
        child: Text('Home'),
      ),
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
