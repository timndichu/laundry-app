import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/models/products.dart';
import 'package:laundry_admin/models/products.dart';

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
                    onTap: () {
                    
                    },
          child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(1, 2),
                  blurRadius: 8,
                  spreadRadius: 1)
            ],
        ),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                   
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                  
                    height: 125,
                    child: Hero(
                      tag: "${widget.product.id}",
                     
                        child: FadeInImage.memoryNetwork(
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            placeholder: kTransparentImage,
                            image: widget.product.image),
                      
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 45,
                    child:
                        widget.product.title == null || widget.product.title.length == 0
                            ? Text('Air Max',
                                style: TextStyle(
                                   fontFamily: 'OpenSansLight', fontSize: 16.5
                                 ))
                            : Text(widget.product.title,
                                 style: TextStyle(
                                   fontSize: 16.5
                                 )
                                   ),
                  ),
                ),
              ],
            ),

         
            

           
          ],
        ),
      ),
    );
  }
}
