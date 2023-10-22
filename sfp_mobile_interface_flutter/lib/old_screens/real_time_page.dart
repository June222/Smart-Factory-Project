import 'package:flutter/material.dart';
import 'package:sfp_mobile_interface_flutter/data/data.dart';
// import 'package:sfp_mobile_interface_flutter/screens/real_time_image_page.dart';

class RealTimePage extends StatefulWidget {
  const RealTimePage({super.key});

  static const routeName = '/homepage/realtime';

  @override
  State<RealTimePage> createState() => _RealTimePageState();
}

class _RealTimePageState extends State<RealTimePage> {
  late final ScrollController _scrollController;
  late FocusNode _focusNode;

  final int imageRate = 3;
  Color? containerColor;

  @override
  void initState() {
    super.initState();
    // _controller = TextEditingController();
    // _controller.addListener(() {});
    _scrollController = ScrollController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("실시간 확인"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                // controller: _controller,
                focusNode: _focusNode,
                onTapOutside: (event) => _focusNode.unfocus(),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.search,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      "파일 이름",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      "파일 번호",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      "날짜",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: imageRate,
                    child: const Text(
                      "이미지",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return RowData(
                        imageRate: imageRate,
                        height: height,
                        width: width,
                        index: index,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RowData extends StatefulWidget {
  const RowData({
    super.key,
    required this.imageRate,
    required this.height,
    required this.width,
    required this.index,
  });

  final int imageRate;
  final int index;
  final double height;
  final double width;

  @override
  State<RowData> createState() => _RowDataState();
}

class _RowDataState extends State<RowData> {
  Color? containerColor;

  void movePageToRealTimeImagePage() {
    // Navigator.pushNamed(
    //   context,
    //   RealTimeImagePage.routeName,
    //   arguments: RealTimeImageArguments(
    //     "fileName",
    //     "000001",
    //     "2023-09-14",
    //     steelImage1,
    //   ),
    // );
  }

  void onDataTap() async {
    setState(() {
      containerColor = Colors.blue.withOpacity(0.5);
    });
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      containerColor = null;
    });

    movePageToRealTimeImagePage();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key("${widget.index}"),
      onTap: () => onDataTap(),
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          border: const Border(top: BorderSide(color: Colors.black)),
        ),
        child: Row(
          children: [
            const Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Text(
                "ABC",
                textAlign: TextAlign.center,
              ),
            ),
            const Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Text(
                "000001번",
                textAlign: TextAlign.center,
              ),
            ),
            const Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Text(
                "2023-09-14",
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: widget.imageRate,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Image.asset(
                    steelImage1,
                    height: widget.height / 5,
                    width: widget.width * .4,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
