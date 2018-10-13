import 'package:flutter/material.dart';
import 'package:custom_slider/cell.dart';
import 'package:custom_slider/gauge.dart';

Color backgroundColor = Color(0xFF338495);

List<CellData> cellDataList = [
  CellData(Color(0xFF881B24), "-5", rightGap: 0.1),
  CellData(Color(0xFFD21E1F), "-4", rightGap: 0.15),
  CellData(Color(0xFFD2531C), "-3", rightGap: 0.05),
  CellData(Color(0xFFEB7605), "-2", rightGap: -0.1),
  CellData(Color(0xFFF19E13), "-1", rightGap: 0.0),
  CellData(Color(0xFF000000), "0", rightGap: 0.0),
  CellData(Color(0xFFB2D624), "1", rightGap: 0.1),
  CellData(Color(0xFF6DAD2D), "2", rightGap: -0.05),
  CellData(Color(0xFF26A53A), "3", rightGap: -0.15),
  CellData(Color(0xFF1C7735), "4", rightGap: -0.1),
  CellData(Color(0xFF0D4E02), "5", rightGap: 0.0),
];

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final topFormKey = GlobalKey<FormState>();
  final botFormKey = GlobalKey<FormState>();

  Gauge gauge;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    gauge = gauge ?? Gauge(
      cellDataList: cellDataList,
      arrowHeight: 20.0,
      strokeColor: Colors.white,
      strokeWidth: 3.0,
      arrowWidth: 20.0,
      barHeight: 40.0,
      bubbleFontSize: 15.0,
      gaugeWidth: screenWidth - 100,
      pointerFrameWidth: screenWidth / 4,
      pointerFrameHeight: 70.0,
    );
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: Container(
            color: backgroundColor,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                    child: gauge,
                  ),
                ),
                Form(
                  key: topFormKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10.0),
                        width: 100.0,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (str) =>
                              double.parse(str) < 0.0 || double.parse(str) > 1.0
                                  ? "Enter a percentage"
                                  : null,
                          onSaved: (str) =>
                              gauge.animateTopBubble(double.parse(str)),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: onPressedTop,
                        child: Icon(Icons.check),
                      )
                    ],
                  ),
                ),
                Form(
                  key: botFormKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10.0),
                        width: 100.0,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (str) =>
                              double.parse(str) < 0.0 || double.parse(str) > 1.0
                                  ? "Enter a percentage"
                                  : null,
                          onSaved: (str) =>
                              gauge.animateBottomBubble(double.parse(str)),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: onPressedBot,
                        child: Icon(Icons.check),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }

  void onPressedTop() {
    var form = topFormKey.currentState;
    if (form.validate()) {
      form.save();
    }
  }

  void onPressedBot() {
    var form = botFormKey.currentState;
    if (form.validate()) {
      form.save();
    }
  }
}
