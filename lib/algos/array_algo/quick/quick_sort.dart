import 'dart:math';

import 'package:algo_visualizer/algos/array_algo/abstract/array_sorting.dart';
import 'package:algo_visualizer/model/bar.dart';
import 'package:flutter/cupertino.dart';

class QuickSort extends ArraySortingAlgo {
  final random = Random();
  List<Bar> list = [];
  QuickSort() {
    list = List.generate(
      30,
      (index) => Bar(
        isanimated: false,
        row: index,
        height: random.nextInt(100) + 30,
      ),
    );
    barLiveData = ValueNotifier(list);
    isAlgoRunning = ValueNotifier(false);
  }

  @override
  void runAlgo() {
    int high = list.length - 1;
    int low = 0;
    quickSort(list, low, high);
  }

  quickSort(List<Bar> list, int low, int high) async {
    if (low < high) {
      int pi = partition(list, low, high);
      await Future.delayed(const Duration(milliseconds: 400));
      quickSort(list, low, pi - 1);
      await Future.delayed(const Duration(milliseconds: 400));
      quickSort(list, pi + 1, high);
    }
    return list;
  }

  int partition(List<Bar> list, low, high) {
    if (list.isEmpty) {
      return 0;
    }
    int pivot = list[high].height;
    int i = low - 1;
    for (int j = low; j < high; j++) {
      if (list[j].height < pivot) {
        i++;
        swap(list, i, j);
      }
    }
    swap(list, i + 1, high);
    return i + 1;
  }

  void swap(List<Bar> list, int i, int j) {
    Bar temp = Bar.clone(data: list[i]);
    list[i] = Bar.clone(data: list[j]);
    list[j] = temp;
    barLiveData.value = [...list];
  }
}
