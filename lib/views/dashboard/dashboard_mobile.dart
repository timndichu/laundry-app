import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/views/dashboard/add_product/add_product.dart';
import 'package:laundry_admin/views/dashboard/add_product/add_product_desktop.dart';
import 'package:laundry_admin/views/dashboard/add_service.dart/add_service.dart';
import 'package:laundry_admin/views/dashboard/add_service.dart/add_service_desktop.dart';
import 'package:laundry_admin/views/dashboard/dashboard.dart';
import 'package:laundry_admin/views/dashboard/update_product/update_product.dart';
import 'package:laundry_admin/views/dashboard/update_product/update_product_desktop.dart';
import 'package:laundry_admin/views/dashboard/update_service/update_service.dart';
import 'package:laundry_admin/views/dashboard/view_products/products.dart';
import 'package:laundry_admin/views/dashboard/view_services/services.dart';
import 'package:laundry_admin/views/login/login.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:analog_clock/analog_clock.dart';

class DashboardMobile extends StatefulWidget {
  @override
  _DashboardMobileState createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {
  @override
  Widget build(BuildContext context) {
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
                      CupertinoPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: Icon(Icons.logout, color: Colors.white),
                  label:
                      Text('Log out', style: TextStyle(color: Colors.white))),
            ]),
        body: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('Hi, admin', style: TextStyle(fontSize: 40)),
              ),
              Spacer(),
              Container(
                height: 150,
                child: AnalogClock(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.white),
                      color: Colors.black,
                      shape: BoxShape.circle),
                  width: 150.0,
                  height: 150,
                  isLive: true,
                  hourHandColor: Colors.white,
                  minuteHandColor: Colors.deepPurple,
                  showSecondHand: true,
                  secondHandColor: Colors.red,
                  numberColor: Colors.white,
                  showNumbers: true,
                  textScaleFactor: 1.4,
                  showTicks: true,
                  showDigitalClock: false,
                  datetime: DateTime.now(),
                ),
              ),
              SizedBox(width: 150),
            ],
          )
        ]));
  }
}
