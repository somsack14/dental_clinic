
import 'package:dental_clinics/style/constant.dart';
import 'package:dental_clinics/style/size_config.dart';
import 'package:flutter/material.dart';

import 'color_const.dart';

class MyStyle{

  ///Decoration password
  InputDecoration myDecorationPassword(eye, _onPressed) {
    return InputDecoration(
      prefixIcon: Icon(
        Icons.lock,
        color: primaryColor,
      ),
      suffixIcon: IconButton(
          icon: eye
              ? Icon(
            Icons.remove_red_eye,
            color: primaryColor,
          )
              : Icon(
            Icons.remove_red_eye_sharp,
            color: lightColor,
          ),
          onPressed: _onPressed),
      labelStyle: TextStyle(color: lightColor,fontSize: 20),
      labelText: ConstText.Password,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: lightColor,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lightColor),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      errorStyle: TextStyle(color: Colors.red),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  ///Progress Indicator
  CircularProgressIndicator circleProgress() {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
    );
  }


  ///Route to service
  void routePushAndRemove( Widget myWidget,context) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context)=> myWidget,);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  void routePushNavigator (Widget myWidget,context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => myWidget));
  }


  ///Background
  Container buildBackground() {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Image.asset(
                'images/background-top.png',
                height: SizeConfig.screenHeight * 0.5,
                color: lightColor.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Image.asset(
                'images/background-bottom-right.png',
                height: SizeConfig.screenHeight * 0.4,
                color: primaryColor.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Image.asset(
                'images/background-bottom-right.png',
                height: SizeConfig.screenHeight * 0.35,
                color: primaryColor.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Image.asset(
                'images/background-top.png',
                height: SizeConfig.screenHeight * 0.4,
                color: lightColor.withOpacity(0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  MyStyle();
}