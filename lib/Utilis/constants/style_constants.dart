import 'package:flutter/material.dart';

class StyleConstants {
  static TextStyle heading(Color? color) {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  }

  static TextStyle viewall(Color? color) {
    return TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: color);
  }

  static TextStyle category(Color? color) {
    return TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: color);
  }

  static TextStyle checkout(Color? color) {
    return TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: color);
  }

  static const TextStyle productname =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static const TextStyle productdescription =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
  static const TextStyle productprice =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static const TextStyle details =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 30);
  static const TextStyle Size =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
}
