import 'dart:math'; // 後でインジケータの実装に使う
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:optimizer/main.dart';

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Page takagiri2"),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(height: 50),
              BatteryLevelIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BatteryLevelIndicatorPainter extends CustomPainter {
  final int percentage; // バッテリーレベルの割合
  final double textCircleRadius; // 内側に表示される白丸の半径
  _BatteryLevelIndicatorPainter({
    required this.percentage,
    required this.textCircleRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 1; i < (360 * percentage / 100); i += 5) {
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
      final offset0 = Offset(size.width * 0.5, size.height * 0.38);
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
  int percentage = 80;
  final size = 164.0;
  bool isEnabled1 = true;
  bool isEnabled2 = true;

  @override
  Widget build(BuildContext context) {
    final colorA = ColorTween(
      begin: kColorIndicatorBegin,
      end: kColorIndicatorEnd,
    ).lerp(percentage / 100)!;
    if (percentage >= 100) {
      setState(() {
        isEnabled1 = false;
      });
    }
    if (percentage < 100) {
      setState(() {
        isEnabled1 = true;
      });
    }
    if (percentage <= 0) {
      setState(() {
        isEnabled2 = false;
      });
    }
    if (percentage > 0) {
      setState(() {
        isEnabled2 = true;
      });
    }
    sampleFunction1() {
      if (percentage < 100) {
        setState(() {
          percentage += 10;
        });
      }
    }

/*    sampleFunction2() {
      if (percentage <= 0) {
        setState(() {});
      } else {
        setState(() {
          percentage -= 10;
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
                    '$percentage%',
                    style: TextStyle(
                        color: colorA, fontSize: size * 0.2 + percentage * 0.2),
                  ),
                ),
              ),
            ),
          ),
          Container(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: isEnabled1 ? () => sampleFunction1() : null,
                    child: Icon(Icons.add),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (percentage <= 0) {
                      setState(() {});
                    } else {
                      setState(() {
                        percentage -= 10;
                      });
                    }
                  },
                  child: Icon(Icons.remove),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
