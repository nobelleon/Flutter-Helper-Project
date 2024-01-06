import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late Animation<double> animation1;
  late Animation<double> animation2;
  late Animation<double> animation3;
  late Animation<double> animation4;
  late AnimationController controller1;
  late AnimationController controller2;
  late AnimationController controller3;
  late AnimationController controller4;
  int step = 1;

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );
    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );
    controller3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );
    controller4 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );

    animation1 = Tween<double>(begin: 0, end: math.pi / 2).animate(controller1)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          step++;
        }
      });

    animation2 =
        Tween<double>(begin: math.pi / 2, end: math.pi).animate(controller2)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              step++;
            }
          });
    animation3 = Tween<double>(begin: math.pi, end: (3 * math.pi) / 2)
        .animate(controller3)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          step++;
        }
      });

    animation4 = Tween<double>(begin: (3 * math.pi) / 2, end: 2 * math.pi)
        .animate(controller4)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          step++;
        }
      });
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  void _startAnimation() {
    switch (step) {
      case 1:
        controller1.forward();
        break;
      case 2:
        controller2.forward();
        break;
      case 3:
        controller3.forward();
        break;
      case 4:
        controller4.forward();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: 70,
          width: 70,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: ArcPainter(
                    position: step == 1
                        ? animation1.value
                        : step == 2
                            ? animation2.value
                            : step == 3
                                ? animation3.value
                                : animation4.value,
                  ),
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: 30,
                  child: IconButton(
                    onPressed: _startAnimation,
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double position;

  ArcPainter({required this.position});
  @override
  void paint(Canvas canvas, Size size) {
    var frontColoredPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height,
      ),
      270.toDegree(),
      position,
      false,
      frontColoredPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

extension RadianToDegree on num {
  double toDegree() {
    return this * math.pi / 180;
  }
}
