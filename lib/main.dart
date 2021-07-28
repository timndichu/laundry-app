import 'package:flutter/material.dart';
import 'package:laundry_admin/providers/shop_provider.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'views/login/login.dart';

void main() {
  runApp( MultiProvider(
        child: MyApp(),
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (BuildContext context) {
              return AuthProvider();
            },
          ),
          ChangeNotifierProvider<ShopProvider>(
            create: (BuildContext context) {
              return ShopProvider();
            },
          ),
          ]));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         accentColor: Colors.deepPurple,
            primaryColor: Colors.deepPurple,
             textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.deepPurple, selectionColor: Colors.deepPurple, selectionHandleColor: Colors.deepPurple,),
        primarySwatch: Colors.deepPurple,
      ),
      home: Login(),
    );
  }
}
