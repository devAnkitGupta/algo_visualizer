import 'dart:collection';
import 'package:algo_visualizer/algos/abstract/mat_algos.dart';
import 'package:algo_visualizer/consts/app_constants.dart';
import 'package:algo_visualizer/model/block.dart';
import 'package:flutter/material.dart';

class BfsNotifier extends MatAlgos {
  BfsNotifier() {
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
    isDfsRunning = ValueNotifier(false);
  }

  @override
  void runAlgo() {
    isDfsRunning.value = true;
    _bfs(0, 0);
    isDfsRunning.value = false;
  }

  void _bfs(
    int row,
    int column,
  ) async {
    DoubleLinkedQueue<Block> queue = DoubleLinkedQueue();
    queue.addFirst(blocksLiveData[row][column].value);
    while (queue.isNotEmpty) {
      Block data = queue.removeLast();
      if (data.isanimated) {
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
          final block = blocksLiveData[adjX][adjY].value;
          if (_isValid(data)) {
            queue.addFirst(data);
          }
          // if (!blocksLiveData[adjX][adjY].value.isanimated) {
          //   queue.addFirst(blocksLiveData[adjX][adjY].value);
          // }
        }
      }
    }
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
