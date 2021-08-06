import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/models/services.dart';
import 'package:laundry_admin/views/dashboard/view_products/products.dart';

import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';



class ServiceCard extends StatefulWidget {
 final bool update;
  final bool delete;
  final Service service;
  final num index;
  ServiceCard({this.update, this.service,this.index, this.delete });

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {

  bool update = false;
 
  bool delete = false;
 
  @override
  void initState() {
    if(widget.update!=null){
      update = widget.update;
    }
    if(widget.delete!=null){
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
                                CupertinoPageRoute(
                                    builder: (context) => Products(id: widget.index)),
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
        child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                   
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                  
                    height: 125,
                    child:  ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      child: FadeInImage.memoryNetwork(
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              placeholder: kTransparentImage,
                              image: widget.service.imageUrl),
                    ),
                      
                   
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 25,
                    child:
                        widget.service.title == null || widget.service.title.length == 0
                            ? Text('Air Max',
                                style: TextStyle(
                                   fontFamily: 'OpenSansLight', fontSize: 16.5
                                 ))
                            : Text(widget.service.title,
                                 style: TextStyle(
                                   fontSize: 16.5
                                 )
                                   ),
                  ),
                ),
                 update ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(onPressed: (){

                  },
                  child: Text('Edit'),
                  )
                ) : Container(height:0, width:0),
                delete  ?  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(onPressed: (){
                    //Show dialog box to ask to delete?
                  },
                  child: Text('Delete'),
                  )
                ): Container(height:0, width:0),
              ],
            ),

         
            

           
        
      ),
    );
  }
}
