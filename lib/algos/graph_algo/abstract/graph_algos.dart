import 'package:algo_visualizer/consts/app_constants.dart';
import 'package:algo_visualizer/model/block.dart';
import 'package:flutter/material.dart';

abstract class GraphAlgos {
  late List<List<ValueNotifier<Block>>> blocksLiveData;
  late ValueNotifier<bool> isAlgoRunning;
  List<int> dRow = Constants.dRow;
  List<int> dCol = Constants.dCol;
  void runAlgo();
}
