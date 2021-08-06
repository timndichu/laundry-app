import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/providers/shop_provider.dart';
import 'package:laundry_admin/widget/text_input_decoration.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import '../dashboard.dart';

class AddProductDesktop extends StatefulWidget {
  @override
  _AddProductDesktopState createState() => _AddProductDesktopState();
}

class _AddProductDesktopState extends State<AddProductDesktop> {
  final _formKey = GlobalKey<FormState>();
  String productName = '';
  String price = '';
  bool loading = false;
  String productImage = '';

  File _image;
  final picker = ImagePicker();

  bool imageExists = false;

  TextEditingController _productName = TextEditingController();
  TextEditingController _price = TextEditingController();

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

   String dropdownvalue = 'Laundry';
  var services = [
    'Laundry',
    'Ironing',
    'Dry Cleaning',
    'Washing and Ironing'
  ];

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _price.dispose();
    _productName.dispose();
    _focusNodes.forEach((node) {
      node.dispose();
    });
    super.dispose();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  PlatformFile objFile;

  void chooseFileUsingFilePicker() async {
    //-----pick file by file picker,

    var result = await FilePicker.platform.pickFiles(
      withReadStream:
          true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      setState(() {
        objFile = result.files.single;
      });
    }
  }

  Future getGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10))),
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Pick an Image',
                    style: TextStyle(fontFamily: 'OpenSansSemi')),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton.icon(
                        textColor: Theme.of(context).accentColor,
                        onPressed: getImage,
                        icon: Icon(Icons.camera,
                            color: Theme.of(context).accentColor),
                        label: Text('Use Camera')),
                    SizedBox(width: 25),
                    FlatButton.icon(
                        textColor: Theme.of(context).accentColor,
                        onPressed: getGalleryImage,
                        icon: Icon(Icons.image,
                            color: Theme.of(context).accentColor),
                        label: Text('Use Gallery'))
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    productImage = productImage;
    if (productImage.length > 0 || productImage != '') {
      setState(() {
        imageExists = true;
      });
    } else {
      setState(() {
        imageExists = false;
      });
    }
     Widget _userSubmitButton() {
      return InkWell(
          onTap: () {
            if (_formKey.currentState.validate()) {
              setState(() {
                loading = true;
              });
              String productName = _productName.text;
              String price = _price.text;
              String serviceType = dropdownvalue;

              var image = objFile;
              if (image != null) {
                print('There is an image!');
                Provider.of<ShopProvider>(context, listen: false)
                    .postProduct(productName, price, serviceType, image)
                    .then((response) {
                  if (response['success']) {
                    setState(() {
                      loading = false;
                    });
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('Product added Successfully :)'),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'))
                            ],
                          );
                        });
                    setState(() {
                      _productName.text = '';
                      _price.text = '';
                      objFile = null;
                    });
                  } else {
                    setState(() {
                      loading = false;
                    });
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('An error occurred'),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'))
                            ],
                          );
                        });
                         setState(() {
                      _productName.text = '';
                        _price.text = '';
                      objFile = null;
                    });
                  }
                }).catchError((error) {
                  setState(() {
                    loading = false;
                  });
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                              'Check your Internet connection then try again'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'))
                          ],
                        );
                      });
                       setState(() {
                      _productName.text = '';
                        _price.text = '';
                      objFile = null;
                    });
                });
              } else {
                setState(() {
                  loading = false;
                });
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('No image selected'),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'))
                        ],
                      );
                    });
              }
            }
          },
          child: Container(
            width: 130,
            padding: EdgeInsets.symmetric(vertical: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.deepPurple, Colors.deepPurple[700]]),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            child: Text(
              'Add Product',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ));
    }

    Widget _formWidget({double height}) {
      return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:    Container(
                   width: width/2.2,
                   
            child: Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 4,
              child: Container(
                padding: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 400, maxHeight: 80),
                        child: TextFormField(
                          focusNode: _focusNodes[0],
                          style: TextStyle(
                              color: Theme.of(context).textTheme.headline1.color),
                          keyboardType: TextInputType.emailAddress,
                          controller: _productName,
                          decoration: textInputDecoration.copyWith(
                            labelText: 'Product name',
                            fillColor: Theme.of(context).cardColor,
                            labelStyle: TextStyle(
                                color: _focusNodes[0].hasFocus
                                    ? Theme.of(context).accentColor
                                    : Colors.grey),
                            hintStyle: TextStyle(
                                color: _focusNodes[0].hasFocus
                                    ? Theme.of(context).accentColor
                                    : Colors.grey),
                           
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter product name' : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 400, maxHeight: 80),
                        child: TextFormField(
                          focusNode: _focusNodes[1],
                          style: TextStyle(
                              color: Theme.of(context).textTheme.headline1.color),
                          keyboardType: TextInputType.number,
                          controller: _price,
                          decoration: textInputDecoration.copyWith(
                            labelText: 'Price',
                            hintText: 'Price in Kenyan Shillings',
                            fillColor: Theme.of(context).cardColor,
                            labelStyle: TextStyle(
                                color: _focusNodes[1].hasFocus
                                    ? Theme.of(context).accentColor
                                    : Colors.grey),
                            hintStyle: TextStyle(
                                color: _focusNodes[1].hasFocus
                                    ? Theme.of(context).accentColor
                                    : Colors.grey),
                           
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter price' : null,
                        ),
                      ),
                    ),
                      SizedBox(height: 10),
                     Text('Service type',style: TextStyle(
                              fontSize: 18, )),
              
            Center(
              child: DropdownButton(
                value: dropdownvalue,
                icon: Icon(Icons.keyboard_arrow_down),
                items: services.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (newval) {
                  setState(() {
                    dropdownvalue = newval;
                  });
                },
              ),
            ),
                    SizedBox(height: 10),
                    Text('Add a photo for the product', style: TextStyle(fontSize: 18,)),
                    SizedBox(height: 10),
                    (objFile != null)
                        ? Text("File selected : ${objFile.name}")
                        : Text('no file selected'),
                    SizedBox(height: 10),
                    RaisedButton(
                        child: Text('Choose image'),
                        onPressed: () {
                          chooseFileUsingFilePicker();
                        }),
                    SizedBox(height: 30),
                    loading ? CircularProgressIndicator() : _userSubmitButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
          
            title: Text('Add Product'),
           ),
        body: 
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Add Product', style: TextStyle(fontSize: 22)),
                ),
                
                SizedBox(height: 30),
                _formWidget(height: height)
              ],
           
              )
        ));
  }
}
