import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/providers/shop_provider.dart';
import 'package:laundry_admin/views/dashboard/add_product/add_product_desktop.dart';

import 'package:laundry_admin/views/dashboard/view_products/products.dart';
import 'package:laundry_admin/views/dashboard/view_services/services.dart';
import 'package:laundry_admin/views/login/login.dart';
import 'package:laundry_admin/widget/serviceCard.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../dashboard.dart';

class ServicesMobile extends StatefulWidget {
  final bool update;
ServicesMobile({this.update});
  @override
  _ServicesMobileState createState() => _ServicesMobileState();
}

class _ServicesMobileState extends State<ServicesMobile> {


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
                     Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(8))
                       , child: ListTile(
                           leading: Icon(Icons.local_laundry_service, color: Colors.white),
                      title: Text('View Services', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => Services()),
                        );
                      },
                        ),
                      ),
                    ),
                   
                    ListTile(
                      leading: Icon(MdiIcons.tshirtCrew),
                      title: Text('View Products'),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => Products()),
                        );
                      },
                    )
                  ],
                )),
              Container(
                width: width/1.5,
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
              )
          ],
        ));
  }
}
