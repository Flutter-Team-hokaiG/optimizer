import 'dart:math'; // 後でインジケータの実装に使う
import 'dart:ui';
import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Page"),
      ),
    );
  }
}
