import 'package:flutter/material.dart';

class MyRaisedButton extends StatelessWidget {

  MyRaisedButton({this.mColor, this.mPressed, this.mChild,this.borderRadius = 4.0,this.mheight = 45.0});

  final mColor;
  Function mPressed;
  Widget mChild;
  final borderRadius;
  final mheight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mheight,
      child: RaisedButton(
        color: mColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        onPressed: mPressed,
        child: mChild,
      ),
    );
  }


}