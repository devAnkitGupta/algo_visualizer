import 'package:algo_visualizer/algos/abstract/mat_algos.dart';
import 'package:algo_visualizer/model/block.dart';
import 'package:flutter/material.dart';

class MatDancer extends StatelessWidget {
  final MatAlgos algo;

  const MatDancer({
    super.key,
    required this.algo,
  });

  @override
  Widget build(BuildContext context) {
    int gridStateLength = algo.blocksLiveData.length;
    return Column(
      children: [
        SizedBox(
          height: 500,
          width: 500,
          child: GridView.builder(
            itemCount: gridStateLength * gridStateLength,
            itemBuilder: (context, index) {
              return _buildGridItems(
                context,
                index,
                gridStateLength,
                algo,
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: algo.blocksLiveData.length,
            ),
          ),
        ),
        ValueListenableBuilder<bool>(
            valueListenable: algo.isDfsRunning,
            builder: (context, snapshot, _) {
              return FloatingActionButton(
                onPressed: snapshot
                    ? () {}
                    : () {
                        algo.runAlgo();
                      },
                child: const Icon(Icons.start),
              );
            }),
      ],
    );
  }

  Widget _buildGridItems(
    BuildContext context,
    int index,
    int gridLength,
    MatAlgos algo,
  ) {
    int gridStateLength = gridLength;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    final listenable = algo.blocksLiveData[x][y];
    return ValueListenableBuilder<Block>(
      valueListenable: listenable,
      builder: (context, snapshot, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: snapshot.isanimated ? 0 : 100,
          width: snapshot.isanimated ? 0 : 100,
          decoration: BoxDecoration(
            color: snapshot.isanimated ? Colors.red : Colors.black38,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(snapshot.isanimated ? 0 : 100),
          ),
        );
      },
    );
  }
}
