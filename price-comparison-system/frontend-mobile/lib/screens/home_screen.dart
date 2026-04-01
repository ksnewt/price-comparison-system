/* * KALEB NEWTON | March 2026
 * FILE: lib/screens/home_screen.dart
 * * --- THE MAIN INTERFACE & STATE ENGINE ---
 * This is the primary UI layer. It manages the "State" (The Cart) and 
 * renders the visual elements the user sees.
 * * ENGINEERING HIGHLIGHT: 
 * 1. FutureBuilder: Automatically handles Loading/Data/Error states.
 * 2. LIFO Logic: Implements a Stack-based cart system for precise price tracking.
 * 3. Encapsulated UI: Owns all Rows, Columns, and Theme styling for this view.
 */

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- MY APP'S MEMORY ---
  // Keeping track of exactly what the user puts in the cart, not just a random number.
  List<Product> cart = [];
  double totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Here are my custom colors keeping the dark theme alive!
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Column(
          children: [
            // --- THE STATUS DASHBOARD ---
            // Pinning this to the top so the user always knows how much they are spending
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Cart: ${cart.length} items | Total: \$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // --- THE DYNAMIC LIST FACTORY (Level 9) ---
            // Using an Expanded widget so the list takes up all the available middle space.
            Expanded(
              child: FutureBuilder<List<Product>>(
                // Telling the app to go ask the "Python Bot" (our service) for the data.
                future: ProductService().fetchProducts(),
                builder: (context, snapshot) {
                  // If the internet is being slow, show a spinning wheel so the app doesn't look frozen.
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // If the python bot or JSON file crashes, print exact reason on screen
                  if (snapshot.hasError) {
                    print("DEBUG ERROR: ${snapshot.error}");
                    return Center(
                      child: Text(
                        'ERROR: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  // Data arrived safely
                  if (snapshot.hasData) {
                    final products = snapshot.data!;

                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        // Grabbing the specific product for whatever row we are currently building.
                        final item = products[index];

                        return Card(
                          color: Colors.blueGrey[800],
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          child: ListTile(
                            // 1. The visual pop: pulling the specific icon for this item.
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Icon(item.icon, color: Colors.white),
                            ),

                            // 2. Displaying the actual name and formatted price from our database.
                            title: Text(
                              item.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.blue.shade100),
                            ),

                            // 3. The interactive buttons on the right side of the card.
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.greenAccent,
                                  ),
                                  onPressed: () {
                                    // Pushing this specific item into the cart array and doing the math.
                                    setState(() {
                                      cart.add(item);
                                      totalPrice += item.price;
                                    });
                                  },
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    // Teleportation time: Sending the user to the details screen and passing the exact item info along.
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          productName: item.name,
                                          productPrice: item.price,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Details'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  // Just in case something breaks... prevent a red screen of death
                  return const Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 10,
            ), // Making a little bit room before the bottom buttons.
            // --- BOTTOM MANAGEMENT BUTTONS ---
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Guard Clause: Gotta make sure the app doesn't crash if they try to remove an item from an empty cart!
                      if (cart.isNotEmpty) {
                        setState(() {
                          // LIFO Logic in action: We pop the absolute last item they added off the stack...
                          Product removedItem = cart.removeLast();
                          // ...and subtract its exact price. No more guessing with flat $50 deductions!
                          totalPrice -= removedItem.price;
                        });
                      } else {
                        // SnackBar feedback so they know why the button isn't doing anything.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Your cart is already empty!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.remove_shopping_cart, size: 18),
                    label: const Text('Remove'),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () {
                      // The nuclear option: clear the whole array and reset the math.
                      setState(() {
                        cart.clear();
                        totalPrice = 0.0;
                      });
                    },
                    child: const Text('Empty Cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
