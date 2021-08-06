import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:laundry_admin/views/dashboard/view_users/single_user.dart';
import 'package:laundry_admin/views/login/login.dart';


class UsersDesktop extends StatefulWidget {
  @override
  _UsersDesktopState createState() => _UsersDesktopState();
}

class _UsersDesktopState extends State<UsersDesktop> {



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
  

    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            automaticallyImplyLeading: true,
            title: Text('Users'),
            ),
        body: SingleChildScrollView(
          child: Column(children: [
           
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  ListTile(
                      title: Row(
                    children: [
                      SizedBox(width: 60),
                      Text('First Name',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Spacer(),
                      Text('Last Name',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Spacer(),
                      Text('Email',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Spacer(),
                      Text('Residence',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Spacer(),
                      SizedBox(width: 60)
                    ],
                  )),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Colors.grey[300]))),
                        child: ListTile(
                          leading: CircleAvatar(
                              child: Center(
                            child: Icon(Icons.person, color: Colors.white),
                          )),
                          title: Row(children: [
                            ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight:25, maxWidth: 200),
                                child: Text('Timothy')),
                            SizedBox(width: 70),
                            Spacer(),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxHeight:25, maxWidth: 200),
                              child: Text(
                                'Ndichu',
                              ),
                            ),
                            Spacer(),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxHeight:25, maxWidth: 200),
                              child: Text(
                                'timndichu@gmail.com',
                              ),
                            ),
                            Spacer(),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(maxHeight:25, maxWidth: 200),
                              child: Text(
                                'Ngong',
                              ),
                            ),
                            Spacer(),
                            SizedBox(width: 60)
                          ]),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_forward_outlined),
                            onPressed: () {
                               Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => SingleUser()));
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                
                ]),
              ),
            ),
            SizedBox(height: 100)
          ]),
        ));
  }
}
