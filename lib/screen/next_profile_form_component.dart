import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import '../Locale/locales.dart';
import '../Utils/MLColors.dart';
import '../models/TableData.dart';
import '../models/user.model.dart';

class NextProfileFormComponent extends StatefulWidget {
  static String tag = '/MLProfileFormComponent';

  const NextProfileFormComponent({Key? key}) : super(key: key);

  @override
  NextProfileFormComponentState createState() =>
      NextProfileFormComponentState();
}

class NextProfileFormComponentState extends State<NextProfileFormComponent> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  late List<FocusNode> _focusNodes;
  double? _bmi;

  @override
  void initState() {
    super.initState();
    init();

    _focusNodes = Iterable<int>.generate(3).map((e) => FocusNode()).toList();

    _focusNodes[0].requestFocus();
  }

  Future<void> init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _calculate() {
    var locale = AppLocalizations.of(context)!;
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);
    // Check if the inputs are valid
    if (height == null ||
        height <= 0 ||
        weight == null ||
        weight <= 0 ||
        ethnicity == 'Pilih bangsa' ||
        bangsa == 'Choose ethnicity') {
      setState(() {
        _message = locale.message!;
      });
      return;
    }

    setState(() {
      _bmi = weight / ((height / 100) * (height / 100));
      userData.height = height.toStringAsFixed(0);
      userData.weight = weight.toStringAsFixed(0);
      userData.bmi = _bmi!.toStringAsFixed(1);
      _message = '';
      if (ethnicity == 'Asian or South Asian' ||
          bangsa == 'Asia atau Asia Selatan') {
        if (_bmi! < 18.5) {
          _message = '';
        } else if (_bmi! < 23) {
          _message = '';
        } else if (_bmi! < 27.5) {
          _message = '';
        } else {
          _message = '';
        }
      } else if (ethnicity == 'Others' || bangsa == 'Lain-lain') {
        if (_bmi! < 18.5) {
          _message = '';
        } else if (_bmi! < 24.9) {
          _message = '';
        } else if (_bmi! < 29.9) {
          _message = '';
        } else {
          _message = '';
        }
      }
    });
  }

  var items = [
    'Choose ethnicity',
    'Asian or South Asian',
    'Others',
  ];

  var itemss = [
    'Pilih bangsa',
    'Asia atau Asia Selatan',
    'Lain-lain',
  ];
  String _message = 'No Data';

  @override
  void dispose() {
    super.dispose();
  }

  String ethnicity = 'Choose ethnicity';
  String bangsa = 'Pilih bangsa';
  String dropdownvalue = 'Choose';
  String dropdownvalue1 = 'Pilih';
  late String countryValue;
  late String stateValue;
  late String cityValue;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var dataTable = [
      TableData(locale.underWeight!, '<18.5kg/m²'),
      TableData(locale.normalWeight!, '18.5-24.9kg/m²'),
      TableData(locale.overWeight!, '25.0-29.9kg/m²'),
      TableData(locale.obese!, '≥30kg/m²'),
    ];
    var dataTable2 = [
      TableData2(locale.underWeight!, '<18.5kg/m²'),
      TableData2(locale.normalWeight!, '18.5-23.0kg/m²'),
      TableData2(locale.overWeight!, '23.0-27.5kg/m²'),
      TableData2(locale.obese!, '>27.5kg/m²'),
    ];
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.62,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(locale.wellnessWatch!, style: boldTextStyle()),
                4.width,
                const Icon(Icons.info_outline,
                    color: Colors.blueGrey, size: 22),
              ],
            ),
            8.height,
            Text(locale.wellnessMessage!, style: const TextStyle()),
            8.height,
            Row(
              children: [
                Text(locale.ethnicity!, style: boldTextStyle()),
                // Text(' *', style: boldTextStyle(color: Colors.redAccent)),
              ],
            ),
            if (locale.ethnicity == 'Ethnicity')
              DropdownButton(
                isExpanded: true,
                value: ethnicity,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    ethnicity = newValue!;
                    userData.ethnicity = newValue;
                  });
                },
              ),
            if (locale.ethnicity == 'Bangsa')
              DropdownButton(
                isExpanded: true,
                value: bangsa,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: itemss.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    bangsa = newValue!;
                    userData.ethnicity = newValue;
                  });
                },
              ),
            8.height,
            Row(
              children: [
                Text(locale.height!, style: boldTextStyle()),
                // Text(' *', style: boldTextStyle(color: Colors.redAccent)),
              ],
            ),
            TextField(
              onChanged: (height) {
                setState(() {
                  if (ethnicity != 'Choose ethnicity' ||
                      bangsa != 'Pilih bangsa') {
                    _calculate();
                  }
                });
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: locale.enterHeight,
                suffixIcon: IconButton(
                  onPressed: _heightController.clear,
                  icon: const Icon(Icons.clear),
                ),
                hintStyle: secondaryTextStyle(size: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: mlColorLightGrey),
                ),
              ),
              controller: _heightController,
            ),
            8.height,
            Row(
              children: [
                Text(locale.weight!, style: boldTextStyle()),
                // Text(' *', style: boldTextStyle(color: Colors.redAccent)),
              ],
            ),
            TextField(
              onChanged: (weight) {
                setState(() {
                  if (ethnicity != 'Choose ethnicity' ||
                      bangsa != 'Pilih bangsa') {
                    _calculate();
                  }
                });
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: locale.enterWeight,
                suffixIcon: IconButton(
                  onPressed: _weightController.clear,
                  icon: const Icon(Icons.clear),
                ),
                hintStyle: secondaryTextStyle(size: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: mlColorLightGrey),
                ),
              ),
              controller: _weightController,
            ),
            0.height,
            Row(
              children: [
                Text(
                  'BMI : ',
                  textAlign: TextAlign.left,
                  style: boldTextStyle(size: 24),
                ),
                Text(
                  _bmi == null ? locale.noResult! : _bmi!.toStringAsFixed(1),
                  style: boldTextStyle(size: 22),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            0.height,
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              (_message == '' || _message == 'No Data')
                  ? Text(
                      locale.categoryBMItable!,
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      _message,
                      textAlign: TextAlign.center,
                    ),
              (_message == '' || _message == 'No Data')
                  ? SizedBox(
                      width: 3.0,
                      child: Center(
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 1.0, end: 1.0),
                          height: 50.0,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : Container(),
              (_message == '' || _message == 'No Data')
                  ? RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: locale.BMItable!,
                          style: const TextStyle(color: Colors.cyan),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (ethnicity == 'Asian or South Asian' ||
                                  bangsa == 'Asia atau Asia Selatan') {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      scrollable: true,
                                      content: Column(
                                        children: [
                                          Text(locale.BMItable!,
                                              style: boldTextStyle()),
                                          Container(
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.rectangle),
                                              child: Scrollbar(
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: DataTable(
                                                      columnSpacing: 10,
                                                      sortColumnIndex: 1,
                                                      sortAscending: true,
                                                      columns: [
                                                        const DataColumn(
                                                            label: Text(''),
                                                            numeric: false,
                                                            onSort: null),
                                                        DataColumn(
                                                            label: RichText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          text: locale.general ==
                                                                  'umum'
                                                              ? TextSpan(
                                                                  children: [
                                                                      TextSpan(
                                                                          text: locale
                                                                              .bmi!,
                                                                          style:
                                                                              const TextStyle(color: Colors.black)),
                                                                      TextSpan(
                                                                          text:
                                                                              ' ${locale.who!} ',
                                                                          style:
                                                                              const TextStyle(color: Colors.black)),
                                                                      TextSpan(
                                                                          text: locale
                                                                              .asian!,
                                                                          style:
                                                                              const TextStyle(color: Colors.blue)),
                                                                    ])
                                                              : TextSpan(
                                                                  children: [
                                                                      TextSpan(
                                                                          text: locale
                                                                              .who!,
                                                                          style:
                                                                              const TextStyle(color: Colors.black)),
                                                                      TextSpan(
                                                                          text:
                                                                              ' ${locale.asian!} ',
                                                                          style:
                                                                              const TextStyle(color: Colors.blue)),
                                                                      TextSpan(
                                                                          text: locale
                                                                              .bmi!,
                                                                          style:
                                                                              const TextStyle(color: Colors.black)),
                                                                    ]),
                                                        )),
                                                      ],
                                                      rows: dataTable
                                                          .map(
                                                              (e) => DataRow(
                                                                      selected:
                                                                          false,
                                                                      cells: [
                                                                        DataCell(
                                                                            Text(
                                                                          e.type,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        )),
                                                                        DataCell(
                                                                            Text(
                                                                          e.general,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        )),
                                                                      ]))
                                                          .toList()),
                                                ),
                                              ))
                                          // Image.asset(bmi_table!),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } else if (ethnicity == 'Others' ||
                                  bangsa == 'Lain-lain') {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      scrollable: true,
                                      content: Column(
                                        children: [
                                          Text(locale.BMItable!,
                                              style: boldTextStyle()),
                                          Container(
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.rectangle),
                                              child: Scrollbar(
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: DataTable(
                                                      columnSpacing: 10,
                                                      sortColumnIndex: 1,
                                                      sortAscending: true,
                                                      columns: [
                                                        const DataColumn(
                                                            label: Text(''),
                                                            numeric: false,
                                                            onSort: null),
                                                        DataColumn(
                                                            label: RichText(
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          text: locale.general ==
                                                                  'umum'
                                                              ? TextSpan(
                                                                  children: [
                                                                      TextSpan(
                                                                          text: locale
                                                                              .bmi!,
                                                                          style:
                                                                              const TextStyle(color: Colors.black)),
                                                                      TextSpan(
                                                                          text:
                                                                              ' ${locale.who!} ',
                                                                          style:
                                                                              const TextStyle(color: Colors.black)),
                                                                      TextSpan(
                                                                          text: locale
                                                                              .general!,
                                                                          style:
                                                                              const TextStyle(color: Colors.blue)),
                                                                    ])
                                                              : TextSpan(
                                                                  children: [
                                                                      TextSpan(
                                                                          text: locale
                                                                              .who!,
                                                                          style:
                                                                              const TextStyle(color: Colors.black)),
                                                                      TextSpan(
                                                                          text:
                                                                              ' ${locale.general!} ',
                                                                          style:
                                                                              const TextStyle(color: Colors.blue)),
                                                                      TextSpan(
                                                                          text: locale
                                                                              .bmi!,
                                                                          style:
                                                                              const TextStyle(color: Colors.black)),
                                                                    ]),
                                                        )),
                                                      ],
                                                      rows: dataTable2
                                                          .map(
                                                              (e) => DataRow(
                                                                      selected:
                                                                          false,
                                                                      cells: [
                                                                        DataCell(
                                                                            Text(
                                                                          e.type2,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        )),
                                                                        DataCell(
                                                                            Text(
                                                                          e.asian,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        )),
                                                                      ]))
                                                          .toList()),
                                                ),
                                              ))
                                          // Image.asset(bmi_table!),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            }),
                    )
                  : Container(),
            ]),
          ],
        ),
      ),
    );
  }

// Widget genderDropDown() {
//   var locale = AppLocalizations.of(context)!;
//   String dropdownValue = locale.selectYourGender!;
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(locale.gender!, style: boldTextStyle()),
//       DropdownButton<String>(
//         value: dropdownValue,
//         icon: Icon(
//           Icons.keyboard_arrow_down,
//           color: mlColorBlue,
//         ).paddingOnly(left: 190.0),
//         iconSize: 24,
//         elevation: 16,
//         style: secondaryTextStyle(size: 16),
//         onChanged: (newValue) {
//           setState(() {
//             dropdownValue = newValue!;
//           });
//         },
//         items: <String>[
//           locale.selectYourGender!,
//           locale.female!,
//           locale.male!,
//         ].map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value, style: secondaryTextStyle(size: 16)));
//         }).toList(),
//       ),
//     ],
//   );
// }
}
