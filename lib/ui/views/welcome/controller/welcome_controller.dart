import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:myapp/ui/views/home/controller/home_controller.dart';

class WelcomeController {
  static final WelcomeController instance = WelcomeController();

  void init() async {
    HomeController.instance.init();
    Intl.defaultLocale = 'es_419';
    initializeDateFormatting('es_419', null);
  }
}
