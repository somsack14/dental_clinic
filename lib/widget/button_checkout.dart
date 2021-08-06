import 'package:dental_clinics/style/color_const.dart';
import 'package:dental_clinics/style/size_config.dart';
import 'package:dental_clinics/style/text_config.dart';
import 'package:flutter/material.dart';
class SendRequestService extends StatefulWidget {
  final amountService;
  const SendRequestService({
    Key key, @required this.amountService
  }) : super(key: key);

  @override
  _SendRequestServiceState createState() => _SendRequestServiceState();
}

class _SendRequestServiceState extends State<SendRequestService> {

  var amount;
  @override
  Widget build(BuildContext context) {


    setState(() {

      print('amount check out =  $amount');
    });
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -1),
            blurRadius: 20,
            color: Colors.grey[300],
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "ຈຳນວນ :\n",style:  TextStyle(fontSize: SizeConfig.screenWidth * 0.05, color: greyColor,fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(
                        text: "${widget.amountService} ",
                        style: TextStyle(fontSize: SizeConfig.screenWidth * 0.06, color: primaryColor),
                      ),
                      TextSpan(
                        text: "ປະເພດ",
                        style: TextStyle(fontSize: SizeConfig.screenWidth * 0.06, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: SizeConfig.screenHeight * 0.07,
                  width: getProportionateScreenWidth(190),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: lightColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        )
                    ),
                    onPressed:(){
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SelectProductLoan()));
                    },
                    child: TextConfig().textHeadSizeCustom('ດຳເນີນການ', whiteColor, FontWeight.bold, SizeConfig.screenWidth * 0.05),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}