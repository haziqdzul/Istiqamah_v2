import 'package:flutter/material.dart';
import 'package:istiqamah_app/components/default_scaffold.dart';
import 'package:istiqamah_app/constants/constant.dart';
import 'package:istiqamah_app/screen/sadaqah_details_page.dart';

import '../components/card_body.dart';
import '../components/image_label.dart';

class SadaqahPage extends StatefulWidget {
  const SadaqahPage({Key? key}) : super(key: key);

  @override
  State<SadaqahPage> createState() => _SadaqahPageState();
}

class _SadaqahPageState extends State<SadaqahPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return DefaultBody(
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sadaqah',
              style: textStyleBold,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: height * .07,
              child: Text(
                'Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it',
                style: textStyleNormal,
              ),
            ),
            CardBody(
              color: kSecondaryColor,
              radius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                width: width,
                // height: height * 0.3,
                child: Text(
                  kDefaultText,
                  style: textStyleNormal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultImageLabel(
                    onPress: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SadaqahDetails()),
                      );
                    },
                    label: 'UITM',
                    imageUrl:
                        'https://easyuni.com/media/articles/2015/05/28/8114667275_499586079a_b.jpg',
                  ),
                  DefaultImageLabel(
                      onPress: () {},
                      label: 'Community Welfare',
                      imageUrl:
                          'https://www.newmandala.org/wp-content/uploads/cache/2020/06/LDC-of-Lombok-educating-disabled-people-and-their-families-about-the-pandemic_-Photo-by-LDC-all-rights-reserved_/371280947.jpeg'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultImageLabel(
                      onPress: () {},
                      label: 'National Mosque',
                      imageUrl:
                          'https://www.jomjalan.com.my/wp-content/uploads/2016/03/masjid-negara-kuala-lumpur-@faadil.jpg'),
                  DefaultImageLabel(
                      onPress: () {},
                      label: 'Malaysian Idle Animals Association',
                      imageUrl:
                          'https://app-production-sumbangan-oss1.oss-ap-southeast-3.aliyuncs.com/sumbangan.com/public/campaigns/detail/62280f3d7c82a6.18210066.jpeg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
