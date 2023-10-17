import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfp_mobile_interface_flutter/provider/fruit_store.dart';

class FruitPage extends ConsumerWidget {
  const FruitPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String data = ref.watch(fruitProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("data: $data"),
            ElevatedButton(
              onPressed: () {
                FruitStore fruitStore = ref.read(fruitProvider.notifier);
                fruitStore.changeData();
              },
              child: const Text("상태 변경"),
            ),
          ],
        ),
      ),
    );
  }
}
