import 'package:myapp/ui/views/home/controller/home_controller.dart';

class WelcomeController {
  static final WelcomeController instance = WelcomeController();

  void init() async {
    HomeController.instance.init();
  }
}
