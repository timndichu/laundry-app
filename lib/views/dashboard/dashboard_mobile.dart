import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardMobile extends StatefulWidget {


  @override
  _DashboardMobileState createState() => _DashboardMobileState();
}

class _DashboardMobileState extends State<DashboardMobile> {
  @override
  Widget build(BuildContext context) {
       final width = MediaQuery.of(context).size.width;
     final height = MediaQuery.of(context).size.height;

   return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffA4312A),
            automaticallyImplyLeading: false, title: Text('Dashboard')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
            child: Wrap(
                runSpacing: 16.0,
                runAlignment: WrapAlignment.start,
                alignment: WrapAlignment.start,
                children: 
                [ Container(
                    
                  child: Card(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                           Text('Total Number of Bookings Made',
                            style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'InterMedium',
                          
                          )
                           ),
                           SizedBox(height: 20),
                            Text('72',
                            style: TextStyle(
                            fontSize: 26,
                            fontFamily: 'InterBold',
                            color: Color(0xffd5916c),
                          )
                           ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                   
                  child: Card(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Total Number of Sales Made',
                            style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'InterMedium',
                            
                          )
                           ),
                           SizedBox(height: 10),
                            Text('54',
                            style: TextStyle(
                            fontSize: 26,
                            fontFamily: 'InterBold',
                            color: Color(0xffd5916c),
                          )
                           ),
                             SizedBox(height: 15),
                            Text('Total Sales Made',
                            style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'InterMedium',
                           
                          )
                           ),
                           SizedBox(height: 10),
                            Text('Ksh. 25000',
                            style: TextStyle(
                            fontSize: 26,
                            fontFamily: 'InterBold',
                            color: Color(0xffd5916c),
                          )
                           ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                
                  child: Card(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('10% of amount made from Total Sales',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'InterMedium',
                            
                          )
                           ),
                           SizedBox(height: 20),
                            Text('Ksh. 5000',
                            style: TextStyle(
                            fontSize: 26,
                            fontFamily: 'InterBold',
                            color: Color(0xffd5916c),
                          )
                           ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                
                ]
               ),
          ),
        ));
  }
}
