
import 'package:dental_clinics/models/bill_list_model.dart';
import 'package:dental_clinics/models/booking_list.dart';
import 'package:dental_clinics/models/client_info_model.dart';
import 'package:dental_clinics/models/service_list_model.dart';
import 'package:flutter/cupertino.dart';

class FetchDataProvider extends ChangeNotifier{

  ///save data client to provider
  ClientInfo _clientInfo;
  ClientInfo get getModelInfo => _clientInfo;

  void saveClientInfoProvider(value){
    _clientInfo = ClientInfo.fromJson(value);
    notifyListeners();
  }
  ///Service list
  ServiceList _serviceList;
  ServiceList get getServiceList => _serviceList;

  void saveServiceList(value){
    _serviceList = ServiceList.fromJson(value);
    notifyListeners();
  }

  ///get booking list and add to provider
  BookingList _bookingList;
  BookingList get getBookingList => _bookingList;

  void saveBookingList(value){
    _bookingList = BookingList.fromJson(value);
    notifyListeners();
  }

  BillList _billList;
  BillList get getBillList => _billList;

  void saveBillList(value){
    _billList = BillList.fromJson(value);
    notifyListeners();
  }


}