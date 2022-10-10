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
            const Text(
              'Sadaqah',
              style: textStyleBold,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: height * .07,
              child: const Text(
                '“Sadaqah extinguishes sin as water extinguishes fire.” (Tirmidhi)',
                style: textStyleNormal,
              ),
            ),
            CardBody(
              color: kSecondaryColor,
              radius: BorderRadius.circular(16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                width: width,
                // height: height * 0.3,
                child: const Text(
                  'Sadaqah is the term used to describe a voluntary act of charity that is wide-reaching, for example a form of monetary charity or an act of kindness that can be performed in any amount, at any time of the year. ',
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
                      Navigator.push(
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
                      onPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            insetPadding: const EdgeInsets.all(15),
                            child:
                                StatefulBuilder(builder: (context, setState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Icon(
                                    Icons.timelapse_outlined,
                                  ),
                                  Text("Coming Soon"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Community Welfare Sadaqah",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            }),
                          ),
                        );
                      },
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
                      onPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            insetPadding: const EdgeInsets.all(15),
                            child:
                                StatefulBuilder(builder: (context, setState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Icon(
                                    Icons.timelapse_outlined,
                                  ),
                                  Text("Coming Soon"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "National Mosque Sadaqah",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            }),
                          ),
                        );
                      },
                      label: 'National Mosque',
                      imageUrl:
                          'https://www.jomjalan.com.my/wp-content/uploads/2016/03/masjid-negara-kuala-lumpur-@faadil.jpg'),
                  DefaultImageLabel(
                      onPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            insetPadding: const EdgeInsets.all(15),
                            child:
                                StatefulBuilder(builder: (context, setState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Icon(
                                    Icons.timelapse_outlined,
                                  ),
                                  Text("Coming Soon"),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Association Sadaqah",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            }),
                          ),
                        );
                      },
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
