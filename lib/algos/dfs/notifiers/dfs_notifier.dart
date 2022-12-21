import 'dart:collection';

import 'package:algo_visualizer/model/block.dart';
import 'package:flutter/cupertino.dart';

class DfsNotifier {
  late ValueNotifier<List<List<Block>>> blocksNotifier;
  late List<List<ValueNotifier<Block>>> blocksLiveData;
  static List<int> dRow = [0, 1, 0, -1];
  static List<int> dCol = [-1, 0, 1, 0];
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

  void runDfs() async {
    _dfs(0, 0);
  }

  void _dfs(
    int row,
    int column,
  ) async {
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
        if (!(data.row < 0) ||
            !(data.column < 0) ||
            !(data.row >= 20) ||
            !(data.column >= 20)) {
          stack.addFirst(blocksLiveData[adjX][adjY].value);
        }
      }
    }
  }

  bool _isValid(Block data) {
    if (data.row < 0 ||
        data.column < 0 ||
        data.row >= 20 ||
        data.column >= 20) {
      return false;
    }
    if (data.isanimated) return false;
    return true;
  }
}
