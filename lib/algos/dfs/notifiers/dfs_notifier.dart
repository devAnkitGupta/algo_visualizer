import 'package:algo_visualizer/model/block.dart';
import 'package:flutter/cupertino.dart';

class DfsNotifier {
  late ValueNotifier<List<List<Block>>> blocksNotifier;
  late List<List<ValueNotifier<Block>>> blocksLiveData;

  DfsNotifier() {
    blocksLiveData = List.generate(
      20,
      (index) => List.generate(
        20,
        (index2) => ValueNotifier(
          Block(
            isCanCross: true,
            isanimated: false,
            row: index,
            column: index2,
          ),
        ),
      ),
    );
  }

  void startDfs() async {
    for (int i = 0; i < 20; i++) {
      for (int j = 0; j < 20; j++) {
        print('${i} , ${j}');
        Block block = blocksLiveData[i][j].value;
        blocksLiveData[i][j].value = Block(
          isCanCross: block.isCanCross,
          isanimated: true,
          row: block.row,
          column: block.column,
        );
        await Future.delayed(const Duration(milliseconds: 200));
      }
    }
  }

  void runDfs() async {}
}
