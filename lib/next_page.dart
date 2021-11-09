// import 'dart:math'; // 後でインジケータの実装に使う
// import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:optimizer/main.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Page takagiri2"),
        centerTitle: false,
        elevation: 0,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(child: Slider1(), width: 200),
            Container(child: Slider2(), width: 200),
          ],
        ),
      ),
    );
  }
}

class Slider1 extends StatefulWidget {
  const Slider1({Key? key}) : super(key: key);

  @override
  _Slider1State createState() => _Slider1State();
}

class _Slider1State extends State<Slider1> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          color: Colors.blue[100],
          child: SfSlider.vertical(
            min: -5,
            max: 5,
            stepSize: 1,
            value: _value,
            interval: 1,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            onChanged: (dynamic value) {
              setState(() {
                _value = value;
              });
            },
          ),
        ),
      ),
    );
  }
}

class Slider2 extends StatefulWidget {
  const Slider2({Key? key}) : super(key: key);

  @override
  _Slider2State createState() => _Slider2State();
}

class _Slider2State extends State<Slider2> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: 100,
      body: Center(
        child: Container(
          height: 300,
          color: Colors.red[100],
          child: SfSlider.vertical(
            min: -5,
            max: 5,
            stepSize: 1,
            value: _value,
            interval: 1,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            onChanged: (dynamic value) {
              setState(() {
                _value = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
