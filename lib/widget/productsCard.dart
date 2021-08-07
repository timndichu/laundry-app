import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/models/products.dart';
import 'package:laundry_admin/models/products.dart';
import 'package:laundry_admin/providers/shop_provider.dart';
import 'package:laundry_admin/views/dashboard/update_product/update_product.dart';

import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductsCard extends StatefulWidget {
  final String url;
  final String title;
  final int index;
  final num price;
  final Product product;
  ProductsCard({this.url, this.product, this.price, this.title, this.index});

  @override
  _ProductsCardState createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
            Container(
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
                    image: widget.product.image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(children: [
                Container(
                  height: 25,
                  child: widget.product.title == null ||
                          widget.product.title.length == 0
                      ? Text('Air Max', style: TextStyle(fontSize: 16.5))
                      : Text(widget.product.title,
                          style: TextStyle(fontSize: 16.5)),
                ),
                Spacer(),
                Container(
                  height: 25,
                  child: widget.product.price == null
                      ? Text('Ksh.1',
                          style: TextStyle(
                              fontSize: 16.5, fontWeight: FontWeight.bold))
                      : Text('Ksh. ${widget.product.price}',
                          style: TextStyle(
                              fontSize: 16.5, fontWeight: FontWeight.bold)),
                ),
              ]),
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
                      CupertinoPageRoute(builder: (context) => UpdateProduct(product: widget.product)),
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
                                                ' ${widget.product.title.toString()} ',
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
                                              .deleteProduct(
                                                  widget.product.id, widget.product.serviceId)
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
