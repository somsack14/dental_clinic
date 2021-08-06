import 'package:flutter/foundation.dart';

class AccessTokenProvider with ChangeNotifier {

  String accessToken = '';
  String get getAccessToken => accessToken;

  void setAccessToken(token) async {
    accessToken = token.toString();
  }
  // String fcmToken = '';
  // String get getFcmToken => fcmToken;
  // void setFcmToken(v) {
  //   fcmToken = v;
  //   notifyListeners();
  // }
}