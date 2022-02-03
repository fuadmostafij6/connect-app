import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CustomshapPage extends StatefulWidget {
  const CustomshapPage({Key? key}) : super(key: key);

  @override
  _CustomshapPageState createState() => _CustomshapPageState();
}

class _CustomshapPageState extends State<CustomshapPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(
              30,
              (105 * 0.5833333333333334)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
        ),
      ],
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.cubicTo(0, size.height * 0.7425000, 0, size.height * 0.7425000, 0,
        size.height * 0.9900000);
    path0.cubicTo(
        size.width * 0.4116000,
        size.height * 1.0254000,
        size.width * 0.8335000,
        size.height * 0.8793000,
        size.width * 0.9974000,
        size.height * 0.4895000);
    path0.cubicTo(size.width * 0.6946000, size.height * 0.5165000,
        size.width * 0.3733000, size.height * 0.5624000, 0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
