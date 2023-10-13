import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
import 'package:sfp_mobile_interface_flutter/routers/main_page.dart';
import 'package:sfp_mobile_interface_flutter/screens/login_page.dart';

void main() {
  runApp(const MyApp());
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
        // HomePage.routeName: (context) => const HomePage(),
        // RealTimePage.routeName: (context) => const RealTimePage(),
        // RealTimeImagePage.routeName: (context) => const RealTimeImagePage(),
        // DateTimePage.routeName: (context) => const DateTimePage(),
        // DataByDateDetailPage.routeName: (context) =>
        //     const DataByDateDetailPage(),
      },
      title: 'Smart Factory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: mainColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        scrollbarTheme: const ScrollbarThemeData(
          thickness: MaterialStatePropertyAll(10),
          thumbColor: MaterialStatePropertyAll(mainColor),
          radius: Radius.circular(20),
          mainAxisMargin: 20,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
    );
  }
}
