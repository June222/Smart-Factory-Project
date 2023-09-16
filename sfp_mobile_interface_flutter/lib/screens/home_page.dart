import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
import 'package:sfp_mobile_interface_flutter/screens/real_time_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/homepage';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    void onRealTimePressed() {
      Navigator.pushNamed(context, RealTimePage.routeName);
    }

    void onDateTimePressed() {
      Navigator.pushNamed(context, routeName);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("홈 화면"),
      ),
      body: SafeArea(
        child: Padding(
          padding: padding20All,
          child: Center(
            child: Column(
              children: [
                Container(
                  height: height * 0.3,
                  width: width * 0.8,
                  color: Colors.grey,
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Text("공지사항"),
                            SizedBox(width: 15),
                            Icon(Icons.arrow_circle_right_rounded)
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.circle_rounded,
                          size: 15,
                        ),
                        title: Text("8월 4주차"),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.circle_rounded,
                          size: 15,
                        ),
                        title: Text("8월 3주차"),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.circle_rounded,
                          size: 15,
                        ),
                        title: Text("8월 2주차"),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Wrap(
                  spacing: width / 20,
                  children: [
                    GestureDetector(
                      onTap: onRealTimePressed,
                      child: Container(
                        width: width / 5,
                        height: width / 5,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: Colors.blueGrey),
                        child: const Text("실시간 확인"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: width / 5,
                        height: width / 5,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: Colors.blueGrey),
                        child: const Text("날짜별 확인"),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
