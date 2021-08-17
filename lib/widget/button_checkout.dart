import 'package:dental_clinics/provider/access_token_provider.dart';
import 'package:dental_clinics/screen/home.dart';
import 'package:dental_clinics/services/service_fetch_data.dart';
import 'package:dental_clinics/style/color_const.dart';
import 'package:dental_clinics/style/my_style.dart';
import 'package:dental_clinics/style/size_config.dart';
import 'package:dental_clinics/style/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SendRequestService extends StatefulWidget {
  final amountService, arrayService;
  const SendRequestService(
      {Key key, @required this.amountService, @required this.arrayService})
      : super(key: key);

  @override
  _SendRequestServiceState createState() => _SendRequestServiceState();
}

class _SendRequestServiceState extends State<SendRequestService> {
  DateTime date = DateTime.now();
  DateTime newDateTime;
  var amount;
  String valueDate;

  @override
  void initState() {
    super.initState();
    newDateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    print('$valueDate');
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
                    text: "ຈຳນວນ :\n",
                    style: TextStyle(
                        fontSize: SizeConfig.screenWidth * 0.05,
                        color: greyColor,
                        fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(
                        text: "${widget.amountService} ",
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth * 0.06,
                            color: primaryColor),
                      ),
                      TextSpan(
                        text: "ປະເພດ",
                        style: TextStyle(
                            fontSize: SizeConfig.screenWidth * 0.06,
                            color: Colors.black),
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
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: widget.arrayService == ''
                        ? null
                        : () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    title: Center(
                                        child: Text(
                                      'ກະລຸນາເລືອກ',
                                      style: TextStyle(
                                          color: blackColor,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 25),
                                    )),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height:
                                              SizeConfig.screenHeight * 0.07,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: primaryColor,
                                            ),
                                            onPressed: (){
                                              showSheet(
                                                context,
                                                child: buildDateTimePicker(),
                                                onClicked: () async {
                                                  setState(() {
                                                    valueDate = DateFormat(
                                                            'yyyy-MM-dd HH:mm:ss')
                                                        .format(date);
                                                  });
                                                  print(
                                                      'date time = $valueDate');
                                                  await ServiceFetchData()
                                                      .bookingServiceWithTime(
                                                      Provider.of<AccessTokenProvider>(
                                                          context,
                                                          listen: false)
                                                          .accessToken,
                                                      widget.arrayService,
                                                      valueDate)
                                                      .then((value) {
                                                    if (value['status']) {
                                                      print('value : $value');
                                                      Fluttertoast.showToast(
                                                        timeInSecForIosWeb: 3,
                                                        msg: value['msg'],
                                                        toastLength:
                                                        Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.TOP,
                                                        backgroundColor: Colors
                                                            .green
                                                            .withOpacity(0.8),
                                                        fontSize: 25.0
                                                      );
                                                    }
                                                  });
                                                  MyStyle().routePushNavigator(Home(), context);
                                                },
                                              );
                                            },
                                            child: TextConfig()
                                                .textHeadSizeCustom(
                                                    'ເລືອກວັນແລະເວລານັດ',
                                                    whiteColor,
                                                    FontWeight.normal,
                                                    SizeConfig.screenWidth *
                                                        0.05),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height:
                                              SizeConfig.screenHeight * 0.07,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: lightColor,
                                            ),
                                            onPressed: () {
                                              ServiceFetchData()
                                                  .bookingService(
                                                      Provider.of<AccessTokenProvider>(
                                                              context,
                                                              listen: false)
                                                          .accessToken,
                                                      widget.arrayService)
                                                  .then((value) {
                                                if (value['status']) {
                                                  print(
                                                      'value cancel : $value');
                                                  Fluttertoast.showToast(
                                                    timeInSecForIosWeb: 3,
                                                    msg: value['msg'],
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.TOP,
                                                    backgroundColor: Colors
                                                        .green
                                                        .withOpacity(0.8),
                                                    fontSize: 25.0,
                                                  );
                                                }
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: TextConfig()
                                                .textHeadSizeCustom(
                                                    'ໃຫ້ພະງານນັດໝາຍ',
                                                    whiteColor,
                                                    FontWeight.normal,
                                                    SizeConfig.screenWidth *
                                                        0.05),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.screenHeight * 0.01,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: TextConfig().textHeadSizeCustom(
                                            'ຂໍຂອບໃຈທີ່ໃຊ້ບໍລິການ',
                                            greyColor,
                                            FontWeight.normal,
                                            SizeConfig.screenWidth * 0.04),
                                      ),
                                    ],
                                  );
                                });
                          },
                    child: TextConfig().textHeadSizeCustom(
                        'ດຳເນີນການ',
                        whiteColor,
                        FontWeight.bold,
                        SizeConfig.screenWidth * 0.05),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateTimePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: date,
          mode: CupertinoDatePickerMode.dateAndTime,
          minimumDate: date,
          maximumDate: DateTime(2050),
          use24hFormat: true,
          onDateTimeChanged: (dateTime) => setState(() => this.date = dateTime),
        ),
      );

  static void showSheet(
    BuildContext context, {
    Widget child,
    VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            child: TextConfig().textHeadSizeCustom('ຕົກລົງ', blackColor,
                FontWeight.normal, SizeConfig.screenWidth * 0.05),
            onPressed: onClicked,
          ),
        ),
      );
}
