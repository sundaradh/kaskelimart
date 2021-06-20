import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Productenter extends StatefulWidget {
  const Productenter({Key? key}) : super(key: key);

  @override
  _ProductenterState createState() => _ProductenterState();
}

class _ProductenterState extends State<Productenter> {
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
  TextEditingController _id = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _brand = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Product"),
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
                        registerproduct();
                        uploadimage();
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
                    child: Text("Enter Product"),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future registerproduct() async {
    var apiurl = "https://kaskelimart.company/api/productenter.php";
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

  Future uploadimage() async {
    var api = "https://kaskelimart.company/api/image/image.php";
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
}
