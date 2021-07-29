import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/responsiveness/screen_type.dart';


import 'services_desktop.dart';
import 'services_mobile.dart';







class Services extends StatelessWidget {
  final bool update;
  Services({this.update});
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: HomePageMobilePortrait(),
      //   landscape: HomePageMobileLandscape(),
      // ),
      mobile: ServicesMobile(update: update),
      tablet:ServicesMobile(update: update),
      desktop: ServicesDesktop(update: update),
 
    );
  }
}