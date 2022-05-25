// import 'package:flutter/material.dart';
// import 'package:istiqamah_app/components/alert_button.dart';
// import 'package:istiqamah_app/screen/update_information_page.dart';
// import '../components/corner_body.dart';
// import '../constants/constant.dart';
//
// class FillInformationPage extends StatefulWidget {
//   const FillInformationPage({Key? key}) : super(key: key);
//
//   @override
//   State<FillInformationPage> createState() => _FillInformationPageState();
// }
//
// class _FillInformationPageState extends State<FillInformationPage> {
//   var items = ['One', 'Two', 'Free', 'Four'];
//   var genders = ['Male', 'Female'];
//   var titles = ['Mr', 'Mrs', 'Ms'];
//   var country = ['Malaysia', 'Indonesia', 'Brunei', 'Singapore'];
//
//   //var _category = 'One';
//   @override
//   Widget build(BuildContext context) {
//     return CornerBody(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text(
//                 'Fill your information',
//                 style: textStyleBold,
//               ),
//               Icon(
//                 Icons.more_vert,
//                 size: 20,
//               ),
//             ],
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 30),
//             child: Column(
//               children: [
//                 _header('Gender', true),
//                 DefaultDropDown(
//                     list: genders,
//                     // value: _category,
//                     label: 'Choose Gender',
//                     validator: (value) {
//                       return null;
//                     }),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 15),
//             child: Column(
//               children: [
//                 _header('Title', true),
//                 DefaultDropDown(
//                     list: titles,
//                     // value: _category,
//                     label: 'Choose Title',
//                     validator: (value) {
//                       return null;
//                     }),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 15),
//             child: Column(
//               children: [
//                 _header('Date of Birth', true),
//                 DefaultDropDown(
//                     list: items,
//                     // value: _category,
//                     label: 'DD-MM-YY',
//                     icon: const Icon(Icons.calendar_month),
//                     validator: (value) {
//                       return null;
//                     }),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           _header('Country', true),
//           Row(
//             children: [
//               const SizedBox(
//                 width: 15,
//               ),
//               Image.network(
//                 'https://media.istockphoto.com/vectors/malaysia-state-flag-or-malaysian-national-flag-vector-id1202134918?k=20&m=1202134918&s=612x612&w=0&h=57dHd9MdMvkEZHjI1P1WVEvV8kXUkZYnfjC-sTdZoDo=',
//                 width: 30,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Expanded(
//                 child: DefaultDropDown(
//                     list: country,
//                     // value: _category,
//                     label: 'Choose Country',
//                     validator: (value) {
//                       return null;
//                     }),
//               ),
//             ],
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 15),
//             child: Column(
//               children: [
//                 _header('State', true),
//                 DefaultDropDown(
//                     list: items,
//                     // value: _category,
//                     label: 'Choose State',
//                     validator: (value) {
//                       return null;
//                     }),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 15),
//             child: Column(
//               children: [
//                 _header('Postal Code', true),
//                 DefaultDropDown(
//                     list: items,
//                     // value: _category,
//                     label: 'Select Postal Code',
//                     validator: (value) {
//                       return null;
//                     }),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 15),
//             child: Column(
//               children: [
//                 _header('Address 1', true),
//                 TextFormField(
//                     autofocus: false,
//                     style: textStyleNormal,
//                     decoration: _textFieldDeco('Enter address line 1')),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 15),
//             child: Column(
//               children: [
//                 _header('Address 2', true),
//                 TextFormField(
//                     autofocus: false,
//                     style: textStyleNormal,
//                     decoration: _textFieldDeco('Enter address line 2')),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 15),
//             child: Column(
//               children: [
//                 _header('Address 3', false),
//                 TextFormField(
//                     autofocus: false,
//                     style: textStyleNormal,
//                     decoration: _textFieldDeco('Enter address line 3')),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.only(
//               top: 15,
//             ),
//             child: Column(
//               children: [
//                 _header('Phone Number', true),
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 15,
//                     ),
//                     const Text(
//                       'MY +60',
//                       style: textStyleNormal,
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: TextFormField(
//                           autofocus: false,
//                           style: textStyleNormal,
//                           decoration: _textFieldDeco('123456789')),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
//             child: DefaultButton(
//               onPress: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const UpdatePage()),
//                 );
//               },
//               label: 'Next',
//               textStyle: textStyleBold,
//               decoration: BoxDecoration(
//                   color: kPrimaryColor,
//                   borderRadius: BorderRadius.circular(16)),
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           )
//         ],
//       ),
//     );
//   }
//
//   Row _header(String title, bool required) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         const SizedBox(
//           width: 15,
//         ),
//         Text(
//           title,
//           style: textStyleBoldSmall,
//         ),
//         Text(
//           required ? ' *' : '',
//           style: const TextStyle(color: Colors.red),
//         ),
//       ],
//     );
//   }
//
//   InputDecoration _textFieldDeco(hint) {
//     return InputDecoration(
//       border: InputBorder.none,
//       hintText: hint,
//       filled: true,
//       fillColor: const Color(0xFFF6F6F1),
//       contentPadding: const EdgeInsets.only(left: 20.0, bottom: 6.0, top: 8.0),
//       focusedBorder: OutlineInputBorder(
//         borderSide: const BorderSide(
//           color: Color(0xFFF6F6F1),
//         ),
//         borderRadius: BorderRadius.circular(40.0),
//       ),
//       enabledBorder: UnderlineInputBorder(
//         borderSide: const BorderSide(
//           color: Color(0xFFF6F6F1),
//         ),
//         borderRadius: BorderRadius.circular(40.0),
//       ),
//     );
//   }
//
//   InputDecoration _textFieldDropDownDeco(hint) {
//     return InputDecoration(
//       border: InputBorder.none,
//       hintText: hint,
//       filled: true,
//       fillColor: const Color(0xFFF6F6F1),
//       contentPadding: const EdgeInsets.only(left: 20.0, bottom: 6.0, top: 8.0),
//       focusedBorder: OutlineInputBorder(
//         borderSide: const BorderSide(
//           color: Color(0xFFF6F6F1),
//         ),
//         borderRadius: BorderRadius.circular(40.0),
//       ),
//       suffixIcon: const Icon(
//         Icons.arrow_drop_down,
//         color: Colors.black,
//       ),
//       enabledBorder: UnderlineInputBorder(
//         borderSide: const BorderSide(
//           color: Color(0xFFF6F6F1),
//         ),
//         borderRadius: BorderRadius.circular(40.0),
//       ),
//     );
//   }
// }
//
// class DefaultDropDown extends StatelessWidget {
//   DefaultDropDown(
//       {required this.list,
//       this.value,
//       required this.label,
//       this.validator,
//       this.icon});
//
//   final List<String> list;
//   String? value;
//   final String label;
//
//   String? Function(String?)? validator;
//
//   Widget? icon;
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField(
//       icon: icon,
//       validator: validator,
//       items: list.map((String category) {
//         return DropdownMenuItem(
//             value: category,
//             child: Text(
//               category,
//               style: textStyleNormal,
//             ));
//       }).toList(),
//       onChanged: (newValue) {},
//       value: value,
//       decoration: InputDecoration(
//         border: InputBorder.none,
//         hintText: label,
//         hintStyle: textStyleNormalGrey,
//         filled: true,
//         fillColor: const Color(0xFFF6F6F1),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(
//             color: Color(0xFFF6F6F1),
//           ),
//           borderRadius: BorderRadius.circular(40.0),
//         ),
//         enabledBorder: UnderlineInputBorder(
//           borderSide: const BorderSide(
//             color: Color(0xFFF6F6F1),
//           ),
//           borderRadius: BorderRadius.circular(40.0),
//         ),
//       ),
//     );
//   }
// }
