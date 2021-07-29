import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/responsiveness/screen_type.dart';
import 'package:laundry_admin/views/dashboard/add_service.dart/add_service_desktop.dart';
import 'package:laundry_admin/views/dashboard/add_service.dart/add_service_mobile.dart';

import 'add_product_desktop.dart';
import 'add_product_mobile.dart';







class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: HomePageMobilePortrait(),
      //   landscape: HomePageMobileLandscape(),
      // ),
      mobile: AddProductMobile(),
      tablet:AddProductMobile(),
      desktop: AddProductDesktop(),
 
    );
  }
}