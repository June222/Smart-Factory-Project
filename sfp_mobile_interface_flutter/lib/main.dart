import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/screens/data_by_date_detail_page.dart';
import 'package:sfp_mobile_interface_flutter/screens/data_by_date_page.dart';
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
      initialRoute: DateTimePage.routeName,
      routes: {
        '/': (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
        RealTimePage.routeName: (context) => const RealTimePage(),
        RealTimeImagePage.routeName: (context) => const RealTimeImagePage(),
        DateTimePage.routeName: (context) => const DateTimePage(),
        DataByDateDetailPage.routeName: (context) =>
            const DataByDateDetailPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.yellow),
        useMaterial3: true,
      ),
    );
  }
}
