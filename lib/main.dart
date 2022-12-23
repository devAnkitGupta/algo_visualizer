import 'package:flutter/material.dart';
import 'algos/bfs/bfs_notifiers.dart';
import 'algos/dfs/dfs_notifier.dart';
import 'widget/mat_dancer.dart';

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
        home: MatDancer(
          algo: BfsNotifier(),
        )
        // MatDancer(algo: DfsNotifier()),
        );
  }
}
