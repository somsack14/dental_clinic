import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    print("dioError${dioError.type}");
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = 'msgDioErrorTypeCANCEL';
        break;
      case DioErrorType.connectTimeout:
        message = 'msgDioErrorTypeCONNECT_TIMEOUT';
        break;
      case DioErrorType.other:
        message = 'msgDioErrorTypeDEFAULT';
        break;
      case DioErrorType.receiveTimeout:
        message = 'msgDioErrorTypeRECEIVE_TIMEOUT';
        break;
      case DioErrorType.response:
        print(dioError.response.data.toString());
        message = _handleError(dioError.response.statusCode,
            dioError.response.data['msg'].toString());
        break;
      case DioErrorType.sendTimeout:
        message = 'msgDioErrorTypeSEND_TIMEOUT';
        break;
      default:
        message = 'msgDioErrorTypeDEFAULTSUMETING';
        break;
    }
  }

  String message;
  GlobalKey<NavigatorState> navigatorKey;

  String _handleError(int statusCode, dynamic error) {
    print("error $error");
    print("error statusCode $statusCode");
    switch (statusCode) {
      case 400:
        return 'msgStatusCode400';
      case 401:
      // navigatorKey.currentState.pushNamedAndRemoveUntil(AppRoutes.sign_in_Route, (route) => false);
      // return Navigator.pushNamedAndRemoveUntil(context, AppRoutes.sign_in_Route, (route) => false);
        return 'msgStatusCode401';
      case 403:
        return 'msgStatusCode403';
      case 413:
        return 'msgStatusCode413';
      case 422:
        return error;
      case 404:
        return error["message"];
      case 500:
        return 'msgStatusCode500';
      case 503:
        return 'msgStatusCode503';
      default:
        return 'msgStatusCodeDefault';
    }
  }

  @override
  String toString() => message;
}