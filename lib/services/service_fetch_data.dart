import 'package:dental_clinics/services/url_api.dart';
import 'package:dio/dio.dart';

class ServiceFetchData{
  Response response;
  Dio _dio;

  ServiceFetchData() {
    // ignore: unnecessary_null_comparison
    if (_dio == null) {
      BaseOptions options = new BaseOptions(
          baseUrl: urlAPI,
          connectTimeout: 10000,
          receiveTimeout: 3000);
      _dio = new Dio(options);
    }
  }

  ///service list
  Future serviceList (accessToken) async {
    String url = '$urlAPI/api/service-list';
    response = await _dio.post(
      url.toString(),
      options: Options(headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      }),
    );
    return response.data;
  }


  /// booking list
  Future bookingList(accessToken) async {
    String url = '$urlAPI/api/booking-list';
    response = await _dio.post(
      url.toString(),
      options: Options(headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      }),
    );
    return response.data;
  }
}