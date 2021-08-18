import 'package:dental_clinics/provider/fetch_data_provider.dart';
import 'package:dental_clinics/screen/bill_list.dart';
import 'package:dental_clinics/screen/booking_list_cancel.dart';
import 'package:dental_clinics/screen/content.dart';
import 'package:dental_clinics/screen/promise.dart';
import 'package:dental_clinics/screen/service_list.dart';
import 'package:dental_clinics/services/auth_service.dart';
import 'package:dental_clinics/style/color_const.dart';
import 'package:dental_clinics/style/constant.dart';
import 'package:dental_clinics/style/my_style.dart';
import 'package:dental_clinics/style/size_config.dart';
import 'package:dental_clinics/style/text_config.dart';
import 'package:dental_clinics/widget/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final FetchDataProvider fetchDataProvider =
    Provider.of<FetchDataProvider>(context);
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        bottomOpacity: 0.0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: primaryColor,
              size: SizeConfig.screenHeight * 0.04,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        // actions: [
        //   IconBtnWithCounter(
        //     svgSrc: 'images/bell.png',
        //     press: () {},
        //     numOfItem: 10,
        //   ),
        // ],
      ),
      drawer: menuDrawer(context,fetchDataProvider),
      backgroundColor: whiteColor,
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextConfig().textHeadSizeCustom('Dental Clinic', lightColor,
                    FontWeight.bold, SizeConfig.screenWidth * 0.07),
                TextConfig().textHeadSizeCustom('Dr. Tou', primaryColor,
                    FontWeight.bold, SizeConfig.screenWidth * 0.06),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            child: TextConfig().textHeadSizeCustom('ເມນູ', blackColor,
                FontWeight.bold, SizeConfig.screenWidth * 0.05),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(30)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    boxMenu('ຈອງຄິວ', 'images/tooth.png', () {
                      MyStyle().routePushNavigator(ServiceList(), context);
                    },
                        Colors.blueAccent, false),
                    boxMenu('ບິນ', 'images/bill_icon.png', () {
                      MyStyle().routePushNavigator(BillList(), context);
                    },
                        Colors.orangeAccent, false),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    boxMenu('ນັດໝາຍ', 'images/calender.png', () {
                      MyStyle().routePushNavigator(Promise(), context);
                    },
                        Colors.blueAccent, true),
                    boxMenu('ຍົກເລີກການຈອງ', 'images/eye.png', () {
                      MyStyle().routePushNavigator(BookingList(), context);
                    },
                        Colors.redAccent, false),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            child: TextConfig().textHeadSizeCustom('ຄຳແນະນຳ', blackColor,
                FontWeight.bold, SizeConfig.screenWidth * 0.05),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
            child: InkWell(
              onTap: () {
                MyStyle().routePushNavigator(ContentClinic(), context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: greyColor.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(1.0, 0.1))
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Container(
                          color: Colors.red,
                          width: SizeConfig.screenWidth * 0.18,
                          height: SizeConfig.screenHeight * 0.08,
                          child: Icon(Icons.cake, color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextConfig().textHeadSizeCustom(
                                  'ການຮັກສາສຸຂະພາບແຂ້ວ',
                                  blackColor,
                                  FontWeight.bold,
                                  SizeConfig.screenWidth * 0.04),
                              Text('ການຮັກສາຈະຕ້ອງຖອນແຂ້ວ..',
                                  style: TextStyle(color: Colors.grey))
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.blue),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget boxMenu(title, pathImg, _onTap, color, bool) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: SizeConfig.screenWidth * 0.35,
        height: SizeConfig.screenHeight * 0.18,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenWidth(20)),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                          color: greyColor.withOpacity(0.5),
                          blurRadius: 10,
                          offset: Offset(1.0, 0.1)),
                    ]),
                width: SizeConfig.screenWidth * 0.3,
                height: SizeConfig.screenHeight * 0.15,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(20)),
                      child: TextConfig().textHeadSizeCustom(title, blackColor,
                          FontWeight.normal, SizeConfig.screenWidth * 0.048),
                    )),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius:
                        BorderRadius.circular(getProportionateScreenWidth(20))),
                width: SizeConfig.screenWidth * 0.25,
                height: SizeConfig.screenHeight * 0.1,
                child: bool == true
                    ? Image.asset(
                        pathImg,
                      )
                    : Image.asset(
                        pathImg,
                        color: whiteColor,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer menuDrawer(BuildContext context,FetchDataProvider fetchDataProvider) {
    return Drawer(
      child: ListView(
        physics: ClampingScrollPhysics(),
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage('images/logo.png'),
              ),
            ),
            child: Text(''),
          ),
          Container(
            decoration: BoxDecoration(
                color: lightColor,
              boxShadow: [BoxShadow(
                color: greyColor.withOpacity(0.4),
                blurRadius: 10
              )]
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
              child: Center(
                child: TextConfig().textHeadSizeCustom(
                    '${fetchDataProvider.getModelInfo.data.firstname.toString()} ${fetchDataProvider.getModelInfo.data.lastname.toString()}',
                    whiteColor,
                    FontWeight.bold,
                    SizeConfig.screenWidth* 0.07),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.01,),
          showTitle('ທີ່ຢູ່ : ${fetchDataProvider.getModelInfo.data.address.toString()}'),
          showTitle('ເບີໂທ : ${fetchDataProvider.getModelInfo.data.phone.toString()}'),
          showTitle('ວັນເດືອນປີເກີດ : ${fetchDataProvider.getModelInfo.data.birthday.toString()}'),
          SizedBox(height: SizeConfig.screenHeight * 0.03,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(50),vertical: getProportionateScreenHeight(10)),
            child: MaterialButton(
              height: SizeConfig.screenHeight *0.06,
              minWidth: 300,
              color: lightColor,
              shape: StadiumBorder(),
              onPressed: () {
                AuthService().logOut(context);
              },
              child: Text(ConstText.Logout,
                  style: TextStyle(color: Colors.white, fontSize: SizeConfig.screenWidth * 0.05)),
            ),
          ),
        ],
      ),
    );
  }

  Padding showTitle(title) {
    return Padding(
          padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(3),horizontal: getProportionateScreenWidth(10)),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
                boxShadow: [BoxShadow(
                    color: greyColor.withOpacity(0.4),
                    blurRadius: 10
                )]
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
              child: TextConfig().textHeadSizeCustom(
                  title,
                  blackColor.withOpacity(0.8),
                  FontWeight.normal,
                  SizeConfig.screenWidth* 0.05),
            ),
          ),
        );
  }
}
