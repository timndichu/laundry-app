import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/responsiveness/screen_type.dart';


import 'update_product_desktop.dart';
import 'update_product_mobile.dart';







class UpdateProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: HomePageMobilePortrait(),
      //   landscape: HomePageMobileLandscape(),
      // ),
      mobile: UpdateProductMobile(),
      tablet:UpdateProductMobile(),
      desktop: UpdateProductDesktop(),
 
    );
  }
}