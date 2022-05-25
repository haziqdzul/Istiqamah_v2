// import 'package:flutter/material.dart';
// import 'package:istiqamah_app/components/corner_body.dart';
// import 'package:istiqamah_app/screen/login_page.dart';
//
// import '../components/alert_button.dart';
// import '../constants/constant.dart';
// import 'fill_inform_page.dart';
//
// class UpdatePage extends StatefulWidget {
//   const UpdatePage({Key? key}) : super(key: key);
//
//   @override
//   State<UpdatePage> createState() => _UpdatePageState();
// }
//
// class _UpdatePageState extends State<UpdatePage> {
//   var items = ['Malay', 'Indian', 'Chinese'];
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return CornerBody(
//       bodyHeight: height,
//       body: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text(
//                 'Update your information',
//                 style: textStyleBold,
//               ),
//               Icon(
//                 Icons.more_vert,
//                 size: 20,
//               ),
//             ],
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 20, top: 30),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: const [
//                     Text(
//                       'Wellness Watch',
//                       style: textStyleBold,
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Icon(
//                       Icons.info_outline,
//                       size: 15,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text(
//                   'Your height and weight will be used to calculate your body mass index (BMI) and required daily water intake. Ethnicity is used to determine your BMI category.',
//                   style: textStyleNormal,
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   'Ethnicity',
//                   style: textStyleBold,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 DefaultDropDown(
//                     list: items,
//                     // value: _category,
//                     label: 'Choose Ethnicity',
//                     validator: (value) {
//                       return null;
//                     }),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   'BMI : No result',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: const [
//                     SizedBox(
//                       width: 150,
//                       child: Text(
//                         'Refer to BMI table to check your category',
//                         style: textStyleNormal,
//                       ),
//                     ),
//                     Text(
//                       'BMI Table',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
//                   child: DefaultButton(
//                     onPress: () {
//                       Navigator.of(context).pushAndRemoveUntil(
//                           MaterialPageRoute(builder: (context) => const MLLoginScreen()),
//                           (Route<dynamic> route) => false);
//                     },
//                     label: 'Submit',
//                     textStyle: textStyleBold,
//                     decoration: BoxDecoration(
//                         color: kPrimaryColor,
//                         borderRadius: BorderRadius.circular(16)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
