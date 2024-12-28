import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skincare_app/model/product_model.dart';

class ProductscreenController with ChangeNotifier {
  Productscreenmodel? product;
  bool isloading = false;

  getproductDetail(int productId) async {
    isloading = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products/$productId");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        product = Productscreenmodel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    isloading = false;
    notifyListeners();
  }
}


















// List<Homescreenmodel> Productslist = [];
//   bool isloading = false;
//   getallproducts() async {
//     isloading = true;
//     notifyListeners();
//     final url = Uri.parse("https://fakestoreapi.com/products");
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) print(response.body);
//       var convertjson = jsonDecode(response.body);
//       Productslist = convertjson;
//     } catch (e) {
//       print(e);
//     }
//     isloading = false;
//     notifyListeners();
//   }