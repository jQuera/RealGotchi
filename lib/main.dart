import 'package:flutter/material.dart';
import 'package:myapp/ui/common/services/notification_service.dart';
import 'package:myapp/ui/common/controllers/main_controller.dart';
import 'package:myapp/ui/views/welcome/pages/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: MainController.instance.navigatorKey,
      home: const WelcomePage(),
    );
  }
}
