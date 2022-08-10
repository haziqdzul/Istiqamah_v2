import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        // automaticallyImplyLeading: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: statusbar),
        child: Stack(
          children: [
            SizedBox(
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
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 30),
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
                          const Text(
                            'Screenshot and scan using DuitNow QR Scanner from any Banking mobile app to donate.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image.asset('assets/assunnah.jpg'),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                              ),
                              onPressed: () async {
                                var openAppResult = await LaunchApp.openApp(
                                  androidPackageName: 'com.iexceed.CBS',
                                  iosUrlScheme: 'pulsesecure://',
                                  appStoreLink:
                                      'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
                                  // openStore: false
                                );
                                print(
                                    'openAppResult => $openAppResult ${openAppResult.runtimeType}');
                                // Enter thr package name of the App you want to open and for iOS add the URLscheme to the Info.plist file.
                                // The second arguments decide wether the app redirects PlayStore or AppStore.
                                // For testing purpose you can enter com.instagram.android
                              },
                              child: const Center(
                                child: Text(
                                  "Scan using Bank Islam",
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          // ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //       primary: Colors.blue,
                          //     ),
                          //     onPressed: () async {
                          //       var openAppResult = await LaunchApp.openApp(
                          //         androidPackageName:
                          //             'my.com.maybank2u.m2umobile',
                          //         iosUrlScheme: 'pulsesecure://',
                          //         appStoreLink:
                          //             'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
                          //         // openStore: false
                          //       );
                          //       print(
                          //           'openAppResult => $openAppResult ${openAppResult.runtimeType}');
                          //       // Enter thr package name of the App you want to open and for iOS add the URLscheme to the Info.plist file.
                          //       // The second arguments decide wether the app redirects PlayStore or AppStore.
                          //       // For testing purpose you can enter com.instagram.android
                          //     },
                          //     child: const Center(
                          //       child: Text(
                          //         "Scan using Maybank",
                          //         textAlign: TextAlign.center,
                          //       ),
                          //     )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                              ),
                              onPressed: () async {
                                var openAppResult = await LaunchApp.openApp(
                                  androidPackageName: 'com.cimbmalaysia',
                                  iosUrlScheme: 'pulsesecure://',
                                  appStoreLink:
                                      'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
                                  // openStore: false
                                );
                                print(
                                    'openAppResult => $openAppResult ${openAppResult.runtimeType}');
                                // Enter thr package name of the App you want to open and for iOS add the URLscheme to the Info.plist file.
                                // The second arguments decide wether the app redirects PlayStore or AppStore.
                                // For testing purpose you can enter com.instagram.android
                              },
                              child: const Center(
                                child: Text(
                                  "Scan using CIMB",
                                  textAlign: TextAlign.center,
                                ),
                              )),
                          // Text(
                          //   'As-Sunnah Global',
                          //   style: TextStyle(fontSize: 20, color: Colors.blue),
                          // ),

                          // Container(
                          //   width: width,
                          //   padding: const EdgeInsets.all(16),
                          //   margin: const EdgeInsets.only(top: 30),
                          //   decoration: const BoxDecoration(
                          //     color: kPrimaryColor,
                          //   ),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: const [
                          //       Text(
                          //         'Bantuan khas untuk pelajar yang kurang berkemampuan. ',
                          //         style: textStyleBoldSmall,
                          //       ),
                          //       SizedBox(
                          //         height: 10,
                          //       ),
                          //       Text(
                          //         'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam',
                          //         style: textStyleNormal,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: width,
                          //   padding: const EdgeInsets.all(16),
                          //   margin: const EdgeInsets.only(top: 15),
                          //   decoration: const BoxDecoration(
                          //     color: kPrimaryColor,
                          //   ),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       const Text(
                          //         'Total Payment MYR',
                          //         style: textStyleBoldSmall,
                          //       ),
                          //       const SizedBox(
                          //         height: 10,
                          //       ),
                          //       TextFormField(
                          //         initialValue: '10',
                          //         style: const TextStyle(fontSize: 30),
                          //         decoration: const InputDecoration(
                          //           enabledBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.black),
                          //           ),
                          //           focusedBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.black),
                          //           ),
                          //         ),
                          //       ),
                          //       const SizedBox(
                          //         height: 10,
                          //       ),
                          //       const Text(
                          //         'Amount for Bantuan khas untuk pelajar yang kurang berkemampuan. ',
                          //         style: textStyleNormal,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: width,
                          //   padding: const EdgeInsets.all(16),
                          //   margin: const EdgeInsets.only(top: 15),
                          //   decoration: const BoxDecoration(
                          //     color: kPrimaryColor,
                          //   ),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       const Text(
                          //         'Your Name',
                          //         style: textStyleBoldSmall,
                          //       ),
                          //       TextFormField(
                          //         style: textStyleNormal,
                          //         decoration: const InputDecoration(
                          //           hintText: 'Enter Your Name',
                          //           enabledBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.black),
                          //           ),
                          //           focusedBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.black),
                          //           ),
                          //         ),
                          //       ),
                          //       const SizedBox(
                          //         height: 10,
                          //       ),
                          //       const Text(
                          //         'Mobile No.',
                          //         style: textStyleBoldSmall,
                          //       ),
                          //       TextFormField(
                          //         style: textStyleNormal,
                          //         decoration: const InputDecoration(
                          //           hintText: 'Enter Your Mobile No.',
                          //           enabledBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.black),
                          //           ),
                          //           focusedBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.black),
                          //           ),
                          //         ),
                          //       ),
                          //       const SizedBox(
                          //         height: 10,
                          //       ),
                          //       const Text(
                          //         'Email Address',
                          //         style: textStyleBoldSmall,
                          //       ),
                          //       TextFormField(
                          //         style: textStyleNormal,
                          //         decoration: const InputDecoration(
                          //           hintText: 'Enter Your Email Address',
                          //           enabledBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.black),
                          //           ),
                          //           focusedBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.black),
                          //           ),
                          //         ),
                          //       ),
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         children: [
                          //           Radio(
                          //             materialTapTargetSize:
                          //                 MaterialTapTargetSize.shrinkWrap,
                          //             value: 1,
                          //             groupValue: val,
                          //             activeColor: Colors.black,
                          //             toggleable: true,
                          //             onChanged: (value) {
                          //               setState(() {
                          //                 val = int.parse(value.toString());
                          //               });
                          //             },
                          //           ),
                          //           const Text(
                          //             'Make this an anonymous sadaqah',
                          //             style: textStyleNormal,
                          //           ),
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: width * .5,
                          //   margin: const EdgeInsets.only(top: 20),
                          //   child: DefaultButton(
                          //       label: 'Sadaqah Now',
                          //       textStyle: textStyleBoldSmall,
                          //       decoration: BoxDecoration(
                          //           color: kPrimaryColor,
                          //           borderRadius: BorderRadius.circular(16))),
                          // )
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
