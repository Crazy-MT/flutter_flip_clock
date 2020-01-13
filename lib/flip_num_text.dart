import 'dart:math';

import 'package:flutter/material.dart';

class FlipNumText extends StatefulWidget {
  final int num;

  FlipNumText(this.num);

  @override
  _FlipNumTextState createState() => _FlipNumTextState();
}

class _FlipNumTextState extends State<FlipNumText>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  bool _isReversePhase = false;

  double _zeroAngle = 0.0001;

  int _stateNum = 0;

  @override
  void initState() {
    super.initState();
    print("initState");
    _stateNum = widget.num;
    _controller = new AnimationController(
        duration: Duration(milliseconds: 450), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
          _isReversePhase = true;
          print("AnimationStatus.completed");
        }
        if (status == AnimationStatus.dismissed) {
          _isReversePhase = false;
          _stateNum += 1;
          print("AnimationStatus.dismissed");
        }
      })
      ..addListener(() {
        setState(() {});
      });
    _animation = Tween(begin: _zeroAngle, end: pi / 2).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Stack(
        children: <Widget>[
          _clipNum(),
        ],
      ),
    );
  }

  _clipNum() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: <Widget>[
            ClipRectText(_stateNum + 1, Alignment.topCenter),
            Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.006)
                  ..rotateX(_isReversePhase ? pi / 2 : _animation.value),
                alignment: Alignment.bottomCenter,
                child: ClipRectText(_stateNum, Alignment.topCenter)),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.0),
        ),
        Stack(
          children: <Widget>[
            ClipRectText(_stateNum, Alignment.bottomCenter),
            Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.006)
                  ..rotateX(_isReversePhase ? -_animation.value : pi / 2),
                alignment: Alignment.topCenter,
                child: ClipRectText(_stateNum + 1, Alignment.bottomCenter)),
          ],
        )
      ],
    );
  }

  @override
  void didUpdateWidget(FlipNumText oldWidget) {
    if (this.widget.num != oldWidget.num) {
      _controller.forward();
      print("didUpdateWidget $_stateNum --- ${oldWidget.num}");
      _stateNum = oldWidget.num;
    }
    super.didUpdateWidget(oldWidget);

//    setState(() {
//      _stateNum = oldWidget.num;
//    });
  }
}

class ClipRectText extends StatelessWidget {
  final int _value;
  final Alignment _alignment;

  ClipRectText(this._value, this._alignment);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: _alignment,
        heightFactor: 0.5,
        child: Container(
          alignment: Alignment.center,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            "$_value",
            style: TextStyle(
              fontSize: 80,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}