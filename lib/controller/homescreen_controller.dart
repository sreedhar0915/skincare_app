import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skincare_app/model/Homescreen_model.dart';

class HomescreenController with ChangeNotifier {
  List<Homescreenmodel> shoppinglist = [];

  bool isproductloading = false;
  Future<void> getproductlist() async {
    isproductloading = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products");
    final productbycategoryurl = Uri.parse(
        "https://fakestoreapi.com/products/category/${categorylist[selectedindex]}");

    try {
      final response =
          await http.get(selectedindex == 0 ? url : productbycategoryurl);
      if (response.statusCode == 200) {
        print(response.body);
        var resobj = homescreenmodelFromJson(response.body);
        shoppinglist = resobj;
        print(shoppinglist);
      }
    } catch (e) {
      print(e);
    }
    isproductloading = false;
    notifyListeners();
  }

  List categorylist = [];
  bool isloadings = false;
  Future<void> getcategorylist() async {
    isloadings = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products/categories");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) print(response.body);
      var convertjson = jsonDecode(response.body);
      categorylist = convertjson;
      categorylist.insert(0, "Trendings"); // to show all-container
      print(categorylist);
    } catch (e) {
      print(e);
    }
    isloadings = false;
    notifyListeners();
  }

  static int selectedindex = 0;
  Oncategoryselection(int clickindex) async {
    //if (selectedindex != clickindex && !isloadings) {
    selectedindex = clickindex;
    notifyListeners();
    await getproductlist();
    // }
  }
}
