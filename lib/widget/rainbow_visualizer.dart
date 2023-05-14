import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

class Tile extends StatefulWidget {
  const Tile({super.key});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  final Rainbow _rb = Rainbow(
    spectrum: const [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ],
    rangeStart: 0,
    rangeEnd: 500.0,
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, _) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _rb[animation.value],
              _rb[(50.0 + animation.value) % _rb.rangeEnd]
            ],
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    animation = Tween<double>(
            begin: _rb.rangeStart.toDouble(), end: _rb.rangeEnd.toDouble())
        .animate(controller)
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            controller.reset();
            controller.forward();
          } else if (status == AnimationStatus.dismissed) {
            controller.forward();
          }
        },
      );
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
