import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/providers/shop_provider.dart';
import 'package:laundry_admin/views/dashboard/dashboard.dart';
import 'package:laundry_admin/views/dashboard/dashboard_desktop%20copy.dart';
import 'package:laundry_admin/widget/text_input_decoration.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class AddServiceDesktop extends StatefulWidget {
  @override
  _AddServiceDesktopState createState() => _AddServiceDesktopState();
}

class _AddServiceDesktopState extends State<AddServiceDesktop> {
  final _formKey = GlobalKey<FormState>();
  String serviceName = '';
  String password = '';
  bool loading = false;
  String serviceImage = '';

  File _image;
  final picker = ImagePicker();
  String fileSelectedText = 'No image selected';

  bool imageExists = false;

  TextEditingController _serviceName = TextEditingController();
  TextEditingController _password = TextEditingController();

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
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
    _password.dispose();
    _serviceName.dispose();
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
    serviceImage = serviceImage;
    if (serviceImage.length > 0 || serviceImage != '') {
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
              String serviceName = _serviceName.text;

              var image = objFile;
              if (image != null) {
                print('There is an image!');
                Provider.of<ShopProvider>(context, listen: false)
                    .postService(serviceName, image)
                    .then((response) {
                  if (response['success']) {
                    setState(() {
                      loading = false;
                    });
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('Service added Successfully :)'),
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
                      _serviceName.text = '';
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
                      _serviceName.text = '';
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
                      _serviceName.text = '';
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
              'Add Service',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ));
    }

    Widget _formWidget({double height}) {
      return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            height: height / 2,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 4,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 400, maxHeight: 80),
                        child: TextFormField(
                          focusNode: _focusNodes[0],
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline1.color),
                          keyboardType: TextInputType.emailAddress,
                          controller: _serviceName,
                          decoration: textInputDecoration.copyWith(
                            labelText: 'Service name',
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
                              val.isEmpty ? 'Enter service name' : null,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Add a photo for the service',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    SizedBox(height: 10),
                    (objFile != null)
                        ? Text("File selected : ${objFile.name}")
                        : Text(fileSelectedText),
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
          title: Text('Add Service'),
        ),
        body: Row(
          children: [
            Container(
                width: width / 6,
                height: height,
                color: Colors.white,
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => Dashboard()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.local_laundry_service),
                      title: Text('View Services'),
                    ),
                    ListTile(
                      leading: Icon(MdiIcons.tshirtCrew),
                      title: Text('View Products'),
                    )
                  ],
                )),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Add Service', style: TextStyle(fontSize: 22)),
                ),
                SizedBox(height: 50),
                _formWidget(height: height)
              ],
            ),
            Spacer()
          ],
        ));
  }
}
