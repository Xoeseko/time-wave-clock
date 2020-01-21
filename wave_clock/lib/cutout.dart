import 'package:flutter/material.dart';

class CutoutPainter extends CustomPainter {
  CutoutPainter({this.text, this.style}) {
    _textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,  
    );
    _textPainter.layout();
  }
  final TextStyle style;
  final String text;
  TextPainter _textPainter;

  @override
  void paint(Canvas canvas, Size size) {
    final textOffset = size.center(Offset.zero) - _textPainter.size.center(Offset.zero);

    // This does the trick for the rectangle to be the same size as the given canvas
    final boxRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final boxPaint = Paint()
    ..color = Colors.black
    ..blendMode=BlendMode.srcOut;

    canvas.saveLayer(boxRect, Paint());

    _textPainter.paint(canvas, textOffset);
    canvas.drawRect(boxRect, boxPaint);

    canvas.restore();
  }

  @override 
  bool shouldRepaint(CutoutPainter oldDelegate) {
    return text != oldDelegate.text;
  }
}
