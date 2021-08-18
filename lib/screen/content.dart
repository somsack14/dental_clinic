import 'package:dental_clinics/style/color_const.dart';
import 'package:dental_clinics/style/size_config.dart';
import 'package:dental_clinics/style/text_config.dart';
import 'package:flutter/material.dart';

class ContentClinic extends StatelessWidget {
  const ContentClinic({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: TextConfig().textHeadSizeCustom('ແນະນຳ', lightColor,
            FontWeight.bold, SizeConfig.screenWidth * 0.06),
        backgroundColor: whiteColor,
        elevation: 0.0,
        bottomOpacity: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined, color: lightColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'images/img_dental.png',
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
            TextConfig().textHeadSizeCustom('ການຮັກສາສຸຂະພາບແຂ້ວ', blackColor,
                FontWeight.normal, SizeConfig.screenWidth * 0.06),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: TextConfig().textHeadSizeCustom(
                  '  1. ຖູແຂ້ວມື້ລະ 2 ຄັ້ງ. ການຖຖູແຂ້ວເປັນຂັ້ນຕອນການດູແລສຸຂະພາບແຂ້ວທີ່ສຳຄັນຫຼາຍຫ້າມຖູແຂ້ວລວກๆ ຫຼືຟ້າວແປງຟັນເດັດຂາດເວລາຖູແຂ້ວໃຫ້ຖູ 2 ນາທີຂຶ້ນໄປເພາະຈະເຮັດໃຫ້ສະອາດ.',
                  blackColor,
                  FontWeight.normal,
                  SizeConfig.screenWidth * 0.045),
            ),
            Image.asset(
              'images/img_1.png',
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: TextConfig().textHeadSizeCustom(
                  '  2. ໃຊ້ຢາຖູແຂ້ວ fluoride. Fluoride ມີຄວາມ ສຳ ຄັນເພາະມັນເສີມສ້າງຄວາມແຂງແຮງຂອງເຄືອບແຂ້ວແລະປ້ອງກັນບໍ່ໃຫ້ແຂ້ວແມງ. ເລືອກຢາຖູແຂ້ວທີ່ມີຟໍຣໍໄຣ້ 1,350 - 1,500 ppm (ສ່ວນຕໍ່ນຶ່ງລ້ານ). ເດັກນ້ອຍສາມາດໃຊ້ມັນໄດ້, ແຕ່ຜູ້ໃຫຍ່ຄວນລະວັງບໍ່ໃຫ້ເດັກນ້ອຍກືນມັນໂດຍບັງເອີນ., ເດັກນ້ອຍໃຊ້ຢາຖູແຂ້ວຂະໜາດເທົ່າຖົ່ວ',
                  blackColor,
                  FontWeight.normal,
                  SizeConfig.screenWidth * 0.045),
            ),
            Image.asset(
              'images/img_2.png',
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: TextConfig().textHeadSizeCustom(
                  '  3. ໃຊ້ໃໝຫຼືດ້າຍຂັດແຂ້ວທຸກມື້. ເຊືອກຫຼືໄໝແຂ້ວມັນຊ່ວຍກໍາຈັດເສດອາຫານ, plaque ແລະເຊື້ອແບັກທີເຣັຍທີ່ສະສົມຢູ່ໃນແຂ້ວ. ເມື່ອຂ້ອຍເລີ່ມໃຊ້ດອກໄມ້ທໍາອິດ ອາດຈະມີເລືອດອອກ, ແຕ່ວ່າຫຼັງຈາກ 2-3 ມື້ມັນຈະຫາຍໄປເອງ',
                  blackColor,
                  FontWeight.normal,
                  SizeConfig.screenWidth * 0.045),
            ),
            Image.asset(
              'images/img_3.png',
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: TextConfig().textHeadSizeCustom(
                  '  4. ໃຊ້ນໍ້າຢາບ້ວນປາກ. ນໍ້າຢາບ້ວນປາກຊ່ວຍກໍາຈັດເຊື້ອແບັກທີເຣັຍແລະປ້ອງກັນກິ່ນປາກ. ຈະຊື້ນໍ້າຢາບ້ວນປາກທີ່ເຂົາເຈົ້າຂາຍທົ່ວໄປ ຫຼືເຈົ້າສາມາດປົນກັບນໍ້າເກືອແທນໄດ້.',
                  blackColor,
                  FontWeight.normal,
                  SizeConfig.screenWidth * 0.045),
            ),
            Image.asset(
              'images/img_4.png',
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: TextConfig().textHeadSizeCustom(
                  '  ອ່ານມາຮອດນີ້ແລ້ວທຸກຄົນຄວນຈະປະຕິບັດຕາມເພື່ອໃຫ້ມີສຸຂະພາບແຂ້ວທີ່ດີ.',
                  blackColor,
                  FontWeight.normal,
                  SizeConfig.screenWidth * 0.045),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
