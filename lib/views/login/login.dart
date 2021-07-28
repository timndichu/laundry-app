import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/views/login/login_desktop.dart';
import 'package:laundry_admin/views/login/login_mobile.dart';



import '../../responsiveness/screen_type.dart';



class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return ScreenTypeLayout(
     
      mobile: LoginMobile(),
      tablet:LoginMobile(),
      desktop: LoginDesktop(),
    
    );
  }
}