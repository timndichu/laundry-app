import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class AuthProvider extends ChangeNotifier {

  String baseurl = "https://victorycakes.co.ke";


  String formatter(String url) {
    return baseurl + url;
  }

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }


  Future<dynamic> postLogin(String url, Map<String, String> body) async {
    url = formatter(url);

    bool hasError = true;
    String message = 'Something went wrong';

    try {
      var response = await http
          .post(url,
              headers: {"Content-type": "application/json"},
              body: json.encode(body))
          .catchError((error) {
        return {
          'message': message + 'Check your Internet connection',
          'success': hasError
        };
      });

      final Map<String, dynamic> responseData = json.decode(response.body);
    
      if (response.statusCode == 403) {
        hasError = true;
        message = responseData['msg'];
      } else if (response.statusCode == 401 ||
          response.statusCode == 500) {
        hasError = true;
        message = responseData['msg'];
      } else if (response.statusCode == 200) {
        hasError = false;
        message = responseData['msg'];
       

       } else {
        message = 'Something went wrong, Check your network';
        _isLoading = false;
        notifyListeners();
      }

      return {'success': !hasError, 'message': message, };
    } catch (err) {
      print(err);
    }
    }
  }



