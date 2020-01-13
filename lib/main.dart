import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_clock/system_util.dart';

import 'flip_panel.dart';

void main() {
  runApp(new MyApp());
  SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    //状态栏
    systemNavigationBarColor: Color(0xfff0f0f0),
    //虚拟按键背景色
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    //虚拟按键图标色
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeLeft]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      title: 'FlipClock',
      home: FlipClockPage(),
    );
  }
}

class FlipClockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: null,
      body: Center(
        child: SizedBox(
          height: (getScreenWidth(context) / 7 - 10) * 2 + 1,
          child: FlipClock.simple(
            startTime: DateTime.now(),
            digitColor: Colors.white,
            backgroundColor: Colors.black,
            digitSize: getScreenWidth(context) / 7,
            borderRadius: const BorderRadius.all(Radius.circular(3.0)),
            width: getScreenWidth(context) / 7 - 10,
            height: (getScreenWidth(context) / 7 - 10) * 2,
          ),
        ),
      ),
    );
  }
}
