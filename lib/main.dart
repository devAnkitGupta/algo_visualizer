import 'package:flutter/material.dart';
import 'algos/graph_algo/bfs/bfs_notifiers.dart';
import 'algos/graph_algo/dfs/dfs_notifier.dart';
import 'widget/graph_visualizer.dart';

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
        home: GraphVisualizer(
          algo: BfsNotifier(),
        )
        // MatDancer(algo: DfsNotifier()),
        );
  }
}
