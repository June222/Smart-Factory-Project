// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
import 'package:sfp_mobile_interface_flutter/routers/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String routeName = '/';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loadingBarOffstage = false;

  void loginPressed() async {
    setState(() {
      loadingBarOffstage = true;
    });
    await Future.delayed(oneSec);
    setState(() {
      loadingBarOffstage = false;
    });
    Navigator.pushReplacementNamed(context, MainPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                "SMART FACTORY",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const SizedBox(height: 10),
              SizedBox(
                height: height / 10,
                width: width / 1.5,
                child: ElevatedButton(
                  onPressed: loginPressed,
                  child: loadingBarOffstage
                      ? Visibility(
                          visible: loadingBarOffstage,
                          child: const CircularProgressIndicator(),
                        )
                      : const Text("관리자 모드로 시작"),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
