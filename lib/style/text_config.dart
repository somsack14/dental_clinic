import 'package:flutter/material.dart';

class TextConfig{
  Text textHeadSizeCustom(titleText,color,fontWeight,screenWidth) {
    return Text(
      titleText,
      style: TextStyle(
          color: color,
          fontSize: screenWidth,
          fontWeight: fontWeight,
          fontFamily: 'Lao'),
    );
  }
  TextConfig();
}