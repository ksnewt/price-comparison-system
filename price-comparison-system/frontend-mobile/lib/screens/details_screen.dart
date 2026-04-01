/* * KALEB NEWTON
 * 19 March 2026
 * * PROJECT: Price Comparison App (V1)
 * FILE: details_screen.dart
 * * DESCRIPTION:
 * This screen acts as the dynamic "Destination" for the product catalog.
 * It demonstrates deep-link navigation and data encapsulation by 
 * receiving a 'Product' object and rendering its specific attributes.
 * * USAGE:
 * 1. This file is pushed onto the Navigator stack from 'home_screen.dart'.
 * 2. It requires 'productName' and 'productPrice' as required constructor 
 * parameters to initialize the UI state.
 */

import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  // Defining variables that the screen needs to recieve
  final String productName;
  final double productPrice;

  // Add them to the "Constuctor" (Envelope)
  const DetailsScreen({
    super.key,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              productName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 59, 54, 208),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: \$${productPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, color: Colors.tealAccent),
            ),
          ],
        ),
      ),
    );
  }
}
