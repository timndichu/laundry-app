import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/responsiveness/screen_type.dart';


import 'products_desktop.dart';
import 'products_mobile.dart';







class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
      // mobile: OrientationLayout(
      //   portrait: HomePageMobilePortrait(),
      //   landscape: HomePageMobileLandscape(),
      // ),
      mobile: ProductsMobile(),
      tablet:ProductsMobile(),
      desktop: ProductsDesktop(),
 
    );
  }
}