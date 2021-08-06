import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/providers/shop_provider.dart';
import 'package:laundry_admin/views/dashboard/add_product/add_product_desktop.dart';
import 'package:laundry_admin/views/dashboard/add_service.dart/add_service.dart';
import 'package:laundry_admin/views/dashboard/add_service.dart/add_service_desktop.dart';
import 'package:laundry_admin/views/dashboard/view_products/products.dart';
import 'package:laundry_admin/views/dashboard/view_services/services.dart';
import 'package:laundry_admin/views/login/login.dart';
import 'package:laundry_admin/widget/serviceCard.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../dashboard.dart';

class ServicesDesktop extends StatefulWidget {
  final bool update;
ServicesDesktop({this.update});
  @override
  _ServicesDesktopState createState() => _ServicesDesktopState();
}

class _ServicesDesktopState extends State<ServicesDesktop> {


  bool isLoading = false;

    bool update = false;

   @override
  void initState() {
     if(widget.update!=null){
      update = widget.update;
    }
    Provider.of<ShopProvider>(context, listen: false).services.length > 0
        ? print('ALready fetched')
        : Future.delayed(Duration.zero, () {
            Provider.of<ShopProvider>(context, listen: false).getServices();
          });
  
    super.initState();
  }

        Future<void> _refresh() async {
   
    await Future.delayed(Duration.zero, () {
      Provider.of<ShopProvider>(context, listen: false)
          .getServices()
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;



    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
          
            title: Text('All Services'),
            actions: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: 150, height: 35),
                            child: ElevatedButton.icon( icon: Icon(Icons.add, size:26,  color: Colors.deepPurple), label:  Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('Add Service',
                                    style: TextStyle(
                                        fontFamily: 'InterRegular',
                                        color: Colors.deepPurple)),
                              ),
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0.2),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.white),
                                  shape:
                                      MaterialStateProperty.all(StadiumBorder()),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(8)),
                                  textStyle: MaterialStateProperty.all(TextStyle(
                                    fontSize: 16,
                                    color: Colors.deepPurple,
                                    fontFamily: 'InterRegular',
                                  ))),
                      
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => AddService()),
                                )
                              },
                            ),
                          ),
            ),
                     
            ],
           ),
        body: 
              Container(
              
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Consumer<ShopProvider>(
                        builder: (context, model, child) {
                          Widget content =
                              Center(child: Text('Error fetching data. Check your Internet connection'));

                          if (model.isLoading) {
                         
                            content = Center(child: CircularProgressIndicator());
                          } else if ((model.services.length == 0 &&
                              !model.isLoading)) {
                            content =
                                Center(child: Text('No services added yet'));
                          } else if ((model.services.length > 0 &&
                              !model.isLoading)) {
                            content = new RefreshIndicator(
                              onRefresh: _refresh,
                              child: GridView.builder(
                                padding: EdgeInsets.all(15),
                             
                                physics: AlwaysScrollableScrollPhysics(),
                                gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                      4 ,mainAxisSpacing: 15,crossAxisSpacing: 15,childAspectRatio: 1.2
),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: model.services.length,
                                itemBuilder: (BuildContext _context, int index) {
                                  if (index < model.services.length) {
                                    return ServiceCard(
                                        service: model.services[index],
                                        update: update,
                                        index: index);
                                  } else {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 32.0),
                                      child: Center(
                                          child: Text('nothing more to load!')),
                                    );
                                  }
                                },
                              ),
                            );
                          }

                          return content;
                        },))]),
          
        ));
  }
}
