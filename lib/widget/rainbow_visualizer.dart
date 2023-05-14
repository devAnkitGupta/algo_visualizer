import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

class ColorCycler extends StatefulWidget {
  const ColorCycler({
    Key? key,
  }) : super(key: key);

  @override
  _ColorCyclerState createState() => _ColorCyclerState();
}

class _ColorCyclerState extends State<ColorCycler>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool isAnimationCompleted = false;

  final Rainbow _rb = Rainbow(spectrum: const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.black,
  ], rangeStart: 0, rangeEnd: 900.0);

  @override
  Widget build(BuildContext context) {
    return
        //  isAnimationCompleted
        //     ? Container(
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(4),
        //           color: Colors.black,
        //         ),
        //       )
        //     :
        AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, _) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _rb[animation.value],
                _rb[(50.0 + animation.value) % _rb.rangeEnd]
              ]),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);

    animation = Tween<double>(
            begin: _rb.rangeStart.toDouble(), end: _rb.rangeEnd.toDouble())
        .animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.stop();
          // controller.reset();
          // controller.forward();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
