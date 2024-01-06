import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.brown,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: TicketPainter(),
                    ),
                  ),
                  const Center(
                    child: Icon(
                      Icons.percent,
                      color: Colors.brown,
                      size: 150,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.6,
              child: ClipPath(
                clipper: TicketPath(),
                child: Container(
                  color: Colors.white,
                  child: const Icon(
                    Icons.percent,
                    color: Colors.brown,
                    size: 150,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Using CustomPaint

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = 40;

    var path = Path();
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;

    path.moveTo(0, radius);

    // Inward
    path.lineTo(0, (size.height / 2) - radius / 2);
    path.quadraticBezierTo(
        radius / 1.5, size.height / 2, 0, (size.height / 2) + radius / 2);

    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(0, size.height, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - radius);

    // Inward
    path.lineTo(size.width, (size.height / 2) + radius / 2);
    path.quadraticBezierTo((size.width - radius / 1.5), size.height / 2,
        size.width, (size.height / 2) - radius / 2);

    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width, 0, size.width - radius, 0);
    path.lineTo(radius, 0);
    path.quadraticBezierTo(0, 0, 0, radius);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TicketPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 40;

    var path = Path();
    // Inward
    path.lineTo(0, (size.height / 2) - radius / 2);
    path.quadraticBezierTo(
        radius / 1.5, size.height / 2, 0, (size.height / 2) + radius / 2);

    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(0, size.height, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - radius);

    // Inward
    path.lineTo(size.width, (size.height / 2) + radius / 2);
    path.quadraticBezierTo((size.width - radius / 1.5), size.height / 2,
        size.width, (size.height / 2) - radius / 2);

    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width, 0, size.width - radius, 0);
    path.lineTo(radius, 0);
    path.quadraticBezierTo(0, 0, 0, radius);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
