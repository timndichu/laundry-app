import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/responsiveness/screen_type.dart';


import 'dashboard_desktop.dart';
import 'dashboard_mobile.dart';







class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: HomePageMobilePortrait(),
      //   landscape: HomePageMobileLandscape(),
      // ),
      mobile: DashboardMobile(),
      tablet:DashboardMobile(),
      desktop: DashboardDesktop(),
 
    );
  }
}