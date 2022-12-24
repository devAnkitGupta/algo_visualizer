import 'package:algo_visualizer/algos/array_algo/abstract/array_sorting.dart';
import 'package:flutter/material.dart';

class ArraySortingVisualizer extends StatelessWidget {
  final ArraySortingAlgo algo;
  const ArraySortingVisualizer({super.key, required this.algo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 600,
          width: 1000,
          child: ListView.builder(
            itemCount: algo.barLiveData.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 0.5),
                    width: 10,
                    height: algo.barLiveData[index].value.height.toDouble(),
                    child: Text(
                      index.toString(),
                      style: const TextStyle(color: Colors.black, fontSize: 4),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: algo.isAlgoRunning,
          builder: (context, snapshot, _) {
            return FloatingActionButton(
              onPressed: snapshot
                  ? () {}
                  : () {
                      algo.runAlgo();
                    },
              child: const Icon(Icons.start),
            );
          },
        ),
      ],
    );
  }
}
