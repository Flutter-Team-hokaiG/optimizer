import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  int _valueTTT = 0;
  bool _enableDragging = true;
  void _onChanged(dynamic value) {
    if (_enableDragging == true) {
      setState(() => _value = value);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        activeTickMarkColor: Colors.amber,
        disabledActiveTickMarkColor: Colors.amberAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 300,
            color: Colors.blue[100],
            child: SfSlider.vertical(
              min: -5,
              max: 5,
              stepSize: 1,
              value: _value,
              interval: 1,
              showTicks: _enableDragging,
              showLabels: _enableDragging,
              enableTooltip: _enableDragging,
              tooltipPosition: SliderTooltipPosition.right,
              activeColor: Colors.green,
              inactiveColor: Colors.yellow,
              showDividers: true,
              thumbIcon: Icon(Icons.music_note, size: 20, color: Colors.white),
              onChanged: _onChanged,
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.volume_up)),
          Transform.scale(
              scale: 1.5,
              child: Switch(
                value: _enableDragging,
                onChanged: (bool value) {
                  setState(() {
                    _enableDragging = value;
                    if (_enableDragging == true) {
                      _onChanged(_valueTTT);
                    } else {
                      _valueTTT = _value;
                      _onChanged(_value);
                    }
                    //stateSetter(() {});
                  });
                },
              )),
        ],
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
  bool _enableDragging = true;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        activeTickMarkColor: Colors.amber,
        disabledActiveTickMarkColor: Colors.amberAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 300,
            color: Colors.red[100],
            child: (() {
              //即時関数を導入
              if (_enableDragging == true) {
                return SfSlider.vertical(
                  min: -5,
                  max: 5,
                  stepSize: 1,
                  value: _value,
                  interval: 1,
                  showTicks: _enableDragging,
                  showLabels: _enableDragging,
                  enableTooltip: _enableDragging,
                  showDividers: true,
                  thumbIcon: Container(
                      alignment: Alignment.center,
                      child: Text(
                        _value.toInt().toString(),
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                  trackShape: _TrackShape(),
                  onChanged: (dynamic value) {
                    setState(() => _value = value);
                  },
                );
              } else {
                return SfSlider.vertical(
                  min: -5,
                  max: 5,
                  stepSize: 1,
                  value: _value,
                  interval: 1,
                  thumbIcon: Container(
                      alignment: Alignment.center,
                      child: Text(
                        _value.toInt().toString(),
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                  onChanged: null,
                );
              }
            })(),
          ),
          ElevatedButton(onPressed: () {}, child: Icon(Icons.volume_up)),
          Transform.scale(
            scale: 1.5,
            child: Switch(
              value: _enableDragging,
              onChanged: (bool value) {
                setState(() {
                  _enableDragging = value;
                  if (_enableDragging == true) {
                  } else {}
                  // stateSetter(() {});
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackShape extends SfTrackShape {
  void paint(PaintingContext context, Offset offset, Offset? thumbCenter,
      Offset? startThumbCenter, Offset? endThumbCenter,
      {required RenderBox parentBox,
      required themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Animation<double> enableAnimation,
      required Paint? inactivePaint,
      required Paint? activePaint,
      required TextDirection textDirection}) {
    Paint paint = Paint()
      ..color = themeData.activeTrackColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    super.paint(context, offset, thumbCenter, startThumbCenter, endThumbCenter,
        parentBox: parentBox,
        themeData: themeData,
        enableAnimation: enableAnimation,
        inactivePaint: inactivePaint,
        activePaint: paint,
        textDirection: textDirection);
  }
}
