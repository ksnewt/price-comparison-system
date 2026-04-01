# 🛍️ Price Comparison App (V1)

A professional Flutter application demonstrating **Layered Architecture**, **Asynchronous State Management**, and **Scalable Logic**.

Created by **Kaleb Newton** | March 2026

## 📁 Project Structure & Raw Code Map

To maintain a "Single Source of Truth" and keep the code scalable, the project is organized into a modular architecture. Click the file names below to view the raw implementation:

- **[main.dart](lib/main.dart)**: **The App Entry Point.** Handles environment initialization and hands off control to the UI layers.
- **[models/product.dart](lib/models/product.dart)**: **The Data Blueprint.** Defines the `Product` class and the `fromJson` factory for future backend communication.
- **[services/product_service.dart](lib/services/product_service.dart)**: **The API Service Layer.** Manages asynchronous logic for fetching data from the simulated Python backend.
- **[screens/home_screen.dart](lib/screens/home_screen.dart)**: **The State & UI Engine.** Manages the shopping cart, LIFO stack logic, and real-time UI updates.
- **[screens/details_screen.dart](lib/screens/details_screen.dart)**: **The Navigation Destination.** Renders dynamic product data passed through the navigator.

## 🚀 Key Engineering Features

- **Asynchronous Data Flow (Level 9):** Utilizes a `FutureBuilder` to intelligently manage **Loading**, **Data**, and **Error** states during network simulation.
- **LIFO (Last-In, First-Out) Cart Logic:** Implements a stack-based cart system where the "Remove" button intelligently pops the most recent item to ensure total price accuracy.
- **JSON Serialization Ready:** Built with a `factory Product.fromJson` constructor to act as the "Translator" for future SQL/Python integration.
- **Defensive Programming:** Integrated Guard Clauses (`if (cart.isNotEmpty)`) and SnackBars to prevent state errors and provide clear user feedback.

## 🔨 Skills Demonstrated

- **System Architecture:** Organizing code into Models, Services, and Screens to maintain "Separation of Concerns."
- **Asynchronous Logic:** Mastering `async`, `await`, and `Future` for non-blocking data operations.
- **Data Structures:** Expert manipulation of Lists and Stacks for complex state tracking.

## 💻 Code Highlight: The LIFO Stack Logic

This snippet demonstrates the logic used to manage the cart state precisely, ensuring we subtract the exact price of the last item added:

```dart
onPressed: () {
  // Guard Clause to prevent crash
  if (cart.isNotEmpty) {
    setState(() {
      // Pop the last item off the stack (LIFO)
      Product removedItem = cart.removeLast();

      // Dynamic Price Adjustment
      totalPrice -= removedItem.price;
    });
  }
}
```
