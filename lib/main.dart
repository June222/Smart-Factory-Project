import 'package:flutter/material.dart';
import 'package:graduation_assignment/home_screen/test_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        // textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
        useMaterial3: true,
        colorScheme: const ColorScheme(
          background: Colors.black,
          onBackground: Color.fromRGBO(23, 38, 59, 1),
          brightness: Brightness.dark,
          primary: Colors.white,
          onPrimary: Colors.white, //RGB(96, 147, 153)
          secondary: Color.fromRGBO(177, 255, 245, 1),
          onSecondary: Color.fromRGBO(23, 38, 59, 1),
          error: Colors.red,
          onError: Colors.yellow,
          surface: Colors.black, //
          onSurface: Colors.white,
          // RGB(73, 178, 254)
          onSecondaryContainer: Color.fromRGBO(73, 178, 254, 1),
        ),
      ),
      home: const TestHome(),
    );
  }
}
