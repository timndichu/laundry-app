import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/responsiveness/screen_type.dart';

import 'update_service_desktop.dart';
import 'update_service_mobile.dart';







class UpdateService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: HomePageMobilePortrait(),
      //   landscape: HomePageMobileLandscape(),
      // ),
      mobile: UpdateServiceMobile(),
      tablet:UpdateServiceMobile(),
      desktop: UpdateServiceDesktop(),
 
    );
  }
}