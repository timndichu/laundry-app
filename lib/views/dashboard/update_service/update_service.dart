import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/models/services.dart';
import 'package:laundry_admin/responsiveness/screen_type.dart';

import 'update_service_desktop.dart';
import 'update_service_mobile.dart';







class UpdateService extends StatelessWidget {
   final Service service;
   UpdateService({this.service});
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: HomePageMobilePortrait(),
      //   landscape: HomePageMobileLandscape(),
      // ),
      mobile: UpdateServiceMobile(service: service),
      tablet:UpdateServiceMobile(service: service),
      desktop: UpdateServiceDesktop(service: service),
 
    );
  }
}