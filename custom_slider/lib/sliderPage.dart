import 'package:custom_slider/cell.dart';
import 'package:flutter/material.dart';
import 'package:custom_slider/slider.dart';

class SliderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFd1fdff),
              Color(0xFFfddb92),
            ],
          ),
        ),
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Gauge(
                  arrowHeight: 20.0,
                  arrowWidth: 20.0,
                  barHeight: 50.0,
                  bubbleFontSize: 15.0,
                  cellDataList: [
                    CellData(Color(0xFF000000), "0", rightGap: 0.0),
                    CellData(Color(0xFFB2D624), "1", rightGap: 0.0),
                    CellData(Color(0xFF6DAD2D), "2", rightGap: 0.0),
                    CellData(Color(0xFF26A53A), "3", rightGap: 0.0),
                    CellData(Color(0xFF1C7735), "4", rightGap: 0.0),
                    CellData(Color(0xFF0D4E02), "5", rightGap: 0.0),
                  ],
                  gaugeWidth: screenWidth,
                  pointerFrameHeight: 60.0,
                  pointerFrameWidth: 130.0,
                  strokeColor: Colors.white,
                  strokeWidth: 5.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Gauge(
                  arrowHeight: 20.0,
                  arrowWidth: 20.0,
                  barHeight: 50.0,
                  bubbleFontSize: 15.0,
                  cellDataList: [
                      CellData(Color(0xFF881B24), "-3", rightGap: 0.2),
                      CellData(Color(0xFFD2531C), "-2", rightGap: 0.2),
                      CellData(Color(0xFFF19E13), "-1", rightGap: 0.2),
                      CellData(Color(0xFF000000), "0", rightGap: 0.2),
                    ],
                  gaugeWidth: screenWidth,
                  pointerFrameHeight: 60.0,
                  pointerFrameWidth: 130.0,
                  strokeColor: Colors.white,
                  strokeWidth: 5.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Gauge(
                  arrowHeight: 20.0,
                  arrowWidth: 20.0,
                  barHeight: 50.0,
                  bubbleFontSize: 15.0,
                  cellDataList: [
                      CellData(Color(0xFF881B24), "", rightGap: 0.5),
                      CellData(Color(0xFFD2531C), "", rightGap: 0.5),
                      CellData(Color(0xFFF19E13), "", rightGap: 0.5),
                      CellData(Color(0xFF000000), "", rightGap: 0.5),
                      CellData(Color(0xFFB2D624), "", rightGap: 0.5),
                      CellData(Color(0xFF26A53A), "", rightGap: 0.5),
                      CellData(Color(0xFF0D4E02), "", rightGap: 0.0),
                    ],
                  gaugeWidth: screenWidth,
                  pointerFrameHeight: 60.0,
                  pointerFrameWidth: 130.0,
                  strokeColor: Colors.white,
                  strokeWidth: 5.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Gauge(
                  arrowHeight: 20.0,
                  arrowWidth: 20.0,
                  barHeight: 50.0,
                  bubbleFontSize: 15.0,
                  cellDataList: [
                      CellData(Color(0xFF881B24), "", rightGap: 0.5),
                      CellData(Color(0xFFD21E1F), "", rightGap: -0.5),
                      CellData(Color(0xFFD2531C), "", rightGap: 0.5),
                      CellData(Color(0xFFEB7605), "", rightGap: -0.5),
                      CellData(Color(0xFFF19E13), "", rightGap: 0.5),
                      CellData(Color(0xFF000000), "", rightGap: -0.5),
                      CellData(Color(0xFFB2D624), "", rightGap: 0.5),
                      CellData(Color(0xFF6DAD2D), "", rightGap: -0.5),
                      CellData(Color(0xFF26A53A), "", rightGap: 0.5),
                      CellData(Color(0xFF1C7735), "", rightGap: -0.5),
                      CellData(Color(0xFF0D4E02), "", rightGap: 0.0),
                    ],
                  gaugeWidth: screenWidth,
                  pointerFrameHeight: 60.0,
                  pointerFrameWidth: 130.0,
                  strokeColor: Colors.white,
                  strokeWidth: 5.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
