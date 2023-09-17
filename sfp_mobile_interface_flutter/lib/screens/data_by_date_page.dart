
// import 'dart:math';
import 'dart:developer';

import 'package:flutter/material.dart';

class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key});

  static const String routeName = "/homepage/datetime";

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  late FocusNode _focusNode;

  final int settingRate = 3;
  String? selectedValue = "All";

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void showDateTimePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    selectedDate.then(
      (value) => log(value.toString()),
    );
    // selectedDate.then((value) => null)
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: settingRate,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("날짜:"),
                          Expanded(
                            child: TextField(
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                hintText: "YYYY-MM-DD",
                                suffixIcon: IconButton(
                                  onPressed: showDateTimePickerPop,
                                  icon:
                                      const Icon(Icons.calendar_month_rounded),
                                ),
                              ),

                              // scrollPadding: const EdgeInsets.all(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: settingRate,
                      child: Row(
                        children: [
                          const Text("결함 클래스:"),
                          Expanded(
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectedValue,
                              iconSize: 30,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue;
                                });
                              },
                              items: [
                                "All",
                                "1",
                                "2",
                                "3"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  alignment: Alignment.center,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: settingRate,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("검색하기"),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        "날짜",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "개수",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(child: Text("")),
                  ],
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "2023-09-14",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text(
                                        "150 / 150",
                                        textAlign: TextAlign.center,
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.arrow_downward_rounded),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "자세히 보기",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Container(width: width,child: Row(children: []),)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
