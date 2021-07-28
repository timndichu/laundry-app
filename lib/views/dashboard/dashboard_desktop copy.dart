import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardDesktop extends StatefulWidget {
  @override
  _DashboardDesktopState createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget _addService() {
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
              'Add Service',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ));
    }

    Widget _addProduct() {
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

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            automaticallyImplyLeading: false,
            title: Text('Dashboard')),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
              child: Wrap(
                  runSpacing: 16.0,
                  runAlignment: WrapAlignment.start,
                  alignment: WrapAlignment.start,
                  children: [
                    Container(
                      height: height / 3.5,
                      width: width / 3.5,
                      child: Card(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _addService(),
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
                      width: width / 3.5,
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
                      width: width / 3.5,
                      child: Card(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _addService(),
                                SizedBox(height: 15),
                                _addProduct()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])),
        ));
  }
}
