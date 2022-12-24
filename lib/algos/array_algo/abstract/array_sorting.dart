import 'package:algo_visualizer/consts/app_constants.dart';
import 'package:algo_visualizer/model/bar.dart';
import 'package:flutter/widgets.dart';

abstract class ArraySortingAlgo {
  late List<ValueNotifier<Bar>> barLiveData;
  late ValueNotifier<bool> isAlgoRunning;
  int size = Constants.arraySortingSize;
  void runAlgo();
}
