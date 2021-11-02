//import 'dart:ffi';
import 'dart:math'; // 後でインジケータの実装に使う
import 'dart:ui';
import 'package:flutter/material.dart';

const kColorPurple = Color(0xFF4A148C);
const kColorPink = Color(0xFFFFF176);
const kColorIndicatorBegin = kColorPink;
const kColorIndicatorEnd = kColorPurple;
const kColorTitle = Color(0xFF616161);
const kColorText = Color(0xFF9E9E9E);
const kElevation = 4.0;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: kColorTitle),
        ),
        backgroundColor: Colors.white,
      ),
      home: BatteryOptimizerPage(),
    );
  }
}

/* BatteryOptimizer画面 */

class BatteryOptimizerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Battery Optimizer'),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              BatteryLevelIndicator(),
              OptimizeNow(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BatteryLevelIndicatorPainter extends CustomPainter {
  final double percentage; // バッテリーレベルの割合
  final double textCircleRadius; // 内側に表示される白丸の半径
  _BatteryLevelIndicatorPainter({
    required this.percentage,
    required this.textCircleRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 1; i < (360 * percentage); i += 5) {
      final per = i / 360.0;
      // 割合（0~1.0）からグラデーション色に変換
      final color = ColorTween(
        begin: kColorIndicatorBegin,
        end: kColorIndicatorEnd,
      ).lerp(per)!;
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5;

      final spaceLen = 16; // 円とゲージ間の長さ
      final lineLen = 40; // ゲージの長さ
      final angle = (2 * pi * per) - (pi / 2); // 0時方向から開始するため-90度ずらす

      // 円の中心座標
      final offset0 = Offset(size.width * 0.5, size.height * 0.45);
      // 線の内側部分の座標
      final offset1 = offset0.translate(
        (textCircleRadius + spaceLen) * cos(angle),
        (textCircleRadius + spaceLen) * sin(angle),
      );
      // 線の外側部分の座標
      final offset2 = offset1.translate(
        lineLen * cos(angle),
        lineLen * sin(angle),
      );

      canvas.drawLine(offset1, offset2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BatteryLevelIndicator extends StatefulWidget {
  BatteryLevelIndicator({Key? key}) : super(key: key);

  @override
  _BatteryLevelIndicatorState createState() => _BatteryLevelIndicatorState();
}

class _BatteryLevelIndicatorState extends State<BatteryLevelIndicator> {
  double percentage = 0.8;
  final size = 164.0;
  bool isEnabled1 = true;
  bool isEnabled2 = true;

  @override
  Widget build(BuildContext context) {
    final colorA = ColorTween(
      begin: kColorIndicatorBegin,
      end: kColorIndicatorEnd,
    ).lerp(percentage)!;
    int intPercentage = (percentage * 100).toInt(); //整数表示するために変数を変えた
    if (intPercentage >= 100) {
      setState(() {
        isEnabled1 = false;
      });
    }
    if (intPercentage < 100) {
      setState(() {
        isEnabled1 = true;
      });
    }
    if (intPercentage <= 0) {
      setState(() {
        isEnabled2 = false;
      });
    }
    if (intPercentage > 0) {
      setState(() {
        isEnabled2 = true;
      });
    }
    sampleFunction1() {
      if (intPercentage >= 100) {
        setState(() {});
      } else {
        setState(() {
          percentage += 0.1;
        });
      }
    }

/*    sampleFunction2() {
      if (intPercentage <= 0) {
        setState(() {});
      } else {
        setState(() {
          percentage -= 0.1;
        });
      }
    }*/

    return CustomPaint(
      painter: _BatteryLevelIndicatorPainter(
        percentage: percentage,
        textCircleRadius: size * 0.5,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(64),
            child: Material(
              color: Colors.white,
              elevation: kElevation,
              borderRadius: BorderRadius.circular(size * 0.5),
              child: Container(
                width: size,
                height: size,
                child: Center(
                  child: Text(
                    '$intPercentage%',
                    style: TextStyle(
                        color: colorA, fontSize: 30 + percentage * 30),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 10),
              Center(
                child: ElevatedButton(
                  onPressed: isEnabled1 ? () => sampleFunction1() : null,
                  child: Icon(Icons.add),
                ),
              ),
              Spacer(flex: 1),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (intPercentage <= 0) {
                      setState(() {});
                    } else {
                      setState(() {
                        percentage -= 0.1;
                      });
                    }
                  },
                  child: Icon(Icons.remove),
                ),
              ),
              Spacer(flex: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class OptimizeNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kColorPurple,
          padding: EdgeInsets.symmetric(horizontal: 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        onPressed: () {},
        child: Text('Optimize Now', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
