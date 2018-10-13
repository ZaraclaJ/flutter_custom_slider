import 'package:flutter/material.dart';
import 'package:custom_slider/bar.dart';
import 'package:custom_slider/cell.dart';
import 'package:custom_slider/bubble.dart';

class Gauge extends StatelessWidget {
  final double gaugeWidth;
  final double barHeight;
  final double pointerFrameHeight;
  final double pointerFrameWidth;
  final Color strokeColor;
  final double strokeWidth;
  final double arrowWidth;
  final double arrowHeight;
  final double bubbleFontSize;  

  final topBubbleKey = GlobalKey<BubbleState>();
  final botBubbleKey = GlobalKey<BubbleState>();

  final List<CellData> cellDataList;

  Gauge({
      @required this.cellDataList,
      @required this.gaugeWidth,
      @required this.barHeight,
      @required this.pointerFrameWidth,
      @required this.pointerFrameHeight,
      @required this.strokeColor,
      @required this.strokeWidth,
      @required this.arrowWidth,
      @required this.arrowHeight,
      @required this.bubbleFontSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Bubble(
          topBubbleKey,
            "Perdre son permis",
            gaugeWidth,
            pointerFrameWidth,
            pointerFrameHeight,
            cellDataList,
            true,
            strokeColor,
            strokeWidth,
            arrowWidth,
            arrowHeight,
            bubbleFontSize),
        new Bar(
            gaugeWidth, barHeight, cellDataList, strokeColor, strokeWidth),
        new Bubble(
          botBubbleKey,
            "Devenir millionaire",
            gaugeWidth,
            pointerFrameWidth,
            pointerFrameHeight,
            cellDataList,
            false,
            strokeColor,
            strokeWidth,
            arrowWidth,
            arrowHeight,
            bubbleFontSize),
      ],
    );
  }

  void animateTopBubble(double endPosition){
    topBubbleKey.currentState.animate(endPosition);    
  }

  void animateBottomBubble(double endPosition){
    botBubbleKey.currentState.animate(endPosition);    
  }
}
