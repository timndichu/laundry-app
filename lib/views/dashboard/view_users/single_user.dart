import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/responsiveness/screen_type.dart';


import 'single_user_desktop.dart';
import 'single_user_mobile.dart';







class SingleUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: HomePageMobilePortrait(),
      //   landscape: HomePageMobileLandscape(),
      // ),
      mobile: SingleUserMobile(),
      tablet:SingleUserMobile(),
      desktop: SingleUserDesktop(),
 
    );
  }
}