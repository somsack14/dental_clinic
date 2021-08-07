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
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'home.dart';

class BookingList extends StatefulWidget {
  const BookingList({Key key}) : super(key: key);

  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  bool isLoading = false;
  int serviceId;
  String _messageError;

  List<Data> newContent = [];
  List<Data> oldContent = [];

  Future<void> setListItems() async {
    Provider.of<FetchDataProvider>(context, listen: false)
        .getBookingList
        .data
        .forEach((element) {
      if (element.statusId != 1) {
        oldContent.add(element);
      } else {
        newContent.add(element);
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

    print('old : ${oldContent.length}  ,  new ${newContent.length}');
    return Scaffold(
      appBar: AppBar(
        title: TextConfig().textHeadSizeCustom('ຍົກເລີກການຈອງ', lightColor,
            FontWeight.bold, SizeConfig.screenWidth * 0.06),
        backgroundColor: whiteColor,
        elevation: 0.0,
        bottomOpacity: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: lightColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: fetchDataProvider.getBookingList == null
          ? Center(child: MyStyle().circleProgress())
          : fetchDataProvider.getBookingList.data.length <= 0
              ? Center(child: Text('ຍັງບໍ່ມີການຈອງ'))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: newContent.length,
                            itemBuilder: (context, index) {
                              var str =
                                  newContent[index].timeBooking.toString();
                              var newStr = str.substring(0, 10) +
                                  ' ' +
                                  str.substring(11, 19);
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
                                            color: lightColor.withOpacity(0.3),
                                            blurRadius: 5)
                                      ]),
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  getProportionateScreenWidth(
                                                      20),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top:
                                                      getProportionateScreenHeight(
                                                          25)),
                                              child: Column(
                                                children: [
                                                  TextConfig()
                                                      .textHeadSizeCustom(
                                                          'ລາຍການຂອງທ່ານມີ :',
                                                          blackColor,
                                                          FontWeight.w500,
                                                          SizeConfig
                                                                  .screenWidth *
                                                              0.05),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: newContent[index]
                                                        .serviceList
                                                        .map((e) {
                                                      return TextConfig()
                                                          .textHeadSizeCustom(
                                                              '- $e',
                                                              blackColor,
                                                              FontWeight.normal,
                                                              SizeConfig
                                                                      .screenWidth *
                                                                  0.045);
                                                    }).toList(),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical:
                                                            getProportionateScreenHeight(
                                                                10)),
                                                    child: TextConfig()
                                                        .textHeadSizeCustom(
                                                            '$newStr',
                                                            greyColor,
                                                            FontWeight.w500,
                                                            SizeConfig
                                                                    .screenWidth *
                                                                0.03),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _onAlertButtonsPressed(context,
                                                  index, fetchDataProvider);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      getProportionateScreenWidth(
                                                          15)),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        getProportionateScreenWidth(
                                                            10),
                                                    vertical:
                                                        getProportionateScreenHeight(
                                                            5)),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color:
                                                            Colors.redAccent)),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.cancel,
                                                        color:
                                                            Colors.redAccent),
                                                    SizedBox(
                                                      width: SizeConfig
                                                              .screenWidth *
                                                          0.01,
                                                    ),
                                                    Text('ຍົກເລີກ'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        child: ClipPath(
                                          clipper: PointsClipper(),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    getProportionateScreenHeight(
                                                        6)),
                                            color: Colors.yellow[700],
                                            child: Center(
                                              child: TextConfig()
                                                  .textHeadSizeCustom(
                                                      'ສະຖານະ : ${newContent[index].status.toString()}',
                                                      whiteColor,
                                                      FontWeight.w500,
                                                      SizeConfig.screenWidth *
                                                          0.032),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: getProportionateScreenHeight(10)),
                        child: TextConfig().textHeadSizeCustom(
                            'ການຈອງຄີວທີ່ເຄີຍຍົກເລີກ :',
                            lightColor,
                            FontWeight.bold,
                            SizeConfig.screenWidth * 0.06),
                      ),
                      Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: oldContent.length,
                            itemBuilder: (context, index) {
                              var str =
                                  oldContent[index].timeBooking.toString();
                              var newStr = str.substring(0, 10) +
                                  ' ' +
                                  str.substring(11, 19);
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getProportionateScreenWidth(10),
                                    vertical: getProportionateScreenHeight(5)),
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: lightColor.withOpacity(0.3),
                                            blurRadius: 5)
                                      ]),
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  getProportionateScreenWidth(
                                                      20),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top:
                                                      getProportionateScreenHeight(
                                                          25)),
                                              child: Column(
                                                children: [
                                                  TextConfig()
                                                      .textHeadSizeCustom(
                                                          'ລາຍການຂອງທ່ານມີ :',
                                                          blackColor,
                                                          FontWeight.w500,
                                                          SizeConfig
                                                                  .screenWidth *
                                                              0.05),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: oldContent[index]
                                                        .serviceList
                                                        .map((e) {
                                                      return TextConfig()
                                                          .textHeadSizeCustom(
                                                              '- $e',
                                                              blackColor,
                                                              FontWeight.normal,
                                                              SizeConfig
                                                                      .screenWidth *
                                                                  0.045);
                                                    }).toList(),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical:
                                                            getProportionateScreenHeight(
                                                                10)),
                                                    child: TextConfig()
                                                        .textHeadSizeCustom(
                                                            '$newStr',
                                                            greyColor,
                                                            FontWeight.w500,
                                                            SizeConfig
                                                                    .screenWidth *
                                                                0.03),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap:() {
                                                  },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      getProportionateScreenWidth(
                                                          15)),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        getProportionateScreenWidth(
                                                            10),
                                                    vertical:
                                                        getProportionateScreenHeight(
                                                            5)),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: greyColor)),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.cancel,
                                                        color: greyColor),
                                                    SizedBox(
                                                      width: SizeConfig
                                                              .screenWidth *
                                                          0.01,
                                                    ),
                                                    Text('ຍົກເລີກ'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        child: ClipPath(
                                          clipper: PointsClipper(),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    getProportionateScreenHeight(
                                                        6)),
                                            color: oldContent[index].statusId ==
                                                    2
                                                ? Colors.green
                                                : oldContent[index].statusId ==
                                                        3
                                                    ? Colors.redAccent
                                                    : Colors.yellow[700],
                                            child: Center(
                                              child: TextConfig()
                                                  .textHeadSizeCustom(
                                                      'ສະຖານະ : ${oldContent[index].status.toString()}',
                                                      whiteColor,
                                                      FontWeight.w500,
                                                      SizeConfig.screenWidth *
                                                          0.032),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
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
            serviceId = newContent[index].id;
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
