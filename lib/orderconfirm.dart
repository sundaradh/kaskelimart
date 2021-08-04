import 'package:flutter/material.dart';

class Orderconfirm extends StatefulWidget {
  const Orderconfirm({Key? key}) : super(key: key);

  @override
  _OrderconfirmState createState() => _OrderconfirmState();
}

class _OrderconfirmState extends State<Orderconfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order confirmation"),
      ),
      body: SingleChildScrollView(
        child: Container(),
      ),
    );
  }
}
