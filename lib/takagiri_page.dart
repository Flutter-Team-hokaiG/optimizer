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
bool mute = true;

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

  void muteonoff() {
    if (mute = true) {
      setState(() {
        mute = false;
      });
    } else if (mute = false) {
      setState(() {
        mute = true;
      });
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
          "$_value, $mute",
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
            setState(() {
              if (mute = false) {
                return null;
              }
            });
          },
        ),
        ElevatedButton(
          onPressed: _valuedown,
          child: Icon(Icons.remove),
        ),
        Container(
          height: 20,
        ),
        ElevatedButton(
          onPressed: muteonoff,
          child: Icon(Icons.volume_up),
        )
      ],
    ));
  }
}

class TakagiriSlider2 extends StatefulWidget {
  const TakagiriSlider2({Key? key}) : super(key: key);

  @override
  _TakagiriSlider2State createState() => _TakagiriSlider2State();
}

const int max_value2 = 5;
const int min_value2 = -5;
int _value2 = 0;

class _TakagiriSlider2State extends State<TakagiriSlider2> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: SfSlider.vertical(
            min: min_value2,
            max: max_value2,
            value: _value2,
            //stepSize: 1,
            interval: 1,
            activeColor: Colors.blue,
            inactiveColor: Colors.blue.withOpacity(0.3),
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            showDividers: true,
            onChanged: (dynamic newvalue) {
              setState(
                () {
                  _value2 = newvalue;
                },
              );
            }));
  }
}
