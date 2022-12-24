import 'package:algo_visualizer/algos/graph_algo/abstract/graph_algos.dart';
import 'package:algo_visualizer/model/block.dart';
import 'package:flutter/material.dart';

class GraphVisualizer extends StatelessWidget {
  final GraphAlgos algo;

  const GraphVisualizer({
    super.key,
    required this.algo,
  });

  @override
  Widget build(BuildContext context) {
    int gridStateLength = algo.blocksLiveData.length;
    return Column(
      children: [
        SizedBox(
          height: 300,
          width: 300,
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
          },
        ),
      ],
    );
  }

  Widget _buildGridItems(
    BuildContext context,
    int index,
    int gridLength,
    GraphAlgos algo,
  ) {
    int gridStateLength = gridLength;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    final listenable = algo.blocksLiveData[x][y];
    return ValueListenableBuilder<Block>(
      valueListenable: listenable,
      builder: (context, snapshot, _) {
        return snapshot.isanimated
            ? const BlockTile()
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black,
                ),
              );
      },
    );
  }
}

class BlockTile extends StatefulWidget {
  const BlockTile({super.key});

  @override
  State<BlockTile> createState() => _BlockTileState();
}

class _BlockTileState extends State<BlockTile> {
  final forwardTweenColor =
      ColorTween(begin: Colors.black, end: Colors.redAccent);
  final reverseTweenColor =
      ColorTween(begin: Colors.redAccent, end: Colors.black);
  late ColorTween currentTween;
  @override
  void initState() {
    super.initState();
    currentTween = forwardTweenColor;
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: currentTween,
      duration: const Duration(seconds: 3),
      onEnd: () {
        setState(() {
          currentTween = reverseTweenColor;
        });
      },
      builder: (context, value, _) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: value,
          ),
        );
      },
    );
  }
}
