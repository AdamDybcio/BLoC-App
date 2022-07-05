import 'package:bloc_app/presentation/screens/home_screen.dart';
import 'package:bloc_app/presentation/screens/second_screen.dart';
import 'package:bloc_app/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(color: Colors.blueAccent));
      case '/second':
        return MaterialPageRoute(
            builder: (_) => const SecondScreen(color: Colors.redAccent));
      case '/third':
        return MaterialPageRoute(
            builder: (_) => const ThirdScreen(color: Colors.greenAccent));
      default:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(color: Colors.blueAccent));
    }
  }
}
