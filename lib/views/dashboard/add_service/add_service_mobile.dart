import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/widget/text_input_decoration.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';


class AddServiceMobile extends StatefulWidget {
  @override
  _AddServiceMobileState createState() => _AddServiceMobileState();
}

class _AddServiceMobileState extends State<AddServiceMobile> {
  final _formKey = GlobalKey<FormState>();
  String serviceName = '';
  String password = '';
  bool loading = false;
  String serviceImage = '';

  File _image;
  final picker = ImagePicker();

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
            setState(() {
              loading = true;
            });
            if (_formKey.currentState.validate()) {
              setState(() {
                loading = false;
              });
            } else {
              setState(() {
                loading = false;
              });
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
       
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400, maxHeight: 60),
                child: TextFormField(
                  focusNode: _focusNodes[0],
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1.color),
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
                    prefixIcon: Icon(
                      Icons.person,
                      color: _focusNodes[0].hasFocus
                          ? Theme.of(context).accentColor
                          : Colors.grey,
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter service name' : null,
                ),
              ),
              SizedBox(height: 10),
              Text('Add a photo for the service'),
              SizedBox(height: 10),
              // InkWell(
              //   onTap: () {
              //     _openImagePicker(context);
              //   },
              //   child: DottedBorder(
              //     dashPattern: [8, 4],
              //     strokeWidth: 2,
              //     child: Container(
              //       height: 200,
              //       width: 200,
                   
              //       child: _image == null
              //           ? Center(
              //               child: Icon(Icons.add),
              //             )
              //           : Container(
              //               decoration: BoxDecoration(
              //                 image: DecorationImage(
              //                   image: FileImage(
              //                     File(_image.path),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //     ),
              //   ),
              // ),
                new Container(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          margin: const EdgeInsets.all(10.0),
                          child:   (objFile != null) ? Text("File name : ${objFile.name}") : Text('no file selected'),
                        ),
                        Positioned(
                            bottom: 10,
                            right: 10,
                            child: InkWell(
                                onTap: () {
                                  chooseFileUsingFilePicker();
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffB99443),),
                                    child: Icon(Icons.camera_alt,
                                        color: Colors.white, size: 24))))
                      ],
                    )),
              SizedBox(height: 30),
              loading ? CircularProgressIndicator() : _userSubmitButton(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            automaticallyImplyLeading: false,
            title: Text('Dashboard'),
            actions: [
              RaisedButton.icon(
                  color: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(Icons.logout, color: Colors.white),
                  label:
                      Text('Log out', style: TextStyle(color: Colors.white))),
            ]),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Add Service'),
                SizedBox(height: 30),
                _formWidget(height: height)
              ],
            )
          ],
        ));
  }
}
