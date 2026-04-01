/* * KALEB NEWTON | March 2026
 * FILE: lib/models/product.dart
 * * --- THE DATA BLUEPRINT ---
 * This file defines the core 'Product' object for the entire ecosystem. 
 * It acts as the "Single Source of Truth" for how product data (Names, Prices, Icons) 
 * is structured before it ever hits the screen.
 * * ENGINEERING HIGHLIGHT: 
 * Includes a 'fromJson' factory constructor. This is our "Translator" that 
 * allows the app to take raw data from a Python/SQL backend and turn it into 
 * a type-safe Dart object.
 */

import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final int iconCode;

  Product({required this.name, required this.price, required this.iconCode});

  // --- THE TRANSLATOR ---
  // This turns a JSON Map into a Product Object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'].toString(),

      // By converting the raw data to a string FIRST, double.parse() will
      // successfully extract the math value whether it had quotes or not
      price: double.parse(
        json['price'].toString(),
      ), // Safety measure to ensure number stays a double
      // JSON are 'int'... they are mapped here
      iconCode: int.parse(json['icon_code'].toString()),
    );
  }

  // A helper to convert that number into a real icon on the screen
  IconData get icon => IconData(iconCode, fontFamily: 'MaterialIcons');
}
