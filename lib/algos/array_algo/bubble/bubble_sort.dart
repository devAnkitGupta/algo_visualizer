import 'dart:math';

import 'package:algo_visualizer/algos/array_algo/abstract/array_sorting.dart';
import 'package:algo_visualizer/model/bar.dart';
import 'package:flutter/cupertino.dart';

class BubbleSort extends ArraySortingAlgo {
  final random = Random();
  BubbleSort() {
    barLiveData = List.generate(
      50,
      (index) => ValueNotifier(
        Bar(
          isanimated: false,
          row: index,
          height: random.nextInt(100) + 100,
        ),
      ),
    );
    isAlgoRunning = ValueNotifier(false);
  }

  @override
  void runAlgo() {}

  void _startBubbleSort(){
    
  }
}
