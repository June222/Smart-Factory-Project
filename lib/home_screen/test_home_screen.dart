// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graduation_assignment/data/function_data/function_data.dart';
import 'package:graduation_assignment/home_screen/develop_screen/develop_intro_page.dart';
import 'package:graduation_assignment/home_screen/service_intro_screen/service_intro_page.dart';
import 'package:graduation_assignment/data/string_data/string_data.dart';
import 'package:graduation_assignment/home_screen/team_screen/team_intro_page.dart';
import 'package:graduation_assignment/home_screen/using_serivce_screen/using_service_screen.dart';

import 'widget/test_custom_card.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  late ScrollController _controller;

  bool first_selected = false;
  bool second_selected = true;
  bool third_selected = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: 275);
    _controller.addListener(() {
      var offset = _controller.offset;
      var firstOffset = 100;
      var secondOffset = 400;

      // log("${_controller.offset}");

      bool onFirstOffset() => !first_selected && offset < firstOffset;
      bool onSecondOffset() =>
          !second_selected && firstOffset <= offset && offset < secondOffset;
      bool onThirdOffset() => !third_selected && secondOffset <= offset;

      if (onFirstOffset()) {
        setState(() {
          clearSelect();
          first_selected = true;
        });
        log("first selected");
      } else if (onSecondOffset()) {
        setState(() {
          clearSelect();
          second_selected = true;
        });
        log("second selected");
      } else if (onThirdOffset()) {
        setState(() {
          clearSelect();
          third_selected = true;
        });
        log("third selected");
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void pushToDevelopPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DevelopIntroductionPage(),
      ),
    );
  }

  void pushToTeamPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TeamIntroductionPage(),
      ),
    );
  }

  void pushToServiceIntroPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ServiceIntroductionPage(),
      ),
    );
  }

  void pushToUsingServicePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsingServicePage(),
      ),
    );
  }

  void clearSelect() {
    first_selected = false;
    second_selected = false;
    third_selected = false;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: introductionAppBar("Steel See"),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
                child: Text(
              "\"작은 문제 하나하나를 찾아가는 것이\"",
              style: TextStyle(fontSize: 20),
            )),
            const Text(
              "큰 사고를 예방합니다.",
              // style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            // const Spacer(),
            SizedBox(
              height: height / 2.5,
              child: ListView(
                controller: _controller,
                clipBehavior: Clip.none,
                dragStartBehavior: DragStartBehavior.down,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: [
                  TestCustomCard(
                    name: coding_image,
                    selected: first_selected,
                    buttonText: "개발 목적",
                    onTap: pushToDevelopPage,
                  ),
                  TestCustomCard(
                    name: jadu_image,
                    selected: second_selected,
                    buttonText: "TEAM 소개",
                    onTap: pushToTeamPage,
                  ),
                  TestCustomCard(
                    name: service_image,
                    selected: third_selected,
                    buttonText: "서비스 소개",
                    onTap: pushToServiceIntroPage,
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Text("\"우리가 자는 동안에도 Steel See 합니다.\""),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: pushToUsingServicePage,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                  color: const Color.fromRGBO(23, 38, 59, 1),
                ),
                width: width * 0.75,
                height: 50,
                child: Text(
                  "서비스 이용하기",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
