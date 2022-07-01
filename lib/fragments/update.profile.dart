import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:istiqamah_app/screen/home_page.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../Locale/locales.dart';
import '../models/TableData.dart';
import '../models/user.model.dart';
import '../providers/user.provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String? _height;
  String? _weight;
  String? ethnic;
  String? bmi;

  var visible = false;

  var updated = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  double? _bmi;
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

  Future<void> _calculate() async {
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
      updated = true;
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

  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
    return StatefulBuilder(builder: (context, setState) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              CustomScrollView(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                slivers: <Widget>[
                  (locale.update_profile! == 'Update Profile')
                      ? SliverAppBar(
                          leading: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.grey,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          pinned: true,
                          snap: true,
                          floating: true,
                          expandedHeight: 120.0,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Image.asset(
                              'assets/Logo As-sunnah_whitebg-02-02.png',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : SliverAppBar(
                          leading: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.grey,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          pinned: true,
                          snap: true,
                          floating: true,
                          expandedHeight: 120.0,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Image.asset(
                              'assets/Logo As-Sunnah_Malay_WBG-03.png',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 8),
                        child: Center(
                            child: Text(
                          locale.update_profile!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Row(
                          children: [
                            Text(locale.wellnessWatch!, style: boldTextStyle()),
                            4.width,
                            const Icon(Icons.info_outline,
                                color: Colors.blueGrey, size: 22),
                          ],
                        ),
                      ),
                      16.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(locale.wellnessMessage!,
                            style: const TextStyle()),
                      ),
                      16.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(locale.ethnicity!, style: boldTextStyle()),
                      ),
                      8.height,
                      if (locale.ethnicity == 'Ethnicity')
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: DropdownButton(
                            isExpanded: true,
                            value: ethnicity,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                  value: items, child: Text(items));
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != 'Choose ethnicity') {
                                visible = true;
                              } else {
                                visible = false;
                              }
                              setState(() {
                                ethnicity = newValue!;
                                userData.ethnicity = newValue;
                              });
                            },
                          ),
                        ),
                      if (locale.ethnicity == 'Bangsa')
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: DropdownButton(
                            isExpanded: true,
                            value: bangsa,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: itemss.map((String items) {
                              return DropdownMenuItem(
                                  value: items, child: Text(items));
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != 'Pilih bangsa') {
                                visible = true;
                              } else {
                                visible = false;
                              }
                              setState(() {
                                bangsa = newValue!;
                                ethnic = newValue;
                                userData.ethnicity = newValue;
                              });
                            },
                          ),
                        ),
                      16.height,
                      Visibility(
                        visible: visible,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child:
                                  Text(locale.height!, style: boldTextStyle()),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: _height,
                                  labelStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return locale.enterText_profile!;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                controller: _heightController,
                                onChanged: (v) {
                                  setState(() {
                                    if (ethnicity != 'Choose ethnicity' ||
                                        bangsa != 'Pilih bangsa') {
                                      _calculate();
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.height,
                      Visibility(
                        visible: visible,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child:
                                  Text(locale.weight!, style: boldTextStyle()),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                decoration: InputDecoration(
                                  hintText: _weight,
                                  labelStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.purple),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return locale.enterText_profile!;
                                  }
                                  return null;
                                },
                                controller: _weightController,
                                onChanged: (v) {
                                  setState(() {
                                    if (ethnicity != 'Choose ethnicity' ||
                                        bangsa != 'Pilih bangsa') {
                                      _calculate();
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Row(
                          children: [
                            Text(
                              'BMI : ',
                              textAlign: TextAlign.left,
                              style: boldTextStyle(size: 24),
                            ),
                            Text(
                              bmi == null
                                  ? locale.noResult!
                                  : updated
                                      ? _bmi!.toStringAsFixed(1)
                                      : bmi.toString(),
                              style: boldTextStyle(size: 22),
                              textAlign: TextAlign.left,
                            ),
                            // Text(
                            //   _bmi == null
                            //       ? locale.noResult!
                            //       : _bmi!.toStringAsFixed(1),
                            //   style: boldTextStyle(size: 22),
                            //   textAlign: TextAlign.left,
                            // ),
                          ],
                        ),
                      ),
                      5.height,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
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
                                        margin:
                                            const EdgeInsetsDirectional.only(
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
                                        style:
                                            const TextStyle(color: Colors.cyan),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            if (ethnicity ==
                                                    'Asian or South Asian' ||
                                                bangsa ==
                                                    'Asia atau Asia Selatan') {
                                              showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    scrollable: true,
                                                    content: Column(
                                                      children: [
                                                        Text(locale.BMItable!,
                                                            style:
                                                                boldTextStyle()),
                                                        Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle),
                                                            child: Scrollbar(
                                                              child:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: DataTable(
                                                                    columnSpacing: 10,
                                                                    sortColumnIndex: 1,
                                                                    sortAscending: true,
                                                                    columns: [
                                                                      const DataColumn(
                                                                          label: Text(
                                                                              ''),
                                                                          numeric:
                                                                              false,
                                                                          onSort:
                                                                              null),
                                                                      DataColumn(
                                                                          label:
                                                                              RichText(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        maxLines:
                                                                            2,
                                                                        text: locale.general ==
                                                                                'umum'
                                                                            ? TextSpan(children: [
                                                                                TextSpan(text: locale.bmi!, style: const TextStyle(color: Colors.black)),
                                                                                TextSpan(text: ' ${locale.who!} ', style: const TextStyle(color: Colors.black)),
                                                                                TextSpan(text: locale.asian!, style: const TextStyle(color: Colors.blue)),
                                                                              ])
                                                                            : TextSpan(children: [
                                                                                TextSpan(text: locale.who!, style: const TextStyle(color: Colors.black)),
                                                                                TextSpan(text: ' ${locale.asian!} ', style: const TextStyle(color: Colors.blue)),
                                                                                TextSpan(text: locale.bmi!, style: const TextStyle(color: Colors.black)),
                                                                              ]),
                                                                      )),
                                                                    ],
                                                                    rows: dataTable
                                                                        .map((e) => DataRow(selected: false, cells: [
                                                                              DataCell(Text(
                                                                                e.type,
                                                                                textAlign: TextAlign.center,
                                                                              )),
                                                                              DataCell(Text(
                                                                                e.general,
                                                                                textAlign: TextAlign.center,
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
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    scrollable: true,
                                                    content: Column(
                                                      children: [
                                                        Text(locale.BMItable!,
                                                            style:
                                                                boldTextStyle()),
                                                        Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle),
                                                            child: Scrollbar(
                                                              child:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: DataTable(
                                                                    columnSpacing: 10,
                                                                    sortColumnIndex: 1,
                                                                    sortAscending: true,
                                                                    columns: [
                                                                      const DataColumn(
                                                                          label: Text(
                                                                              ''),
                                                                          numeric:
                                                                              false,
                                                                          onSort:
                                                                              null),
                                                                      DataColumn(
                                                                          label:
                                                                              RichText(
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        maxLines:
                                                                            2,
                                                                        text: locale.general ==
                                                                                'umum'
                                                                            ? TextSpan(children: [
                                                                                TextSpan(text: locale.bmi!, style: const TextStyle(color: Colors.black)),
                                                                                TextSpan(text: ' ${locale.who!} ', style: const TextStyle(color: Colors.black)),
                                                                                TextSpan(text: locale.general!, style: const TextStyle(color: Colors.blue)),
                                                                              ])
                                                                            : TextSpan(children: [
                                                                                TextSpan(text: locale.who!, style: const TextStyle(color: Colors.black)),
                                                                                TextSpan(text: ' ${locale.general!} ', style: const TextStyle(color: Colors.blue)),
                                                                                TextSpan(text: locale.bmi!, style: const TextStyle(color: Colors.black)),
                                                                              ]),
                                                                      )),
                                                                    ],
                                                                    rows: dataTable2
                                                                        .map((e) => DataRow(selected: false, cells: [
                                                                              DataCell(Text(
                                                                                e.type2,
                                                                                textAlign: TextAlign.center,
                                                                              )),
                                                                              DataCell(Text(
                                                                                e.asian,
                                                                                textAlign: TextAlign.center,
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
                      16.height,
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (_weightController.text != '' &&
                                        _heightController.text != '') {
                                      update(
                                          _weightController.value.text,
                                          _heightController.value.text,
                                          userData.ethnicity ?? 'No data',
                                          userData.bmi ?? 'No data');

                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.success(
                                          message: locale.success_profile!,
                                        ),
                                      );
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomePage(),
                                          ));
                                    } else {
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.error(
                                          message: locale.update_error!,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(locale.update_profile_button!)),
                              ElevatedButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.redAccent),
                                                  child: Text(locale.no!)),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    await AppUser.instance
                                                        .signOut();
                                                    Navigator.popAndPushNamed(
                                                        context, 'login');
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              Colors.green),
                                                  child: Text(locale.yes!)),
                                            ],
                                            title:
                                                Text(locale.confirmToLogout!));
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.redAccent),
                                  child: Text(locale.logout!)),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> update(
      String weight, String height, String ethnicity, String bmi) {
    return users
        // existing document in 'users' collection: "ABC123"
        .doc(AppUser.instance.user!.uid)
        .set({
          'weight': weight,
          'height': height,
          'ethnicity': ethnicity,
          'bmi': bmi,
        }, SetOptions(merge: true))
        .then((value) => print("'bmi' merged with existing data!"))
        .catchError((error) => print("Failed to merge data: $error"));
  }

  Future<void> init() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users')
        .doc(AppUser.instance.user!.uid)
        .get()
        .then((value) {
      setState(() {
        _height = value['height'];
        _weight = value['weight'];
        ethnic = value['ethnicity'];
        bmi = value['bmi'];
        print(bmi);
      });
    }).catchError((e) {
      setState(() {
        _height = '';
        _weight = '';
      });
    });
  }
}
