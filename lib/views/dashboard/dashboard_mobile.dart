import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/views/dashboard/add_product/add_product_desktop.dart';
import 'package:laundry_admin/views/dashboard/add_service.dart/add_service.dart';
import 'package:laundry_admin/views/dashboard/add_service.dart/add_service_desktop.dart';
import 'package:laundry_admin/views/dashboard/dashboard.dart';
import 'package:laundry_admin/views/dashboard/view_products/products.dart';
import 'package:laundry_admin/views/dashboard/view_services/services.dart';
import 'package:laundry_admin/views/login/login.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DashboardMobile extends StatefulWidget {
  @override
  _DashboardMobileState createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget _addService(context) {
      return InkWell(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => AddService()),
            );
          },
          child: Container(
            width: 120,
            padding: EdgeInsets.symmetric(vertical: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.green[800]),
            child: Text(
              'Add Service',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ));
    }

    Widget _addProduct() {
      return InkWell(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => AddProductDesktop()),
            );
          },
          child: Container(
            width: 120,
            padding: EdgeInsets.symmetric(vertical: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.lightGreen[700]),
            child: Text(
              'Add Product',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ));
    }

    Widget _updateService() {
      return InkWell(
          onTap: () {},
          child: Container(
            width: 120,
            padding: EdgeInsets.symmetric(vertical: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.deepPurple),
            child: Text(
              'Update Service',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ));
    }

    Widget _updateProduct() {
      return InkWell(
          onTap: () {},
          child: Container(
            width: 120,
            padding: EdgeInsets.symmetric(vertical: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.deepOrange),
            child: Text(
              'Update Product',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ));
    }

    Widget _removeService() {
      return InkWell(
          onTap: () {},
          child: Container(
            width: 130,
            padding: EdgeInsets.symmetric(vertical: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.red[900]),
            child: Text(
              'Remove Service',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ));
    }

    Widget _removeProduct() {
      return InkWell(
          onTap: () {},
          child: Container(
            width: 130,
            padding: EdgeInsets.symmetric(vertical: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.red[600]),
            child: Text(
              'Remove Product',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ));
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
                  onPressed: () {
                     Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Login()),
                              (Route<dynamic> route) => false,
                            );
                  },
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
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(8))
                       , child: ListTile(
                          leading: Icon(Icons.home, color: Colors.white),
                          
                         
                          title: Text('Home', style: TextStyle(color:Colors.white)),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => Dashboard()),
                            );
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.local_laundry_service),
                      title: Text('View Services'),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => Services()),
                        );
                      },
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
            Center(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Wrap(
                      runSpacing: 30.0,
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        Container(
                          height: height / 3.5,
                          width: width / 4.5,
                          child: Card(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _addService(context),
                                    SizedBox(height: 15),
                                    _addProduct()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height / 3.5,
                          width: width / 4.5,
                          child: Card(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _updateService(),
                                    SizedBox(height: 15),
                                    _updateProduct()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height / 3.5,
                          width: width / 4.5,
                          child: Card(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _removeService(),
                                    SizedBox(height: 15),
                                    _removeProduct()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])),
            )
          ],
        ));
  }
}
