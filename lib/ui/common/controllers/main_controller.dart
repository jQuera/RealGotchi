import 'package:flutter/material.dart';

class MainController {
  static final MainController instance = MainController();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? getCurrentState() {
    return navigatorKey.currentState;
  }
}
