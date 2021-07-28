import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class ShopProvider extends ChangeNotifier {

  String baseurl = "https://victorycakes.co.ke";


  String formatter(String url) {
    return baseurl + url;
  }

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }


 Future<dynamic> postProduct(String productName, String price, String serviceType, PlatformFile image) async {

   var url = formatter('/laundry/postProduct');
    var uri = Uri.parse(url);
    bool hasError = true;
    String message = 'Something went wrong';

   if (image != null) {
      var request = new http.MultipartRequest('POST', uri);
      request.headers.addAll({
        "Content-type": "multipart/form-data",
      });

      request.fields['productName'] = productName;
      request.fields['price'] = price;
      request.fields['serviceType'] = serviceType;
    
    
      print('IMAGE IS HERE');
     

      var multipartFile = new http.MultipartFile("image", image.readStream, image.size,
        filename: image.name);

      request.files.add(multipartFile);
      var response = await request.send();

      if (response.statusCode == 200) {
        print("Image Uploaded");
        hasError = false;
      } else {
        print("Upload Failed");
        hasError = true;
        message = "Upload failed";
      }
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    } else {
     hasError = true;
     message = "No image Selected";
    }

    return {'success': !hasError, 'message': message};


}
 

  Future<dynamic> postService(String serviceName, PlatformFile image) async {

   var url = formatter('/laundry/postService');
    var uri = Uri.parse(url);
    bool hasError = true;
    String message = 'Something went wrong';

   if (image != null) {
      var request = new http.MultipartRequest('POST', uri);
      request.headers.addAll({
        "Content-type": "multipart/form-data",
      });

      request.fields['serviceName'] = serviceName;
    
   print('IMAGE IS HERE');
     

      var multipartFile = new http.MultipartFile("image", image.readStream, image.size,
        filename: image.name);

      request.files.add(multipartFile);
      var response = await request.send();

      if (response.statusCode == 200) {
        print("Image Uploaded");
        hasError = false;
      } else {
        print("Upload Failed");
        hasError = true;
        message = "Upload failed";
      }
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    } else {
     hasError = true;
     message = "No image Selected";
    }

    return {'success': !hasError, 'message': message};


}

}