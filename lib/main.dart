import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_clock/system_util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wakelock/wakelock.dart';

import 'flip_panel.dart';

void main() {
  Observable.just(WidgetsFlutterBinding.ensureInitialized())
      .map((_) => debugPaintSizeEnabled = false)
      .map((_) => SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            //状态栏
            systemNavigationBarColor: Color(0xfff0f0f0),
            //虚拟按键背景色
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
            //虚拟按键图标色
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          )))
      .map((_) => SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeLeft]))
      .listen((_) => runApp(new MyApp()));
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

class FlipClockPage extends StatefulWidget {
  _FlipClockState createState() => _FlipClockState();
}

class _FlipClockState extends State<FlipClockPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    Wakelock.enable();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();

    Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: null,
      body: Center(
        child: SizedBox(
          height: (getScreenWidth(context) / 7 - 10) * 2 + 1,
          child: FlipClock(
            startTime: DateTime.now(),
            digitColor: Colors.white,
            backgroundColor: Colors.black,
            digitSize: getScreenWidth(context) / 7,
            borderRadius: const BorderRadius.all(Radius.circular(3.0)),
            width: getScreenWidth(context) / 7 - 10,
            height: (getScreenWidth(context) / 7 - 10) * 2,
            screenWidth: getScreenWidth(context),
            screenHeight: getScreenHeight(context),
          ),
        ),
      ),
    );
  }
}
