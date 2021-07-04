import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

var a, b;

class Productedit extends StatefulWidget {
  const Productedit({Key? key}) : super(key: key);

  @override
  _ProducteditState createState() => _ProducteditState();
}

class _ProducteditState extends State<Productedit> {
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
            return Card(
              // color: Colors.red,
              child: Column(
                children: [
                  Image(
                    height: 80.0,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductEditview()));
                              },
                              icon: Icon(Icons.edit)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget productedit() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: FutureBuilder(
          future: getProduct(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return createGridView(snapshot.data, context);
            }
            return Center(child: CircularProgressIndicator());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Edit"),
      ),
      body: SafeArea(
        child: productedit(),
      ),
    );
  }
}

class ProductEditview extends StatefulWidget {
  const ProductEditview({Key? key}) : super(key: key);

  @override
  _ProductEditviewState createState() => _ProductEditviewState();
}

class _ProductEditviewState extends State<ProductEditview> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  String message = "";
  TextEditingController _id = TextEditingController(text: a[b]['id']);
  TextEditingController _name = TextEditingController(text: a[b]['Pro_name']);
  TextEditingController _category =
      TextEditingController(text: a[b]['category']);
  TextEditingController _price = TextEditingController(text: a[b]['price']);
  TextEditingController _description =
      TextEditingController(text: a[b]['description']);
  TextEditingController _brand = TextEditingController(text: a[b]['brand']);
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _fromKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _id,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: ' Id',
                        labelText: 'Id',
                        labelStyle: TextStyle(fontSize: 25.0)),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter id";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Product Name',
                      labelText: 'Product Name',
                      labelStyle: TextStyle(fontSize: 25.0),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter Product Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _category,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Category',
                      labelText: 'Category',
                      labelStyle: TextStyle(fontSize: 25.0),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter Product Category ";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String? email) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _price,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Price',
                      labelText: 'Price',
                      labelStyle: TextStyle(fontSize: 25.0),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter Product Price";
                      }
                      if (value.length > 6) {
                        return "Prease Enter Valid price";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (String? phone) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _brand,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: 'Brand Name',
                      labelText: 'Brand Name',
                      labelStyle: TextStyle(fontSize: 25.0),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter Brand Name";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    maxLines: 3,
                    controller: _description,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      labelText: 'Description',
                      labelStyle: TextStyle(fontSize: 25.0),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter Drecription";
                      }
                    },
                  ),
                ),
                SizedBox(
                  child: _image == null
                      ? Text('No image selected.')
                      : Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Image.file(_image!)),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 450),
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(
                  child: RaisedButton(
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        editproduct();
                        edituploadimage();
                        print("Sucessful");
                      } else {
                        print("Unsucessful");
                      }
                      Future.delayed(const Duration(seconds: 5), () {
                        //asynchronous delay
                        if (this.mounted) {
                          //checks if widget is still active and not disposed
                          setState(() {
                            //tells the widget builder to rebuild again because ui has updated
                            message =
                                ""; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
                          });
                        }
                      });
                    },
                    child: Text("Edit  Product"),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 30,
            bottom: 20,
            child: FloatingActionButton(
              focusColor: Colors.red,
              onPressed: () {
                deleteproduct();
                deleteuploadimage();
              },
              tooltip: 'Pick Image',
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
          ),
          // Add more floating buttons if you want
          // There is no limit
        ],
      ),
    );
  }

  Future editproduct() async {
    var apiurl = "https://kaskelimart.company/api/productedit.php";
    Map mapdata = {
      'id': _id.text,
      'Pro_name': _name.text,
      'category': _category.text,
      'price': _price.text,
      'description': _description.text,
      'brand': _brand.text,
    };
    print("JSON DATA: $mapdata");
    http.Response response = await http.post(Uri.parse(apiurl), body: mapdata);

    if (response.body.isNotEmpty) {
      var data = jsonDecode(response.body)['message'];

      setState(() {
        message = data;
      });
    }
  }

  Future edituploadimage() async {
    var api = "https://kaskelimart.company/api/image/imageedit.php";
    if (_image == null) return;
    String base64Image = base64Encode(_image!.readAsBytesSync());
    String fileName = _image!.path.split("/").last;

    http.post(Uri.parse(api), body: {
      "image": base64Image,
      "image_name": fileName,
      "id": _id.text,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }

  Future deleteproduct() async {
    var apiurl = "https://kaskelimart.company/api/productdelete.php";
    Map mapdata = {
      'id': _id.text,
    };
    print("JSON DATA: $mapdata");
    http.Response response = await http.post(Uri.parse(apiurl), body: mapdata);

    if (response.body.isNotEmpty) {
      var data = jsonDecode(response.body)['message'];

      setState(() {
        message = data;
      });
    }
  }

  Future deleteuploadimage() async {
    var api = "https://kaskelimart.company/api/image/imagedelete.php";
    http.post(Uri.parse(api), body: {
      "id": _id.text,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }
}
