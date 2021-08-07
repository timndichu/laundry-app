import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/providers/shop_provider.dart';
import 'package:laundry_admin/views/dashboard/add_product/add_product.dart';
import 'package:laundry_admin/views/dashboard/add_product/add_product_desktop.dart';

import 'package:laundry_admin/views/dashboard/dashboard.dart';
import 'package:laundry_admin/views/dashboard/update_product/update_product.dart';
import 'package:laundry_admin/views/dashboard/update_product/update_product_desktop.dart';
import 'package:laundry_admin/views/dashboard/update_service/update_service.dart';
import 'package:laundry_admin/views/dashboard/view_products/products.dart';
import 'package:laundry_admin/views/dashboard/view_services/services.dart';
import 'package:laundry_admin/views/dashboard/view_users/single_user.dart';
import 'package:laundry_admin/views/dashboard/view_users/users.dart';
import 'package:laundry_admin/views/login/login.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'add_service/add_service.dart';

class DashboardDesktop extends StatefulWidget {
  @override
  _DashboardDesktopState createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop> {
  var dateNow = DateTime.now();
  String date;

  @override
  void initState() {
    date = DateFormat('EEEE, d MMM, yyyy').format(dateNow).toString();
     Provider.of<ShopProvider>(context, listen: false).services.length > 0
        ? print('ALready fetched')
        : Future.delayed(Duration.zero, () {
            Provider.of<ShopProvider>(context, listen: false).getServices();
          });
          
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Widget _servicesDivider() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey[400],
                ),
              ),
            ),
            Text('Services',
                style: TextStyle(color: Colors.grey[800], fontSize: 26)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey[400],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      );
    }

    Widget _userDivider() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Spacer(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey[400],
                ),
              ),
            ),
            Text('Users',
                style: TextStyle(color: Colors.grey[800], fontSize: 26)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey[400],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      );
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
                      CupertinoPageRoute(builder: (context) => Login()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: Icon(Icons.logout, color: Colors.white),
                  label:
                      Text('Log out', style: TextStyle(color: Colors.white))),
            ]),
        body: Row(children: [
          Container(
              width: width/7,
              height: height,
              color: Colors.white,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        leading: Icon(Icons.home, color: Colors.white),
                        title:
                            Text('Home', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Dashboard()),
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
                    title: Text('Add Product'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => AddProduct()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(MdiIcons.plusBox),
                    title: Text('Add Service'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => AddService()),
                      );
                    },
                  ),
                   ListTile(
                    leading: Icon(Icons.people),
                    title: Text('Users'),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => Users()),
                      );
                    },
                  )
                ],
              )),
          Container(
            width: width/1.2,
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20),
                        child: Text('Hi, admin',
                            style: GoogleFonts.courgette(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20),
                        child: Text(date,
                            style: GoogleFonts.courgette(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 175,
                          child: AnalogClock(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4.0, color: Colors.deepPurple),
                                color: Colors.black,
                                shape: BoxShape.circle),
                            width: 175.0,
                            height: 175,
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
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _servicesDivider(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      ListTile(
                          title: Row(
                        children: [
                          SizedBox(width: 60),
                          Text('Service Name',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Spacer(),
                          Center(
                              child: Text('Products',
                                  style: TextStyle(fontWeight: FontWeight.w600))),
                          Spacer(),
                          SizedBox(width: 60)
                        ],
                      )),
                      ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey[300]))),
                            child: ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).cardColor,
                                    border:
                                        Border.all(color: Colors.grey, width: 1)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: FadeInImage.memoryNetwork(
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      placeholder: kTransparentImage,
                                      image:
                                          'assets/images/login_background.jpg'),
                                ),
                              ),
                              title: Row(children: [
                                Container(width: 100, child: Text('Laundry')),
                                // SizedBox(width: 15),
                                Spacer(),

                                Center(
                                  child: Container(
                                    height: 50,
                                    width: 140,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    Theme.of(context).cardColor,
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: FadeInImage.memoryNetwork(
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                  placeholder: kTransparentImage,
                                                  image:
                                                      'assets/images/login_background.jpg'),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 35,
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    Theme.of(context).cardColor,
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: FadeInImage.memoryNetwork(
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                  placeholder: kTransparentImage,
                                                  image:
                                                      'assets/images/login_background.jpg'),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 70,
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    Theme.of(context).cardColor,
                                                border: Border.all(
                                                    color: Colors.deepPurple,
                                                    width: 2)),
                                            child: Center(
                                              child: Text(
                                                '+ 2',
                                                style: TextStyle(
                                                    color: Colors.deepPurple),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer()
                              ]),
                              trailing: IconButton(
                                icon: Icon(Icons.arrow_forward_outlined),
                                onPressed: () {},
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints.tightFor(width: 80, height: 35),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0.2),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurple),
                                    shape: MaterialStateProperty.all(
                                        StadiumBorder()),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(8)),
                                    textStyle:
                                        MaterialStateProperty.all(TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'InterRegular',
                                    ))),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('See All',
                                      style: TextStyle(
                                          fontFamily: 'InterRegular',
                                          color: Colors.white)),
                                ),
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Services()),
                                  )
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _userDivider(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      ListTile(
                          title: Row(
                        children: [
                          SizedBox(width: 60),
                          Text('First Name',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Spacer(),
                          Text('Last Name',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Spacer(),
                          Text('Email',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Spacer(),
                          Text('Residence',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Spacer(),
                          SizedBox(width: 60)
                        ],
                      )),
                      ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey[300]))),
                            child: ListTile(
                              leading: CircleAvatar(
                                  child: Center(
                                child: Icon(Icons.person, color: Colors.white),
                              )),
                              title: Row(children: [
                                ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: 25, maxWidth: 200),
                                    child: Text('Timothy')),
                                SizedBox(width: 70),
                                Spacer(),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: 25, maxWidth: 200),
                                  child: Text(
                                    'Ndichu',
                                  ),
                                ),
                                Spacer(),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: 25, maxWidth: 200),
                                  child: Text(
                                    'timndichu@gmail.com',
                                  ),
                                ),
                                Spacer(),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight: 25, maxWidth: 200),
                                  child: Text(
                                    'Ngong',
                                  ),
                                ),
                                Spacer(),
                                SizedBox(width: 60)
                              ]),
                              trailing: IconButton(
                                icon: Icon(Icons.arrow_forward_outlined),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => SingleUser()));
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints.tightFor(width: 80, height: 35),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0.2),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.deepPurple),
                                    shape: MaterialStateProperty.all(
                                        StadiumBorder()),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(8)),
                                    textStyle:
                                        MaterialStateProperty.all(TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'InterRegular',
                                    ))),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text('See All',
                                      style: TextStyle(
                                          fontFamily: 'InterRegular',
                                          color: Colors.white)),
                                ),
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => Users()),
                                  )
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                ),
                SizedBox(height: 100)
              ]),
            ),
          ),
        ]));
  }
}
