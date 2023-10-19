import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';

class DataByDateDetailPage extends StatefulWidget {
  const DataByDateDetailPage({super.key});

  static const routeName = "homepage/databydate/detail";

  @override
  State<DataByDateDetailPage> createState() => _DataByDateDetailPageState();
}

class _DataByDateDetailPageState extends State<DataByDateDetailPage> {
  int? selectedValue = 2;
  int crossAxisCount = 2;

  void handleRadioValueChanged(
      int? value, void Function(void Function()) setState) {
    setState(() {
      selectedValue = value;
    });
    print(selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    DataByDateDetailArguments args =
        ModalRoute.of(context)!.settings.arguments as DataByDateDetailArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.date),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setStateInside) {
                      return AlertDialog(
                        title: const Text("화면 비율 설정"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RadioListTile(
                              value: 2,
                              groupValue: selectedValue,
                              title: const Text("2 by 2"),
                              onChanged: (value) => handleRadioValueChanged(
                                value,
                                setStateInside,
                              ),
                            ),
                            RadioListTile(
                              value: 1,
                              groupValue: selectedValue,
                              title: const Text("1 by 4"),
                              onChanged: (value) => handleRadioValueChanged(
                                value,
                                setStateInside,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                crossAxisCount = selectedValue!;
                              });
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.done_rounded),
                          )
                        ],
                      );
                    },
                  );
                },
              );
            },
            icon: const Icon(
              Icons.display_settings_rounded,
              size: 50,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: 4,
          padding: const EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 30,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            crossAxisCount: crossAxisCount,
          ),
          itemBuilder: (context, index) {
            return Container(
              color: Colors.red.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("A 클래스"),
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                color: Colors.amber,
                                child: const Text("파일 이름"),
                              ),
                              Container(
                                color: Colors.brown,
                                child: const Text("이미지"),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.blueGrey,
                                        child: const Text("image1.png"),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.indigo,
                                        child: Image.asset(
                                          steelImage1,
                                          width: 50,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: const Text("이미지"),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DataByDateDetailArguments {
  final String date;

  DataByDateDetailArguments(this.date);
}
