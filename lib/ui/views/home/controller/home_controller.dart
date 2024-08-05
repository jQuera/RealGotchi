import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/ui/common/controllers/main_controller.dart';
import 'package:myapp/ui/views/home/home_page.dart';
import 'package:o3d/o3d.dart';
import 'package:rxdart/rxdart.dart';

class HomeController {
  static final HomeController instance = HomeController();

  O3DController modelController = O3DController();

  int currentPage = 1;
  StreamController<int> currentPageStream = BehaviorSubject.seeded(1);
  void init() async {
    await Future.delayed(Durations.extralong4);
    MainController.instance.getCurrentState()?.push(MaterialPageRoute(
      builder: (context) {
        return const HomePage();
      },
    ));
  }

  void changeCurrentPage(int value) {
    currentPage = value;
    currentPageStream.add(currentPage);
  }
}
