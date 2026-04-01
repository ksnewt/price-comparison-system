/* * KALEB NEWTON | March 2026
 * FILE: lib/services/product_service.dart
 * * --- THE API SERVICE LAYER (LIVE NETWORK V1) ---
 */

import 'dart:convert';
import 'dart:io'
    show Platform; // Let's us check if it's an Android or iOS device
import 'package:http/http.dart'
    as http; // The telephone line we installed earlier
import '../models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    // 1. Defeat the Localhost Trap
    String baseUrl = 'http://127.0.0.1:8000'; // Default for iOS Simulator / Web

    try {
      if (Platform.isAndroid) {
        baseUrl =
            'http://10.0.2.2:8000'; // Special tunnel for Android Emulators
      }
    } catch (e) {
      // If Platform check fails (like on Flutter Web), it safely defaults to 127.0.0.1
    }

    final url = Uri.parse('$baseUrl/products');

    // 2. Make the Network Request
    // This physically leaves the app, hits your Python server, and waits for a response
    final response = await http.get(url);

    // 3. Check the Status Code (200 OK means the server answered happily)
    if (response.statusCode == 200) {
      // Decode the raw JSON text from the server's response body
      final List<dynamic> data = json.decode(response.body);

      // Translate into Dart Product objects using your bulletproof factory
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      // 4. Defensive Programming: Catch server crashes (like a 404 or 500 error)
      throw Exception(
        'Server failed to load data. Status Code: ${response.statusCode}',
      );
    }
  }
}
