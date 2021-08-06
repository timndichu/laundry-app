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
import 'package:transparent_image/transparent_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SingleUserDesktop extends StatefulWidget {
  @override
  _SingleUserDesktopState createState() => _SingleUserDesktopState();
}

class _SingleUserDesktopState extends State<SingleUserDesktop> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: true,
        title: Text('User Details'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  width: width / 3,
                 padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                          child: Center(
                        child: Icon(Icons.person, color: Colors.white, size: 40),
                      )),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.deepPurple, size: 26),
                          SizedBox(width: 8),
                          Text('Firstname: Timothy', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.deepPurple, size: 26),
                             SizedBox(width: 8),
                          Text('Lastname: Ndichu', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.deepPurple, size: 26),
                             SizedBox(width: 8),
                          Text('Email: timndichu@gmail.com', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.house, color: Colors.deepPurple, size: 26),
                             SizedBox(width: 8),
                          Text('Residence: Juja', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  )),
            ),
          ]),
    );
  }
}
