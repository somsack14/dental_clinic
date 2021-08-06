import 'package:dental_clinics/provider/fetch_data_provider.dart';
import 'package:dental_clinics/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/access_token_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FetchDataProvider>(
          create: (_) => FetchDataProvider() ,
        ),
        ChangeNotifierProvider<AccessTokenProvider>(
          create: (_) => AccessTokenProvider() ,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dental Clinic',
        theme: ThemeData(
          fontFamily: 'lao',
          primarySwatch: Colors.blue,
        ),
        home:SplashScreen(),
      ),
    );
  }
}
