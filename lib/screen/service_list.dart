import 'package:dental_clinics/provider/access_token_provider.dart';
import 'package:dental_clinics/provider/fetch_data_provider.dart';
import 'package:dental_clinics/services/dio_exceptions.dart';
import 'package:dental_clinics/services/service_fetch_data.dart';
import 'package:dental_clinics/style/color_const.dart';
import 'package:dental_clinics/style/format.dart';
import 'package:dental_clinics/style/my_style.dart';
import 'package:dental_clinics/style/size_config.dart';
import 'package:dental_clinics/style/text_config.dart';
import 'package:dental_clinics/widget/button_checkout.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({Key key}) : super(key: key);

  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  bool isLoading = false;
  String _messageError;
  bool isSelection = false;
  final List<int> serviceID = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServiceFetchData()
        .serviceList(Provider.of<AccessTokenProvider>(context, listen: false)
            .accessToken)
        .then((value) {
      print('data $value');
      if (value['status']) {
        setState(() {
          isLoading = false;
        });
        Provider.of<FetchDataProvider>(context, listen: false)
            .saveServiceList(value);
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
        title: TextConfig().textHeadSizeCustom('ຈອງຄິວ', lightColor,
            FontWeight.bold, SizeConfig.screenWidth * 0.06),
        backgroundColor: whiteColor,
        elevation: 0.0,
        bottomOpacity: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: lightColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      bottomNavigationBar: SendRequestService(
        amountService: serviceID.length, arrayService: serviceID.join(","),
      ),
      body: fetchDataProvider.getServiceList == null
          ? Center(child: MyStyle().circleProgress())
          : Container(
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: fetchDataProvider.getServiceList.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(10),
                          vertical: getProportionateScreenHeight(2)),
                      child: Container(
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: lightColor.withOpacity(0.3),
                                  blurRadius: 5)
                            ]),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              fetchDataProvider
                                      .getServiceList.data[index].statusSelect =
                                  !fetchDataProvider
                                      .getServiceList.data[index].statusSelect;
                              print(
                                  'select : ${fetchDataProvider.getServiceList.data[index].statusSelect}');

                              if (fetchDataProvider.getServiceList.data[index]
                                      .statusSelect ==
                                  true) {
                                serviceID.add(fetchDataProvider
                                    .getServiceList.data[index].id);
                              } else if (fetchDataProvider.getServiceList
                                      .data[index].statusSelect ==
                                  false) {
                                serviceID.remove(fetchDataProvider
                                    .getServiceList.data[index].id);
                              }
                            });
                          },
                          title: TextConfig().textHeadSizeCustom(
                              '${fetchDataProvider.getServiceList.data[index].name.toString()}',
                              blackColor,
                              FontWeight.normal,
                              SizeConfig.screenWidth * 0.05),
                          subtitle: TextConfig().textHeadSizeCustom(
                              'ລາຄາ : ${currencyFormat.format(int.tryParse(fetchDataProvider.getServiceList.data[index].price.toString()))}',
                              greyColor,
                              FontWeight.normal,
                              SizeConfig.screenWidth * 0.045),
                          leading: Icon(
                            isSelection !=
                                    fetchDataProvider
                                        .getServiceList.data[index].statusSelect
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
