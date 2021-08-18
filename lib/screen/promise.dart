import 'package:dental_clinics/models/booking_list.dart';
import 'package:dental_clinics/provider/access_token_provider.dart';
import 'package:dental_clinics/provider/fetch_data_provider.dart';
import 'package:dental_clinics/services/dio_exceptions.dart';
import 'package:dental_clinics/services/service_fetch_data.dart';
import 'package:dental_clinics/style/color_const.dart';
import 'package:dental_clinics/style/my_style.dart';
import 'package:dental_clinics/style/size_config.dart';
import 'package:dental_clinics/style/text_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'home.dart';

class Promise extends StatefulWidget {
  const Promise({Key key}) : super(key: key);

  @override
  _PromiseState createState() => _PromiseState();
}

class _PromiseState extends State<Promise> {
  bool isLoading = false;
  int serviceId;
  String _messageError;

  ///data in model booking list
  List<Data> promise = [];

  Future<void> setListItems() async {
    Provider.of<FetchDataProvider>(context, listen: false)
        .getBookingList
        .data
        .forEach((element) {
      if (element.statusId == 2) {
        promise.add(element);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServiceFetchData()
        .bookingList(Provider.of<AccessTokenProvider>(context, listen: false)
            .accessToken)
        .then((value) {
      print('data $value');
      if (value['status']) {
        setState(() {
          isLoading = false;
        });
        Provider.of<FetchDataProvider>(context, listen: false)
            .saveBookingList(value);
        setListItems();
      }
    }).catchError(
      (onError) => {
        setState(() {
          _messageError = DioExceptions.fromDioError(onError).toString();
          Fluttertoast.showToast(
            msg: _messageError,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            fontSize: 25.0,
          );
        })
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final FetchDataProvider fetchDataProvider =
        Provider.of<FetchDataProvider>(context);
    SizeConfig().init(context);
    print('${fetchDataProvider.getBookingList.data[0].statusId == 2}');
    return Scaffold(
      appBar: AppBar(
        title: TextConfig().textHeadSizeCustom('ນັດໝາຍ', lightColor,
            FontWeight.bold, SizeConfig.screenWidth * 0.06),
        backgroundColor: whiteColor,
        elevation: 0.0,
        bottomOpacity: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: lightColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: fetchDataProvider.getBookingList.data[0].statusId != 2 ? Center(
        child: Text('ຍັງບໍ່ມີການນັດໝາຍ'),
      ) :  Container(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: promise.length,
            itemBuilder: (context, index) {
              var str = promise[index].timeBooking.toString();
              var newStr = str.substring(0, 10) + ' ' + str.substring(11, 19);
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(10),
                    vertical: getProportionateScreenHeight(5)),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: lightColor.withOpacity(0.3), blurRadius: 5)
                      ]),
                  child: Column(
                    children: [
                      Container(
                        child: TextConfig().textHeadSizeCustom(
                            'Doctor : ${promise[index].userReceive.toString()}',
                            blackColor,
                            FontWeight.w600,
                            SizeConfig.screenWidth * 0.055),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(10),
                            ),
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      TextConfig().textHeadSizeCustom(
                                          'ວັນທີ່ນັດໝາຍ : ',
                                          greyColor,
                                          FontWeight.w500,
                                          SizeConfig.screenWidth * 0.04),
                                      TextConfig().textHeadSizeCustom(
                                          '${promise[index].timeService.toString()}',
                                          blackColor,
                                          FontWeight.w500,
                                          SizeConfig.screenWidth * 0.035),
                                    ],
                                  ),
                                  TextConfig().textHeadSizeCustom(
                                      '${promise[index].timePeriod.toString()}',
                                      blackColor,
                                      FontWeight.w500,
                                      SizeConfig.screenWidth * 0.035),
                                  TextConfig().textHeadSizeCustom(
                                      'ລາຍການຂອງທ່ານມີ :',
                                      blackColor,
                                      FontWeight.w500,
                                      SizeConfig.screenWidth * 0.045),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          promise[index].serviceList.map((e) {
                                        return TextConfig().textHeadSizeCustom(
                                            '- $e',
                                            blackColor,
                                            FontWeight.normal,
                                            SizeConfig.screenWidth * 0.035);
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.screenHeight * 0.03,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _onAlertButtonsPressed(
                                  context, index, fetchDataProvider);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(15)),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(10),
                                    vertical: getProportionateScreenHeight(10)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border:
                                        Border.all(color: Colors.redAccent)),
                                child: Row(
                                  children: [
                                    Icon(Icons.cancel, color: Colors.redAccent),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * 0.01,
                                    ),
                                    Text('ຍົກເລີກ'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  _onAlertButtonsPressed(context, index, FetchDataProvider fetchDataProvider) {
    Alert(
      image: Image.asset('images/logo.png'),
      context: context,
      type: AlertType.warning,
      title: "ຢືນຢັນການຍົກເລີກຈອງຄິວ?",
      desc: "ຖ້າທ່ານຍົກເລີກແລ້ວຈະບໍ່ສາມາດກູ້ຄືນໃດ້ກົດຕົກລົງ",
      buttons: [
        DialogButton(
          child: Text(
            "ບໍ່ຕົກລົງ",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "ຕົກລົງ",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {
            serviceId = promise[index].id;
            print('service id : $serviceId');
            ServiceFetchData()
                .cancelServiceList(
                    Provider.of<AccessTokenProvider>(context, listen: false)
                        .accessToken,
                    serviceId)
                .then((value) {
              if (value['status']) {
                print('value cancel : $value');
                MyStyle().routePushNavigator(Home(), context);
                Fluttertoast.showToast(
                  timeInSecForIosWeb: 3,
                  msg: value['msg'],
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  backgroundColor: Colors.green.withOpacity(0.8),
                  fontSize: 25.0,
                );
              }
            }).catchError(
              (onError) => {
                setState(() {
                  _messageError =
                      DioExceptions.fromDioError(onError).toString();
                  Fluttertoast.showToast(
                    msg: _messageError,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red.withOpacity(0.8),
                    fontSize: 25.0,
                  );
                })
              },
            );
          },
          gradient: LinearGradient(colors: [Colors.redAccent, Colors.red[200]]),
        )
      ],
    ).show();
  }
}
