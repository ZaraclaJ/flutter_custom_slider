import 'package:flutter/material.dart';
import 'package:custom_slider/cell.dart';

class Bubble extends StatefulWidget {   

  final String _bubbleText;
  final double _barWidth;
  final double _bubbleHeight;
  final double _bubbleWidth;
  final List<CellData> _cellDataList;
  final int _verticalFactor;
  final Color _strokeColor;
  final double _strokeWidth;
  final double _arrowWidth;
  final double _arrowHeight;
  final double _bubbleFontSize;
  final bool _pointBot;
  final GlobalKey<BubbleState> key;

  Bubble(
      this.key,
      this._bubbleText,
      this._barWidth,
      this._bubbleWidth,
      this._bubbleHeight,
      this._cellDataList,
      this._pointBot,
      this._strokeColor,
      this._strokeWidth,
      this._arrowWidth,
      this._arrowHeight,
      this._bubbleFontSize)
      : this._verticalFactor = _pointBot ? 1 : -1, super(key: key);

  @override
  BubbleState createState() => BubbleState();
}

class BubbleState extends State<Bubble> with SingleTickerProviderStateMixin {
  double _pointerRatio = 0.5;
  Animation<double> animation;
  AnimationController controller;

  BubbleState();

  initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget._barWidth,
      height: widget._bubbleHeight,
      child: Stack(
        children: <Widget>[
          AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget child) {
                return Positioned(
                  left: controller.isAnimating
                      ? animation.value *
                          (widget._barWidth - widget._bubbleWidth)
                      : _pointerRatio *
                          (widget._barWidth - widget._bubbleWidth),
                  child: new GestureDetector(
                    onHorizontalDragUpdate: (dragDetails) {
                      setState(() => _pointerRatio =
                          _updatePositionX(dragDetails.delta.dx));
                    },
                    child: Container(
                      height: widget._bubbleHeight,
                      width: widget._bubbleWidth,
                      child: new CustomPaint(
                        painter: BubblePainter(
                          controller.isAnimating
                              ? animation.value
                              : _pointerRatio,
                          widget._bubbleWidth,
                          widget._bubbleHeight,
                          _getColor(),
                          widget._strokeWidth,
                          widget._strokeColor,
                          widget._arrowWidth,
                          widget._arrowHeight,
                          widget._pointBot,
                        ),
                        child: Padding(
                          padding: widget._pointBot
                              ? EdgeInsets.only(bottom: widget._arrowHeight, right: 4.0, left: 4.0)
                              : EdgeInsets.only(top: widget._arrowHeight, right: 4.0, left: 4.0),
                          child: Center(
                              child: new Text(widget._bubbleText,
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: widget._strokeColor,
                                    fontSize: widget._bubbleFontSize,
                                  ))),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  void animate(double end) {
    var begin = _pointerRatio;
    controller.duration =
        Duration(milliseconds: ((end - begin).abs() * 2000).toInt());
    animation = Tween(begin: begin, end: end).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
        }
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
    _pointerRatio = end;
  }

  double _updatePositionX(double dx) {
    var ratio = controller.isAnimating ? animation.value : _pointerRatio;
    var result = ratio + dx / widget._barWidth;
    if (result < 0.0) {
      result = 0.0;
    } else if (result > 1.0) {
      result = 1.0;
    }
    return result;
  }

  Color _getColor() {
    var ratio = controller.isAnimating ? animation.value : _pointerRatio;
    var listCount = widget._cellDataList.length;
    var sumRatio =
        (1 + widget._verticalFactor * widget._cellDataList[0].rightGap) /
            listCount;
    var i = 0;
    while (sumRatio < ratio && i < listCount - 1) {
      i++;
      sumRatio += (1 +
              widget._verticalFactor * widget._cellDataList[i].rightGap -
              widget._verticalFactor * widget._cellDataList[i - 1].rightGap) /
          listCount;
    }
    return widget._cellDataList[i].color;
  }
}

class BubblePainter extends CustomPainter {
  final double _bubbleHeight;
  final double _bubbleWidth;
  final Color _bubbleColor;
  final double _ratio;
  final double _strokeWidth;
  final Color _strokeColor;
  final double _arrowWidth;
  final double _arrowHeight;
  final bool _pointBot;

  BubblePainter(
      this._ratio,
      this._bubbleWidth,
      this._bubbleHeight,
      this._bubbleColor,
      this._strokeWidth,
      this._strokeColor,
      this._arrowWidth,
      this._arrowHeight,
      this._pointBot);

  @override
  void paint(Canvas canvas, Size size) {
    double arrowPositionX = _ratio * _bubbleWidth;

    final Paint paint = Paint()..color = _bubbleColor;
    paint.style = PaintingStyle.fill;

    Path path;
    path = _pointBot
        ? _getPointBotBubblePath(arrowPositionX)
        : _getPointTopBubblePath(arrowPositionX);

    canvas.drawPath(path, paint);

    // Draw strokes
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = _strokeWidth;
    paint.color = _strokeColor;
    canvas.drawPath(path, paint);
  }

  Path _getPointBotBubblePath(double arrowPositionX) {
    final Path path = Path();

    var currentX = 0.0;
    var currentY = 0.0;
    path.moveTo(currentX, currentY);
    currentY = _bubbleHeight - _arrowHeight;
    path.lineTo(currentX, currentY);

    if (arrowPositionX > _arrowWidth / 2) {
      currentX = arrowPositionX - _arrowWidth / 2;
      path.lineTo(currentX, currentY);
    }

    currentX = arrowPositionX;
    currentY = _bubbleHeight - _strokeWidth / 2;
    path.lineTo(currentX, currentY);

    if (arrowPositionX < _bubbleWidth - _arrowWidth / 2) {
      currentX = arrowPositionX + _arrowWidth / 2;
      currentY = _bubbleHeight - _arrowHeight;
      path.lineTo(currentX, currentY);
    }

    currentY = _bubbleHeight - _arrowHeight;
    currentX = _bubbleWidth;
    path.lineTo(currentX, currentY);

    currentY = 0.0;
    path.lineTo(currentX, currentY);

    path.close();

    return path;
  }

  Path _getPointTopBubblePath(double arrowPositionX) {
    final Path path = Path();

    var currentX = 0.0;
    var currentY = _arrowHeight;
    path.moveTo(currentX, currentY);

    if (arrowPositionX > _arrowWidth / 2) {
      currentX = arrowPositionX - _arrowWidth / 2;
      path.lineTo(currentX, currentY);
    }

    currentX = arrowPositionX;
    currentY = 0.0 + _strokeWidth / 2;
    path.lineTo(currentX, currentY);

    if (arrowPositionX < _bubbleWidth - _arrowWidth / 2) {
      currentX = arrowPositionX + _arrowWidth / 2;
      currentY = _arrowHeight;
      path.lineTo(currentX, currentY);
    }

    currentX = _bubbleWidth;
    currentY = _arrowHeight;
    path.lineTo(currentX, currentY);

    currentY = _bubbleHeight;
    path.lineTo(currentX, currentY);

    currentX = 0.0;
    path.lineTo(currentX, currentY);

    path.close();

    return path;
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) => true;
  @override
  bool shouldRebuildSemantics(BubblePainter oldDelegate) => true;
}
