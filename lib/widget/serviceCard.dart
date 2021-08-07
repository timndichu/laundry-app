import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/models/services.dart';
import 'package:laundry_admin/providers/shop_provider.dart';
import 'package:laundry_admin/views/dashboard/update_service/update_service.dart';
import 'package:laundry_admin/views/dashboard/view_products/products.dart';

import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ServiceCard extends StatefulWidget {
  final bool update;
  final bool delete;
  final Service service;
  final num index;
  ServiceCard({this.update, this.service, this.index, this.delete});

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool update = false;

  bool delete = false;

  @override
  void initState() {
    if (widget.update != null) {
      update = widget.update;
    }
    if (widget.delete != null) {
      delete = widget.delete;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => Products(id: widget.index)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 2),
                blurRadius: 8,
                spreadRadius: 1)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => Products(id: widget.index)),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      placeholder: kTransparentImage,
                      image: widget.service.imageUrl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 25,
                child: widget.service.title == null ||
                        widget.service.title.length == 0
                    ? Text('Air Max',
                        style: TextStyle(
                            fontFamily: 'OpenSansLight', fontSize: 16.5))
                    : Text(widget.service.title,
                        style: TextStyle(fontSize: 16.5)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                        icon: Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                             Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => UpdateService(service: widget.service)),
                    );
                        },
                        label: Text('Update',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'InterRegular',
                            )),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5.0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrange),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(16)),
                            textStyle: MaterialStateProperty.all(TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'InterRegular',
                            )))),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton.icon(
                        icon: Icon(Icons.delete, color: Colors.white),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text: 'Are you sure you want to delete',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .textTheme
                                              .headline1
                                              .color,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                ' ${widget.service.title.toString()} ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.deepPurple),
                                          ),
                                          TextSpan(
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  .color,
                                            ),
                                            text: 'permanently?',
                                          ),
                                        ]),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Provider.of<ShopProvider>(context,
                                                  listen: false)
                                              .deleteService(widget.service.id)
                                              .then((response) {
                                            if (response['success'] == true) {
                                          
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          'Something went wrong. Try again later'),
                                                      actions: <Widget>[
                                                        FlatButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Text('OK'))
                                                      ],
                                                    );
                                                  });
                                            }
                                          }).catchError((error) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                        'Check your Internet connection then try again'),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('OK'))
                                                    ],
                                                  );
                                                });
                                          });
                                        },
                                        child: Text('Yes')),
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No'))
                                  ],
                                );
                              });
                        },
                        label: Text('Delete',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'InterRegular',
                            )),
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5.0),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red[800]),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(16)),
                            textStyle: MaterialStateProperty.all(TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'InterRegular',
                            )))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
