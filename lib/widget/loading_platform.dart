import 'dart:io';

import 'package:dental_clinics/style/color_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPlatform extends StatelessWidget {
  const LoadingPlatform({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Center(child: CupertinoActivityIndicator());
    } else {
      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(lightColor)));
    }
  }
}