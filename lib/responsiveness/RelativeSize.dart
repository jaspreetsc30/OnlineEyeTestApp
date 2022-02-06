import 'package:flutter/material.dart';

class RelativeSize {
  static MediaQueryData? _mediaQueryData ;
  static double? width ;
  static double? height;
  static double? relativeWidth;
  static double? relativeHeight;

  void initialize (BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData!.size.width;
    height = _mediaQueryData!.size.height;
    relativeWidth = width! / 100;
    relativeHeight = height! / 100;
  }


}
