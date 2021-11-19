import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TakagiriPage extends StatefulWidget {
  const TakagiriPage({Key? key}) : super(key: key);

  @override
  _TakagiriPageState createState() => _TakagiriPageState();
}

class _TakagiriPageState extends State<TakagiriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("髙桐の部屋"),
        centerTitle: false,
        elevation: 0,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TakagiriSlider(),
            TakagiriSlider2(),
          ],
        ),
      ),
    );
  }
}

class TakagiriSlider extends StatefulWidget {
  const TakagiriSlider({Key? key}) : super(key: key);

  @override
  _TakagiriSliderState createState() => _TakagiriSliderState();
}

const int max_value = 5;
const int min_value = -5;
int _value = 0;
bool _enableDragging = true;

class _TakagiriSliderState extends State<TakagiriSlider> {
  void _valueup() {
    if (_value < 5) {
      setState(() {
        _value++;
      });
    } else {
      return null;
    }
  }

  void _valuedown() {
    if (_value > -5) {
      setState(() {
        _value--;
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 300,
        child: Column(
      children: [
        Container(
          height: 200,
        ),
        Text(
          "$_value",
          style: TextStyle(
            fontSize: 32,
            color: Colors.blue,
          ),
        ),
        ElevatedButton(
          onPressed: _valueup,
          child: Icon(Icons.add),
        ),
        SfSlider.vertical(
          min: min_value,
          max: max_value,
          value: _value,
          //stepSize: 1,
          interval: 1,
          activeColor: Colors.blue,
          inactiveColor: Colors.blue.withOpacity(0.3),
          //showTicks: true,
          //showLabels: true,
          //enableTooltip: true,
          //showDividers: true,
          onChanged: (dynamic value) {
            setState(() {});
          },
        ),
        ElevatedButton(
          onPressed: _valuedown,
          child: Icon(Icons.remove),
        ),
      ],
    ));
  }
}

class TakagiriSlider2 extends StatefulWidget {
  const TakagiriSlider2({Key? key}) : super(key: key);

  @override
  _TakagiriSlider2State createState() => _TakagiriSlider2State();
}

class _TakagiriSlider2State extends State<TakagiriSlider2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: SfSlider.vertical(
        min: min_value,
        max: max_value,
        value: _value,
        stepSize: 1,
        interval: 1,
        activeColor: Colors.blue,
        inactiveColor: Colors.blue.withOpacity(0.3),
        showTicks: true,
        showLabels: true,
        enableTooltip: true,
        showDividers: true,
        onChanged: (dynamic newvalue) {
          if (_enableDragging == true) {
            setState(() {
              _value = newvalue;
            });
          } else {
            return null;
          }
        },
      ),
    );
  }
}
