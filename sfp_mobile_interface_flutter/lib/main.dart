import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/screens/date_time_page.dart';
import 'package:sfp_mobile_interface_flutter/screens/home_page.dart';
import 'package:sfp_mobile_interface_flutter/screens/login_page.dart';
import 'package:sfp_mobile_interface_flutter/screens/real_time_image_page.dart';
import 'package:sfp_mobile_interface_flutter/screens/real_time_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RealTimePage.routeName,
      routes: {
        '/': (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
        RealTimePage.routeName: (context) => const RealTimePage(),
        RealTimeImagePage.routeName: (context) => const RealTimeImagePage(),
        DateTimePage.routeName: (context) => const DateTimePage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
