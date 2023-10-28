import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfp_mobile_interface_flutter/data/theme_data.dart';
import 'package:sfp_mobile_interface_flutter/routers/main_page.dart';
import 'package:sfp_mobile_interface_flutter/screens/login_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginPage.routeName,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginPage(),
        MainPage.routeName: (context) => const MainPage(),
      },
      title: 'Smart Factory',
      theme: themeData,
    );
  }
}
