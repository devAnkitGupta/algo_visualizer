import 'package:algo_visualizer/model/block.dart';
import 'package:flutter/material.dart';

import 'algos/dfs/notifiers/dfs_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  DfsNotifier dfsNotifier = DfsNotifier();

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    int gridStateLength = dfsNotifier.blocksLiveData.length;
    return Stack(
      children: [
        GridView.builder(
          itemCount: gridStateLength * gridStateLength,
          itemBuilder: (context, index) {
            return _buildGridItems(
              context,
              index,
              gridStateLength,
              dfsNotifier,
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: dfsNotifier.blocksLiveData.length,
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            dfsNotifier.runDfs();
          },
          child: const Icon(Icons.start),
        ),
      ],
    );
  }

  Widget _buildGridItems(
    BuildContext context,
    int index,
    int gridLength,
    DfsNotifier dfsNotifier,
  ) {
    int gridStateLength = gridLength;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    final listenable = dfsNotifier.blocksLiveData[x][y];
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
          child: Center(
              child: Text(
            '${snapshot.row} ${snapshot.column}',
            style: const TextStyle(fontSize: 14),
          )),
        );
      },
    );
  }
}
