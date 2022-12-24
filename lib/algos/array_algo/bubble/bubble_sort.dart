import 'dart:math';

import 'package:algo_visualizer/algos/array_algo/abstract/array_sorting.dart';
import 'package:algo_visualizer/consts/app_constants.dart';
import 'package:algo_visualizer/model/bar.dart';
import 'package:flutter/cupertino.dart';

class BubbleSort extends ArraySortingAlgo {
  final random = Random();
  List<Bar> list = [];
  BubbleSort() {
    list = List.generate(
      Constants.arraySortingSize,
      (index) => Bar(
        isanimated: false,
        row: index,
        height: random.nextInt(200) + 50,
      ),
    );
    barLiveData = ValueNotifier(list);
    isAlgoRunning = ValueNotifier(false);
  }

  @override
  void runAlgo() {
    _startBubbleSort();
  }

  void _startBubbleSort() async {
    isAlgoRunning.value = true;
    for (int i = 0; i < list.length - 1; i++) {
      for (int j = 0; j < list.length - 1; j++) {
        if (list[j].height > list[j + 1].height) {
          Bar temp = Bar.clone(data: list[j]);
          list[j] = Bar.clone(data: list[j + 1]);
          list[j + 1] = temp;
          list.last.isanimated = true;
          barLiveData.value = [...list];
          await Future.delayed(const Duration(milliseconds: 20));
        }
      }
    }
    isAlgoRunning.value = false;
  }
}
