import 'dart:ui';
import 'package:flutter/material.dart';

class CellData {
  final Color color;
  final String text;
  final double rightGap;
  CellData(this.color, this.text, {this.rightGap});
}

class CustomCell extends StatelessWidget {
  final double _height;
  final double _width;
  final double _fontSize;

  final double _ratioTL;
  final double _ratioTR;
  final double _ratioBL;
  final double _ratioBR;

  final String _contentString;
  final Color _color;
  final Color _strokeColor;
  final double _strokeWidth;

  CustomCell(this._width, this._height,
      {contentString: '',
      fontSize: 35.0,
      color: Colors.black,
      strokeColor: Colors.white,
      strokeWidth: 3.0,
      ratioTL: 0.0,
      ratioTR: 0.0,
      ratioBL: 0.0,
      ratioBR: 0.0})
      : _contentString = contentString,
        _fontSize = fontSize,
        _color = color,
        _strokeColor = strokeColor,
        _strokeWidth = strokeWidth,
        _ratioTL = ratioTL,
        _ratioTR = ratioTR,
        _ratioBL = ratioBL,
        _ratioBR = ratioBR;

  @override
  Widget build(BuildContext context) {
    var _paddingX = _width *
        ((_ratioTR + _ratioBR) / 2 -
            (_ratioTL + _ratioBL) / 2); // FIXME: maybe /2
    return Center(
      child: Container(
        child: new CustomPaint(
          painter: PaintedCell(
              _width, _height, _color, _strokeColor, _strokeWidth,
              ratioTR: _ratioTR,
              ratioBL: _ratioBL,
              ratioBR: _ratioBR,
              ratioTL: _ratioTL),
          child: Center(
              child: Padding(
            child: new Text(
              _contentString,
              textAlign: TextAlign.center,
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _strokeColor,
                  fontSize: _fontSize),
            ),
            padding: _paddingX < 0
                ? EdgeInsets.only(right: -_paddingX)
                : EdgeInsets.only(left: _paddingX),
          )),
        ),
        height: _height,
        width: _width,
      ),
    );
  }
}

class PaintedCell extends CustomPainter {
  final double _baseHeight;
  final double _baseWidth;
  double _strokeWidth;

  final double _ratioTL;
  final double _ratioTR;
  final double _ratioBL;
  final double _ratioBR;
  final Color _color;
  final Color _strokeColor;

  PaintedCell(
    this._baseWidth,
    this._baseHeight,
    this._color,
    this._strokeColor,
    this._strokeWidth, {
    ratioTL = 0.2,
    ratioTR = 0.2,
    ratioBL = -0.5,
    ratioBR = -0.0,
  })  : _ratioTL = ratioTL,
        _ratioTR = ratioTR,
        _ratioBL = ratioBL,
        _ratioBR = ratioBR;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = _color;
    paint.style = PaintingStyle.fill;

    double widthTL = _ratioTL * _baseWidth;
    double widthTR = _ratioTR * _baseWidth;
    double widthBL = _ratioBL * _baseWidth;
    double widthBR = _ratioBR * _baseWidth;

    final Path path = Path();

    // Top Left
    var currentX = -widthTL;
    path.moveTo(currentX, 0.0);

    // Top Right
    currentX = _baseWidth + widthTR;
    path.lineTo(currentX, 0.0);

    // Bottom Right
    currentX = _baseWidth + widthBR;
    path.lineTo(currentX, _baseHeight);

    // Bottom Left
    currentX = -widthBL;
    path.lineTo(currentX, _baseHeight);

    // Close
    path.close();

    canvas.drawPath(path, paint);

    // Draw strokes
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = _strokeWidth;
    paint.color = _strokeColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PaintedCell oldDelegate) => true;
  @override
  bool shouldRebuildSemantics(PaintedCell oldDelegate) => true;
}
