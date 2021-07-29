import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/providers/shop_provider.dart';
import 'package:laundry_admin/views/dashboard/add_product/add_product_desktop.dart';
import 'package:laundry_admin/views/dashboard/add_service.dart/add_service.dart';
import 'package:laundry_admin/views/dashboard/add_service.dart/add_service_desktop.dart';
import 'package:laundry_admin/views/dashboard/view_products/products.dart';
import 'package:laundry_admin/views/dashboard/view_products/products.dart';
import 'package:laundry_admin/views/dashboard/view_services/services.dart';
import 'package:laundry_admin/views/login/login.dart';
import 'package:laundry_admin/widget/productsCard.dart';
import 'package:laundry_admin/widget/serviceCard.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../dashboard.dart';

class ProductsDesktop extends StatefulWidget {
  @override
  _ProductsDesktopState createState() => _ProductsDesktopState();
}

class _ProductsDesktopState extends State<ProductsDesktop> {


  bool isLoading = false;

   @override
  void initState() {
    Provider.of<ShopProvider>(context, listen: false).products.length > 0
        ? print('ALready fetched')
        : Future.delayed(Duration.zero, () {
            Provider.of<ShopProvider>(context, listen: false).getProducts();
          });
  
    super.initState();
  }

        Future<void> _refresh() async {
   
    await Future.delayed(Duration.zero, () {
      Provider.of<ShopProvider>(context, listen: false)
          .getProducts()
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;



    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
        
            title: Text('All Products'),
           ),
        body: Row(
          children: [
            Container(
                width: width / 6,
                height: height,
                color: Colors.white,
                child: ListView(
                  children: [
                   ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Home'),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => Dashboard()),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.local_laundry_service),
                      title: Text('View Services'),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => Services()),
                        );
                      },
                    ),
                     Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(8))
                       , child: ListTile(
                           leading: Icon(MdiIcons.tshirtCrew,color: Colors.white),
                      title: Text('View Products', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => Products()),
                        );
                      },
                        ),
                      ),
                    ),
                 
                  ],
                )),
              Column(
                children: <Widget>[
                  Expanded(
                    child: Consumer<ShopProvider>(
                      builder: (context, model, child) {
                        Widget content =
                            Center(child: Text('Error fetching data. Check your Internet connection'));

                        if (model.isLoading) {
                       
                          content = Center(child: CircularProgressIndicator());
                        } else if ((model.products.length == 0 &&
                            !model.isLoading)) {
                          content =
                              Center(child: Text('No products added yet'));
                        } else if ((model.products.length > 0 &&
                            !model.isLoading)) {
                          content = new RefreshIndicator(
                            onRefresh: _refresh,
                            child: GridView.builder(
                              padding: EdgeInsets.all(15),
                           
                              physics: AlwaysScrollableScrollPhysics(),
                              gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                    4 ,mainAxisSpacing: 15,crossAxisSpacing: 15,childAspectRatio: 0.7
),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: model.products.length,
                              itemBuilder: (BuildContext _context, int index) {
                                if (index < model.products.length) {
                                  return ProductsCard(
                                      product: model.products[index],
                                      index: index);
                                } else {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 32.0),
                                    child: Center(
                                        child: Text('nothing more to load!')),
                                  );
                                }
                              },
                            ),
                          );
                        }

                        return content;
                      },))])
          ],
        ));
  }
}
