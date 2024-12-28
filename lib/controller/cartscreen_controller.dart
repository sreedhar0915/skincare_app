import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:skincare_app/model/product_model.dart';
import 'package:sqflite/sqflite.dart';

class CartController with ChangeNotifier {
  static late Database database;
  dynamic totalcartvalue = 0.00;
  List<Map> storedProducts = [];

  static Future initDb() async {
    database = await openDatabase("cartdb7.db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Cart (id INTEGER PRIMARY KEY, name TEXT, qty INTEGER, Amount REAL, image TEXT)');
    });
  }

  Future getAllProducts() async {
    try {
      storedProducts = await database.rawQuery('SELECT * FROM Cart');
      calculatetotalamount();
    } catch (e) {
      log("Error fetching products: $e");
    }
    notifyListeners();
  }

  Future addProduct(Productscreenmodel selectedProduct) async {
    bool alreadyCart = storedProducts.any(
      (element) => selectedProduct.id == element["productId"],
    );

    if (alreadyCart) {
      log("Product already in cart");
    } else {
      try {
        await database.rawInsert(
            'INSERT INTO Cart(name, qty, Amount, image) VALUES(?, ?, ?, ?)', [
          selectedProduct.title,
          1,
          selectedProduct.price,
          selectedProduct.image
        ]);
        log("Product added to cart");
      } catch (e) {
        log("Error adding product: $e");
      }
    }
    notifyListeners();
  }

  incrementQty({required int qty, required int id}) async {
    try {
      await database
          .rawUpdate('UPDATE Cart SET qty = ? WHERE id = ?', [++qty, id]);
      storedProducts.firstWhere((item) => item['id'] == id)['qty'] = qty;
      calculatetotalamount();
    } catch (e) {
      log("Error incrementing quantity: $e");
    }
    notifyListeners();
  }

  decrementQty({required int qty, required int id}) async {
    if (qty > 1) {
      try {
        await database
            .rawUpdate('UPDATE Cart SET qty = ? WHERE id = ?', [--qty, id]);
        storedProducts.firstWhere((item) => item['id'] == id)['qty'] = qty;
        calculatetotalamount();
      } catch (e) {
        log("Error decrementing quantity: $e");
      }
    }
    notifyListeners();
  }

  removeProduct(int id) async {
    try {
      await database.rawDelete('DELETE FROM Cart WHERE id = ?', [id]);
      storedProducts.removeWhere((product) => product['id'] == id);
      calculatetotalamount();
    } catch (e) {
      log("Error removing product: $e");
    }
    notifyListeners();
  }

  calculatetotalamount() {
    totalcartvalue = 0.00;
    if (storedProducts.isNotEmpty) {
      for (int i = 0; i < storedProducts.length; i++) {
        totalcartvalue +=
            (storedProducts[i]["qty"] * storedProducts[i]["Amount"]);
      }
    }
    log("Total cart value: $totalcartvalue");
  }
}
