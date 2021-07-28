import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/providers/auth_provider.dart';
import 'package:laundry_admin/views/dashboard/dashboard.dart';
import 'package:laundry_admin/widget/password_form_field.dart';
import 'package:laundry_admin/widget/text_input_decoration.dart';
import 'package:provider/provider.dart';

class LoginDesktop extends StatefulWidget {
  @override
  _LoginDesktopState createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool loading = false;

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
    _username.dispose();
    _focusNodes.forEach((node) {
      node.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget _userSubmitButton() {
      return InkWell(
          onTap: () {
            if (_formKey.currentState.validate()) {
              Map<String, String> data = {
                "username": _username.text,
                "password": _password.text
              };
              setState(() {
                loading = true;
              });

              print(data);
              Provider.of<AuthProvider>(context, listen: false)
                  .postLogin("/laundry/admin/admin-login", data)
                  .then((response) => {
                        if (response['success'])
                          {
                            setState(() {
                              loading = false;
                            }),
                            Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Dashboard()),
                              (Route<dynamic> route) => false,
                            )
                          }
                        else
                          {
                            setState(() {
                              loading = false;
                            }),
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(response['message']),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'))
                                    ],
                                  );
                                })
                          }
                      })
                  .catchError((error) {
                setState(() {
                  loading = false;
                });
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                            'An Error occurred.\nCheck your Internet connection then try again'),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'))
                        ],
                      );
                    });
              });
            }
          },
          child: Container(
            width: 80,
            padding: EdgeInsets.symmetric(vertical: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.deepPurple, Colors.deepPurple[700]]),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            child: Text(
              'Login',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ));
    }

    Widget _formWidget({double height}) {
      return Form(
        key: _formKey,
        child: Container(
          height: height / 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400, maxHeight: 60),
                child: TextFormField(
                  focusNode: _focusNodes[0],
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1.color),
                  keyboardType: TextInputType.emailAddress,
                  controller: _username,
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Username',
                    fillColor: Theme.of(context).cardColor,
                    labelStyle: TextStyle(
                        color: _focusNodes[0].hasFocus
                            ? Theme.of(context).accentColor
                            : Colors.grey),
                    hintStyle: TextStyle(
                        color: _focusNodes[0].hasFocus
                            ? Theme.of(context).accentColor
                            : Colors.grey),
                    prefixIcon: Icon(
                      Icons.person,
                      color: _focusNodes[0].hasFocus
                          ? Theme.of(context).accentColor
                          : Colors.grey,
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter username' : null,
                ),
              ),
              SizedBox(height: 15.0),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400, maxHeight: 60),
                  child: PasswordFormField(
                    focusNode: _focusNodes[1],
                    controller: _password,
                  )),
              SizedBox(height: 30),
              loading ? CircularProgressIndicator() : _userSubmitButton(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    height: height,
                    width: width / 2,
                    child: Image.asset(
                      'assets/images/login_background.jpg',
                      fit: BoxFit.cover,
                    )),
                Container(
                    height: height / 1.5,
                    width: width / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Admin Login',
                                  style: TextStyle(fontSize: 26),
                                ),
                              ),
                              SizedBox(height: 30),
                              _formWidget(height: height)
                            ],
                          ),
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
