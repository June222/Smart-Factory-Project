// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:graduation_assignment/data/function_data/function_data.dart';
import 'package:graduation_assignment/data/string_data/string_data.dart';
import 'package:graduation_assignment/data/widget_data/widget_data.dart';
import 'package:graduation_assignment/home_screen/team_screen/widget/circle_widget.dart';
import 'package:graduation_assignment/home_screen/team_screen/widget/introduction_widget.dart';

class TeamIntroductionPage extends StatefulWidget {
  const TeamIntroductionPage({super.key});

  @override
  State<TeamIntroductionPage> createState() => _TeamIntroductionPageState();
}

class _TeamIntroductionPageState extends State<TeamIntroductionPage> {
  bool jw_selected = false;
  bool js_selected = false;
  bool tk_selected = false;

  void clear_select() {
    jw_selected = false;
    js_selected = false;
    tk_selected = false;
  }

  void select_jw() {
    setState(() {
      clear_select();
      jw_selected = true;
    });
  }

  void select_js() {
    setState(() {
      clear_select();
      js_selected = true;
    });
  }

  void select_tk() {
    setState(() {
      clear_select();
      tk_selected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: introductionAppBar("TEAM 소개"),
      body: SafeArea(
          child: Padding(
        padding: introductionPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(jadu_image),
            Text(
              "안녕하세요!",
              style: headLineStyle,
            ),
            const SizedBox(height: 20),
            Text(
              "철강 불량 검출 서비스 \"Steel See\" 개발 및 운영을 담당하는 자두과자 입니다.",
              style: boldStyle,
            ),
            Text(
              "저희는 AI 딥러닝 모델을 활용하여 사람의 눈보다 더 정확하고 빠르게 철강 표면의 불량을 찾고 분류하는 서비스를 개발하고 배포하고 있습니다.",
              style: boldStyle,
            ),
            const SizedBox(height: 30),
            Offstage(
              offstage: jw_selected || js_selected || tk_selected,
              child: const Center(child: Text("눌러보세요")),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleWidget(
                  name: "강준우",
                  asset: jw_image,
                  selected: jw_selected,
                  onTap: select_jw,
                ),
                CircleWidget(
                  name: "김태경",
                  asset: tk_image,
                  selected: tk_selected,
                  onTap: select_tk,
                ),
                CircleWidget(
                  name: "여지수",
                  asset: js_image,
                  selected: js_selected,
                  onTap: select_js,
                ),
              ],
            ),
            const SizedBox(height: 30),
            IntroductionWidget(
              offstage: jw_selected,
              text: "자두과자 팀장님!\nSteel See App 프론트엔드를 담당한 멤버에요.",
            ),
            IntroductionWidget(
              offstage: tk_selected,
              text: "AI 딥러닝 모델을 개발하고\n데이터베이스를 설계하고 구축한 멤버에요.",
            ),
            IntroductionWidget(
              offstage: js_selected,
              text:
                  "AI 딥러닝 모델을 개발하고 Rest API를 제작한 멤버에요.\n그리고 Steel See App 디자인을 담당했어요.",
            ),
          ],
        ),
      )),
    );
  }
}
