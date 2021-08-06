import 'package:dental_clinics/style/color_const.dart';
import 'package:dental_clinics/style/size_config.dart';
import 'package:flutter/material.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key key,
    this.svgSrc,
    this.numOfItem = 0,
    this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfItem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: getProportionateScreenWidth(80),
            width: getProportionateScreenWidth(40),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(svgSrc,color: primaryColor,),
          ),
          if (numOfItem != 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfItem",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}