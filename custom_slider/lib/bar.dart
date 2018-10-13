import 'dart:math';

import 'package:flutter/material.dart';
import 'package:custom_slider/cell.dart';

class Bar extends StatelessWidget {
  final List<CellData> _cellDataList;
  final double _barWidth;
  final double _cellHeight;
  final Color _strokeColor;
  final double _strokeWidth;
  final _random = new Random();

  Bar(this._barWidth, this._cellHeight, this._cellDataList, this._strokeColor,
      this._strokeWidth);

  @override
  Widget build(BuildContext context) {
    var _cellWidth = _barWidth / _cellDataList.length;
    var cellWidgetList = _populateCellWidgetList(_cellDataList, _cellWidth);
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: cellWidgetList,
      ),
    );
  }

  List<Widget> _populateCellWidgetList(
      List<CellData> cellDataList, double cellWidth) {
    List<Widget> result = List<Widget>();
    double _leftGap = 0.0;
    double _rightGap = 0.0;

    cellDataList.forEach((cellData) {
      _leftGap = _rightGap;
      _rightGap = cellData.rightGap ?? _nextRandomDouble();
      result.add(Cell(
        cellWidth,
        _cellHeight,
        fontSize: cellWidth / 3,
        color: cellData.color,
        strokeColor: _strokeColor,
        strokeWidth: _strokeWidth,
        contentString: cellData.text,
        ratioTL: -_leftGap,
        ratioBL: _leftGap,
        ratioBR: cellData == cellDataList.last ? 0.0 : -_rightGap,
        ratioTR: cellData == cellDataList.last ? 0.0 : _rightGap,
      ));
    });

    return result;
  }

  // return a double between -0.25 and 0.25
  double _nextRandomDouble() => (_random.nextDouble() - 0.5) / 4;
}
