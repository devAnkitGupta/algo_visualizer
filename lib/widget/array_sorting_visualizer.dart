import 'package:algo_visualizer/algos/array_algo/abstract/array_sorting.dart';
import 'package:algo_visualizer/model/bar.dart';
import 'package:flutter/material.dart';

class ArraySortingVisualizer extends StatelessWidget {
  final ArraySortingAlgo algo;
  const ArraySortingVisualizer({super.key, required this.algo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          width: 1000,
          child: ValueListenableBuilder<List<Bar>>(
            valueListenable: algo.barLiveData,
            builder: (context, snapshot, _) {
              return ListView.builder(
                key: UniqueKey(),
                itemCount: snapshot.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.redAccent,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 0.5),
                        width: 10,
                        height: snapshot[index].height.toDouble(),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: algo.isAlgoRunning,
          builder: (context, snapshot, _) {
            return FloatingActionButton(
              onPressed: () => algo.runAlgo(),
              child: const Icon(Icons.start),
            );
          },
        ),
      ],
    );
  }
}