import 'dart:async';

import 'package:dental_clinics/provider/access_token_provider.dart';
import 'package:dental_clinics/screen/login.dart';
import 'package:dental_clinics/services/auth_service.dart';
import 'package:dental_clinics/style/my_style.dart';
import 'package:dental_clinics/style/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  void getLocalToken()async{
    final SharedPreferences prefs = await _prefs;
    Provider.of<AccessTokenProvider>(context, listen: false)
        .setAccessToken(prefs.getString('token'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalToken();
    AuthService().checkToken(context, _prefs);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    print('');
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: MyStyle().buildBackground(),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Image.asset('images/logo.png',height: SizeConfig.screenHeight*0.2,),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05,),
                MyStyle().circleProgress(),
              ],
            ),
          )
        ],
      ),
    );
  }


}
