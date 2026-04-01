/* * KALEB NEWTON | March 2026
 * FILE: lib/main.dart
 * * !!! THE APP ENTRY POINT !!!
 * The starting line for the Flutter environment. This file is kept 
 * "Lean" by delegating all UI and Logic to specialized sub-folders.
 * * ARCHITECTURE OVERVIEW:
 * Following the "Layered Architecture" pattern to separate Data (Models), 
 * Logic (Services), and Presentation (Screens).
 */

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MyProfileApp());

class MyProfileApp extends StatelessWidget {
  const MyProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner:
          false, // hide debug banner to appear like a clean app for user
      home: HomeScreen(),
    );
  }
}
