import 'dart:collection';

import 'package:algo_visualizer/algos/graph_algo/abstract/graph_algos.dart';
import 'package:algo_visualizer/consts/app_constants.dart';
import 'package:algo_visualizer/model/block.dart';
import 'package:flutter/cupertino.dart';

class DfsNotifier extends GraphAlgos {
  DfsNotifier() {
    blocksLiveData = List.generate(
      Constants.matSize,
      (index) => List.generate(
        Constants.matSize,
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
    isAlgoRunning = ValueNotifier(false);
  }

  @override
  void runAlgo() async {
    _dfs(0, 0);
  }

  void _dfs(
    int row,
    int column,
  ) async {
    isAlgoRunning.value = true;
    DoubleLinkedQueue<Block> stack = DoubleLinkedQueue();
    stack.addFirst(blocksLiveData[row][column].value);
    while (stack.isNotEmpty) {
      Block data = stack.removeFirst();
      if (!_isValid(data)) {
        continue;
      }
      await Future.delayed(const Duration(milliseconds: 200));
      blocksLiveData[data.row][data.column].value = Block(
        isCanCross: true,
        isanimated: true,
        row: data.row,
        column: data.column,
      );

      for (int i = 0; i < 4; i++) {
        int adjX = data.row + dRow[i];
        int adjY = data.column + dCol[i];
        final xInRange = _isInRange(adjX);
        final yInRange = _isInRange(adjY);
        if (xInRange && yInRange) {
          stack.addFirst(blocksLiveData[adjX][adjY].value);
        }
      }
    }
    isAlgoRunning.value = false;
  }

  bool _isInRange(int index) {
    if (index < 0 || index >= Constants.matSize) return false;
    return true;
  }

  bool _isValid(Block data) {
    if (data.row < 0 ||
        data.column < 0 ||
        data.row >= Constants.matSize ||
        data.column >= Constants.matSize) {
      return false;
    }
    if (data.isanimated) return false;
    return true;
  }
}
