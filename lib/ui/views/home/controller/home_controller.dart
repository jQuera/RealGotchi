import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/ui/common/controllers/main_controller.dart';
import 'package:myapp/ui/common/repository/tasks_repository.dart';
import 'package:myapp/ui/views/home/home_page.dart';
import 'package:o3d/o3d.dart';
import 'package:rxdart/rxdart.dart';

class HomeController {
  static final HomeController instance = HomeController();
  final TasksRepository tasksRepository = TasksRepository.instance;

  O3DController modelController = O3DController();

  int currentPage = 1;
  final StreamController<int> _currentPageStream = BehaviorSubject.seeded(1);
  Stream<int> get currentPageStream => _currentPageStream.stream;

  void init() async {
    await Future.delayed(Durations.extralong4);
    tasksRepository.init();
    MainController.instance.getCurrentState()?.push(MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }

  void changeCurrentPage(int value) {
    currentPage = value;
    _currentPageStream.add(currentPage);
  }
}
