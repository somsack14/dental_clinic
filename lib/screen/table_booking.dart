import 'package:dental_clinics/models/booking_list.dart';
import 'package:dental_clinics/provider/access_token_provider.dart';
import 'package:dental_clinics/provider/fetch_data_provider.dart';
import 'package:dental_clinics/services/dio_exceptions.dart';
import 'package:dental_clinics/services/service_fetch_data.dart';
import 'package:dental_clinics/style/color_const.dart';
import 'package:dental_clinics/style/size_config.dart';
import 'package:dental_clinics/style/text_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class TableBooking extends StatefulWidget {
  const TableBooking({Key key}) : super(key: key);

  @override
  _TableBookingState createState() => _TableBookingState();
}

class _TableBookingState extends State<TableBooking> {
  bool isLoading = false;
  int serviceId;
  String _messageError;

  List<Data> tableList = [];

  Future<void> setListItems() async {
    Provider.of<FetchDataProvider>(context, listen: false)
        .getBookingList
        .data
        .forEach((element) {
      if (element.statusId == 1) {
        tableList.add(element);
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

    return Scaffold(
      appBar: AppBar(
        title: TextConfig().textHeadSizeCustom('ຕາລາງນັດ', lightColor,
            FontWeight.bold, SizeConfig.screenWidth * 0.06),
        backgroundColor: whiteColor,
        elevation: 0.0,
        bottomOpacity: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: lightColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: tableList.length,
          itemBuilder: (context, index) {
            var str =
            tableList[index].timeBooking.toString();
            var newStr = str.substring(0, 10) +
                ' ເວລາ : ' +
                str.substring(11, 19);

            print('index : ${tableList[index].status}');
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: lightColor.withOpacity(0.3),
                          blurRadius: 5)
                    ]
                ),
                child: ListTile(
                  title : TextConfig().textHeadSizeCustom(
                      'ສະຖານະ : ${tableList[index].timePeriod.toString()}',
                      blackColor,
                      FontWeight.w500,
                      SizeConfig.screenWidth * 0.06),
                  subtitle:TextConfig()
                      .textHeadSizeCustom(
                      'ວັນທີ່ : $newStr',
                      greyColor,
                      FontWeight.normal,
                      SizeConfig
                          .screenWidth *
                          0.05),
                ),
              ),
            );
          }),
    );
  }
}
