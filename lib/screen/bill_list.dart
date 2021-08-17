import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:dental_clinics/provider/access_token_provider.dart';
import 'package:dental_clinics/provider/fetch_data_provider.dart';
import 'package:dental_clinics/services/dio_exceptions.dart';
import 'package:dental_clinics/services/service_fetch_data.dart';
import 'package:dental_clinics/style/color_const.dart';
import 'package:dental_clinics/style/format.dart';
import 'package:dental_clinics/style/my_style.dart';
import 'package:dental_clinics/style/size_config.dart';
import 'package:dental_clinics/style/text_config.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BillList extends StatefulWidget {
  const BillList({Key key}) : super(key: key);

  @override
  _BillListState createState() => _BillListState();
}

class _BillListState extends State<BillList> {
  bool isLoading = false;
  String _messageError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServiceFetchData()
        .billList(Provider.of<AccessTokenProvider>(context, listen: false)
            .accessToken)
        .then((value) {
      print('data $value');
      if (value['status']) {
        setState(() {
          isLoading = false;
        });
        Provider.of<FetchDataProvider>(context, listen: false)
            .saveBillList(value);
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

    return Scaffold(
      appBar: AppBar(
        title: TextConfig().textHeadSizeCustom('ບິນຂອງທ່ານ', lightColor,
            FontWeight.bold, SizeConfig.screenWidth * 0.06),
        backgroundColor: whiteColor,
        elevation: 0.0,
        bottomOpacity: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: lightColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: fetchDataProvider.getBillList == null
          ? Center(child: MyStyle().circleProgress())
          : fetchDataProvider.getBillList.data.isEmpty
              ? Center(
                  child: Text('ຍັງບໍ່ມີການຊຳລະ'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: fetchDataProvider.getBillList.data.length,
                  itemBuilder: (context, index) {
                    var str = fetchDataProvider
                        .getBillList.data[index].timeService
                        .toString();
                    var newStr =
                        str.substring(0, 10) + ' ' + str.substring(11, 19);
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: getProportionateScreenHeight(20),
                          horizontal: getProportionateScreenWidth(40)),
                      color: whiteColor,
                      child: FDottedLine(
                        color: blackColor,
                        strokeWidth: 2.0,
                        dottedLength: 8.0,
                        space: 3.0,
                        corner: FDottedLineCorner.all(6.0),

                        /// add widget
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(20)),
                          width: SizeConfig.screenWidth,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                "ໃບບິນ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23.0,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.03,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenHeight(20)),
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: fetchDataProvider.getBillList
                                        .data[index].billDetail.length,
                                    itemBuilder: (context, element) {
                                      return Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextConfig().textHeadSizeCustom(
                                                '${fetchDataProvider.getBillList.data[index].billDetail[element].nameService.toString()}  x${fetchDataProvider.getBillList.data[index].billDetail[element].amount.toString()}',
                                                greyColor,
                                                FontWeight.normal,
                                                SizeConfig.screenWidth * 0.05),
                                            TextConfig().textHeadSizeCustom(
                                                '${currencyFormat.format(int.tryParse(fetchDataProvider.getBillList.data[index].billDetail[element].price.toString()))}',
                                                greyColor,
                                                FontWeight.normal,
                                                SizeConfig.screenWidth * 0.045),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.05,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenWidth(40)),
                                child: FDottedLine(
                                  color: blackColor,
                                  width: double.infinity,
                                  dottedLength: 2.0,
                                  strokeWidth: 5.0,
                                  space: 3.0,
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.01,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenHeight(20)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextConfig().textHeadSizeCustom(
                                        'ລາຄາລວມ :',
                                        greyColor,
                                        FontWeight.normal,
                                        SizeConfig.screenWidth * 0.05),
                                    TextConfig().textHeadSizeCustom(
                                        '${currencyFormat.format(int.tryParse(fetchDataProvider.getBillList.data[index].payPrice.toString()))}',
                                        greyColor,
                                        FontWeight.normal,
                                        SizeConfig.screenWidth * 0.045),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.05,
                              ),
                              Container(
                                child: BarCodeImage(
                                  params: Code39BarCodeParams(
                                    "1234ABCD",
                                    lineWidth:
                                        2.0, // width for a single black/white bar (default: 2.0)
                                    barHeight:
                                        90.0, // height for the entire widget (default: 100.0)
                                    withText:
                                        true, // Render with text label or not (default: false)
                                  ),
                                  onError: (error) {
                                    // Error handler
                                    print('error = $error');
                                  },
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.03,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: TextConfig().textHeadSizeCustom(
                                        '$newStr',
                                        greyColor,
                                        FontWeight.normal,
                                        SizeConfig.screenWidth * 0.035),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
    );
  }
}
