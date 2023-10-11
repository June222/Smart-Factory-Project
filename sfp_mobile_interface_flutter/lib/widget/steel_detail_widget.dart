import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';

class SteelDataBigWidget extends StatelessWidget {
  const SteelDataBigWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: semiGreyColor,
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.fiber_manual_record_rounded,
                      color: Colors.green,
                    ),
                    SizedBox(width: 10),
                    Text("fileName.jpg"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: InteractiveViewer(
                      maxScale: 5,
                      boundaryMargin: const EdgeInsets.all(20),
                      child: Image.asset(
                        steelImage1,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              const Text("filename.jpg"),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: DataTable(
                  horizontalMargin: 1,
                  columns: const [
                    DataColumn(
                        label: Text(
                      "Capture Date",
                      style: TextStyle(color: Colors.white),
                    )),
                    DataColumn(
                        label: Text(
                      "Capture Time",
                      style: TextStyle(color: Colors.white),
                    )),
                    DataColumn(
                        label: Text(
                      "IsNormal",
                      style: TextStyle(color: Colors.white),
                    )),
                    DataColumn(
                        label: Text(
                      "Defect Label",
                      style: TextStyle(color: Colors.white),
                    )),
                  ],
                  rows: const [
                    DataRow(
                      cells: [
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: Text("2023/10/01"),
                          ),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: Text("02:00 P.M."),
                          ),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: Text("Yes"),
                          ),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: Text("X"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
