import 'package:flutter/material.dart';

class Productview extends StatefulWidget {
  Productview({Key? key}) : super(key: key);

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
      body: Image(
          image: NetworkImage(
              'https://static.remove.bg/remove-bg-web/2e3a8aa57bcd08605c78f95f1c4bd007b07a5100/assets/start_remove-79a4598a05a77ca999df1dcb434160994b6fde2c3e9101984fb1be0f16d0a74e.png')),
    );
  }
}
