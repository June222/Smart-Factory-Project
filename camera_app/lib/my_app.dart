import 'package:camera_app/constants/color_constant.dart';
import 'package:camera_app/screens/input_name_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Factory',
      debugShowCheckedModeBanner: false, // 디버그할 때 화면에서 디버그 리본을 없앰
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        useMaterial3: true,
      ),
      home: const InputNameScreen(),
    );
  }
}
