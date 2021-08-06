import 'package:dental_clinics/provider/access_token_provider.dart';
import 'package:dental_clinics/provider/fetch_data_provider.dart';
import 'package:dental_clinics/screen/home.dart';
import 'package:dental_clinics/screen/login.dart';
import 'package:dental_clinics/services/url_api.dart';
import 'package:dental_clinics/style/constant.dart';
import 'package:dental_clinics/style/my_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  Response response;
  Dio _dio;

  AuthService() {
    // ignore: unnecessary_null_comparison
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
          baseUrl: urlAPI,
          connectTimeout: 10000,
          receiveTimeout: 3000);
      _dio = new Dio(options);
    }
  }

  /// Function login
  Future login(
      username,
      password,
      _fcmToken,
      context,
      ) async {
    String url = '$urlAPI/api/client-login';
    response = await _dio.post(url.toString(), data: {
      'username': '$username',
      'password': '$password',
      'device_token': '$_fcmToken'
    });
    return response.data;
  }

  /// Function logout
  Future logOut(context) async {
    String url = '$urlAPI/api/logout';
    final AccessTokenProvider accessTokenProvider =
    Provider.of<AccessTokenProvider>(context, listen: false);
    try {
      response = await _dio.post(url.toString(),
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${accessTokenProvider.getAccessToken}',
          }));
      if (response.data['status'] == true) {
        if (response.data['msg'] == 'logout') {
          response.data['msg'] = ConstText.Logout;
        }
        MyStyle().routePushAndRemove(Login(), context);
        Fluttertoast.showToast(
          msg: response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          fontSize: 25.0,
        );
      } else {
        print(response.data);
      }
    } on DioError catch (e) {
      print('error ${e.response.data}');
      if (e.response.data['message' == 'Unauthenticated.']) {
        MyStyle().routePushAndRemove(Login(), context);
      }
    }
  }


  Future<Null> checkToken(context, _prefs) async {
    final SharedPreferences prefs = await _prefs;
    var _getToken = prefs.getString('token');
    String url = '$urlAPI/api/client-info';
    try {
      response = await _dio.post(url.toString(),
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $_getToken',
          }));
      if (response.data['status'] == true) {
        Provider.of<FetchDataProvider>(context, listen: false)
            .saveClientInfoProvider(response.data);
        MyStyle().routePushAndRemove(Home(), context);
        print('token = $_getToken');
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        // ...
        MyStyle().routePushAndRemove(Login(), context);
        Fluttertoast.showToast(
          msg: 'Time Out',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          fontSize: 25.0,
        );
      }
      if (e.type == DioErrorType.receiveTimeout) {
        MyStyle().routePushAndRemove(Login(), context);
        Fluttertoast.showToast(
          msg: 'Receive Timeout',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          fontSize: 25.0,
        );
      }
      if (e.response.data['message'] == 'Unauthenticated.') {
        MyStyle().routePushAndRemove(Login(), context);
        print('sack');
      } else {
        print(e.response.data);
      }
    }
  }
}