import 'package:dental_clinics/provider/access_token_provider.dart';
import 'package:dental_clinics/provider/fetch_data_provider.dart';
import 'package:dental_clinics/services/auth_service.dart';
import 'package:dental_clinics/services/dio_exceptions.dart';
import 'package:dental_clinics/style/color_const.dart';
import 'package:dental_clinics/style/constant.dart';
import 'package:dental_clinics/style/my_style.dart';
import 'package:dental_clinics/style/size_config.dart';
import 'package:dental_clinics/style/text_config.dart';
import 'package:dental_clinics/widget/loading_platform.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _isLoggedIn = false;
  String username, password;
  String _messageError;
  String _fcmToken = 'test';
  bool eye = true, validateCheck;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child:Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: _isLoggedIn,
          progressIndicator: LoadingPlatform(),
          child: Container(
            child: Stack(
              children: [
                Positioned(child: MyStyle().buildBackground()),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: Image.asset(
                          'images/logo.png',
                          height: SizeConfig.screenHeight * 0.15,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.02,
                      ),
                      Form(
                        autovalidateMode: _autoValidate,
                        key: formkey,
                        child: Column(
                          children: [
                            inputUsername(),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.01,
                            ),
                            inputPassword(),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            buttonLogin(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: getProportionateScreenHeight(20),
                  left: 0,
                  right: 0,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextConfig().textHeadSizeCustom(
                            ConstText.DontHaveAccount,
                            lightColor,
                            FontWeight.bold,
                            SizeConfig.screenWidth * 0.05),
                        TextButton(
                            onPressed: () {},
                            child: TextConfig().textHeadSizeCustom(
                                ConstText.ClinicContact,
                                primaryColor,
                                FontWeight.bold,
                                SizeConfig.screenWidth * 0.05))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputUsername() {
    return Container(
      height: SizeConfig.screenHeight* 0.09,
      width: SizeConfig.screenWidth * 0.7,
      child: TextFormField(
        style: TextStyle(fontSize: SizeConfig.screenWidth * 0.045),
        onChanged: (value) {
          username = value.trim();
        },
        validator: (value) {
          if (value.isEmpty) {
            _isLoggedIn = false;
            return "${ConstText.PleaseEnterUsername}";
          } else
            return null;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: lightColor),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
          prefixIcon: Icon(
            Icons.person,
            color: primaryColor,
          ),
          labelText: ConstText.Username,
          labelStyle: TextStyle(color: lightColor, fontSize: 20),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: lightColor),
            borderRadius: BorderRadius.circular(15),
          ),
          errorStyle: TextStyle(color: Colors.red),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget inputPassword() {
    return Container(
      height: SizeConfig.screenHeight * 0.09,
      width: SizeConfig.screenWidth * 0.7,
      child: TextFormField(
        style: TextStyle(fontSize: SizeConfig.screenWidth * 0.045),
        validator: (value) {
          if (value.isEmpty) {
            _isLoggedIn = false;
            return "${ConstText.PleaseEnterPassword}";
          } else {
            return null;
          }
        },
        obscureText: eye,
        cursorColor: lightColor,
        onChanged: (value) {
          password = value.trim();
        },
        decoration: MyStyle().myDecorationPassword(eye, () {
          setState(() {
            eye = !eye;
          });
        }),
      ),
    );
  }

  Container buttonLogin() {
    return Container(
      height: SizeConfig.screenHeight * 0.06,
      width: SizeConfig.screenWidth * 0.7,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: lightColor,
            shadowColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: () async {
          setState(() {
            _isLoggedIn = true;
          });
          if (formkey.currentState.validate()) {
            await AuthService()
                .login(username, password, _fcmToken, context)
                .then((value) async {
              if (value['status']==true) {
                var getToken = value['data']['token'];
                final SharedPreferences prefs = await _prefs;
                prefs.setString('token', getToken);
                print('token $getToken');
                try {
                  Provider.of<AccessTokenProvider>(context, listen: false)
                      .setAccessToken(getToken);
                } catch (e) {
                  print('SharedPreferences=> $e');
                }

                Provider.of<FetchDataProvider>(context, listen: false)
                    .saveClientInfoProvider(value);

                print('data $value');
                setState(() {
                  _isLoggedIn = true;
                  print('_isLoggedIn = $_isLoggedIn');
                });
                MyStyle().routePushAndRemove(Home(), context);
              }
            }).catchError(
              (onError) {
                setState(() {
                  _isLoggedIn = false;
                  _messageError =
                      DioExceptions.fromDioError(onError).toString();
                });
                Fluttertoast.showToast(
                  msg: _messageError,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red.withOpacity(0.8),
                  fontSize: 25.0,
                );
              },
            );
          } else {
            setState(() {
              _autoValidate = AutovalidateMode.onUserInteraction;
            });
          }
        },
        child: TextConfig().textHeadSizeCustom(ConstText.Login, whiteColor,
            FontWeight.bold, SizeConfig.screenWidth * 0.05),
      ),
    );
  }
}
