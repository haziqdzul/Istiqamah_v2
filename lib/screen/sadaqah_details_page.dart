import 'package:flutter/material.dart';
import 'package:istiqamah_app/components/alert_button.dart';
import 'package:istiqamah_app/components/corner_body.dart';
import 'package:istiqamah_app/components/default_scaffold.dart';
import 'package:istiqamah_app/constants/constant.dart';

class SadaqahDetails extends StatefulWidget {
  const SadaqahDetails({Key? key}) : super(key: key);

  @override
  State<SadaqahDetails> createState() => _SadaqahDetailsState();
}

class _SadaqahDetailsState extends State<SadaqahDetails> {
  int val = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double appbarSize = AppBar().preferredSize.height;
    // double toolbar = kToolbarHeight;
    var statusbar = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        // automaticallyImplyLeading: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: statusbar),
        child: Stack(
          children: [
            Container(
              height: height * .2 + (appbarSize),
              width: width,
              // color: kPrimaryColor,
              child: Image.network(
                'https://easyuni.com/media/articles/2015/05/28/8114667275_499586079a_b.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(top: height * .2),
                    child: Container(
                      padding: EdgeInsets.only(top: 30, left: 20, right: 30),
                      height: height,
                      width: width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(75),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Universiti Teknologi Mara',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: width,
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bantuan khas untuk pelajar yang kurang berkemampuan. ',
                                  style: textStyleBoldSmall,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam',
                                  style: textStyleNormal,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: width,
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Payment MYR',
                                  style: textStyleBoldSmall,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  initialValue: '10',
                                  style: TextStyle(fontSize: 30),
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Amount for Bantuan khas untuk pelajar yang kurang berkemampuan. ',
                                  style: textStyleNormal,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: width,
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(top: 15),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Name',
                                  style: textStyleBoldSmall,
                                ),
                                TextFormField(
                                  style: textStyleNormal,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Your Name',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Mobile No.',
                                  style: textStyleBoldSmall,
                                ),
                                TextFormField(
                                  style: textStyleNormal,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Your Mobile No.',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Email Address',
                                  style: textStyleBoldSmall,
                                ),
                                TextFormField(
                                  style: textStyleNormal,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Your Email Address',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      value: 1,
                                      groupValue: val,
                                      activeColor: Colors.black,
                                      toggleable: true,
                                      onChanged: (value) {
                                        setState(() {
                                          val = int.parse(value.toString());
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Make this an anonymous sadaqah',
                                      style: textStyleNormal,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: width * .5,
                            margin: EdgeInsets.only(top: 20),
                            child: DefaultButton(
                                label: 'Sadaqah Now',
                                textStyle: textStyleBoldSmall,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(16))),
                          )
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
