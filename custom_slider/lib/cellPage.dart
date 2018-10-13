import 'package:flutter/material.dart';
import 'package:custom_slider/cell.dart';

class CellPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cell"),
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
                padding: const EdgeInsets.all(20.0),
                child: Cell(
                  100.0,
                  100.0,
                  color: Color(0xFFa18cd1),
                  strokeColor: Colors.black,
                  contentString: "Text",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Cell(
                  100.0,
                  100.0,
                  color: Color(0xFFffffff),
                  strokeColor: Color(0xFF30cfd0),
                  strokeWidth: 30.0,
                  fontSize: 10.0,
                  contentString: "Text",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Cell(
                  100.0,
                  100.0,
                  ratioBL: 0.5,
                  ratioBR: 0.5,
                  ratioTL: -0.5,
                  ratioTR: -0.5,
                  strokeWidth: 0.0,
                  color: Color(0xFFfad0c4),
                  strokeColor: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Cell(
                  100.0,
                  100.0,
                  ratioBL: -0.2,
                  ratioBR: -0.2,
                  ratioTL: 0.5,
                  ratioTR: 0.5,
                  color: Color(0xFFa8edea),
                  strokeColor: Colors.black,
                  contentString: "Text",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Cell(
                  100.0,
                  100.0,
                  ratioBL: 0.4,
                  ratioBR: -0.4,
                  ratioTL: -0.4,
                  ratioTR: 0.4,
                  strokeWidth: 5.0,
                  color: Color(0xFF3cba92),
                  strokeColor: Color(0xFF005bea),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}