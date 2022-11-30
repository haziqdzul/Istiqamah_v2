import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Locale/locales.dart';
import '../constants/constant.dart';
import '../models/states.dart';
import '../models/user.model.dart';
import '../widgets/colors.dart';
import 'country_pIcker.component.dart';

class MLProfileFormComponent extends StatefulWidget {
  static String tag = '/MLProfileFormComponent';
  final bool update;

  const MLProfileFormComponent({required this.update, Key? key})
      : super(key: key);

  @override
  MLProfileFormComponentState createState() => MLProfileFormComponentState();
}

class MLProfileFormComponentState extends State<MLProfileFormComponent> {
  String postcode = '';
  String address1 = '';
  String address2 = '';
  String address3 = '';
  int? _groupValue;
  late List<FocusNode> _focusNodes;
  List<StateModel> stateList = [];

  String country = 'Malaysia';

  int j = 0;

  List state = [];

  var stateValue;

  List _district = ['Select City'];

  var districtValue = 'Select City';

  @override
  void initState() {
    super.initState();

    init();

    _focusNodes = Iterable<int>.generate(3).map((e) => FocusNode()).toList();

    _focusNodes[0].requestFocus();
  }

  Future<void> init() async {
    getAllState();
    if (userData.state != null) {
      getAllCity(userData.state!);
    }
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  String _date = 'DD-MM-YYYY';
  var _now = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  String gender = 'Choose gender';
  String jantina = 'Pilih jantina';
  String negeri = 'Choose/Pilih';
  String dropdownvalue3 = 'Choose/Pilih';

  var selectedState = 'Choose state/Pilih negeri';
  String selectedCity = 'Choose city';
  String selectedCity1 = 'Choose city';
  String selectedCity2 = 'Choose city';
  String selectedCity3 = 'Choose city';
  String selectedCity4 = 'Choose city';
  String selectedCity5 = 'Choose city';
  String selectedCity6 = 'Choose city';
  String selectedCity7 = 'Choose city';
  String selectedCity8 = 'Choose city';
  String selectedCity9 = 'Choose city';
  String selectedCity10 = 'Choose city';
  String selectedCity11 = 'Choose city';
  String selectedCity12 = 'Choose city';
  String selectedCity13 = 'Choose city';
  String selectedCity14 = 'Choose city';
  String selectedCity15 = 'Choose city';

  var items = [
    'Choose gender',
    'Male',
    'Female',
  ];

  var itemss = [
    'Pilih jantina',
    'Lelaki',
    'Perempuan',
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    if (country == 'Malaysia') {
      userData.country = 'Malaysia';
      userData.cc = '+60';
    }
    Widget _buildItem(String text, int value, FocusNode focusNode) {
      return Row(
        children: [
          Radio<int>(
            groupValue: _groupValue,
            value: value,
            onChanged: (int? value) {
              setState(() {
                _groupValue = value;
                // if (_groupValue == 1) userData.title = 'Datuk/Datin';
                if (_groupValue == 2) {
                  if (userData.gender == locale.male!) {
                    userData.title = locale.mr;
                  }
                  if (userData.gender == locale.female!) {
                    userData.title = locale.mrs;
                  }
                }
              });
            },
            hoverColor: Colors.yellow,
            activeColor: Colors.pink,
            focusColor: Colors.purple,
            fillColor:
                MaterialStateColor.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.orange;
              } else if (states.contains(MaterialState.selected)) {
                return Colors.teal;
              }
              if (states.contains(MaterialState.focused)) {
                return Colors.blue;
              } else {
                return Colors.black12;
              }
            }),
            overlayColor:
                MaterialStateColor.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.lightGreenAccent;
              }
              if (states.contains(MaterialState.focused)) {
                return Colors.brown;
              } else {
                return Colors.white;
              }
            }),
            splashRadius: 25,
            toggleable: true,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            focusNode: focusNode,
          ),
          Text(text),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(locale.gender!, style: boldTextStyle()),
            Text(' *', style: boldTextStyle(color: Colors.redAccent)),
          ],
        ),
        if (locale.gender == 'Gender')
          DropdownButton(
            isExpanded: true,
            value: items.contains(userData.gender)
                ? userData.gender ?? gender
                : gender,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((String items) {
              return DropdownMenuItem(value: items, child: Text(items));
            }).toList(),
            onChanged: (String? newValue) {
              //TODO: SET GENDER FOR ENG VERSION
              setState(() {
                gender = newValue!;
                userData.gender = newValue;
              });
            },
          ),
        if (locale.gender == 'Jantina')
          DropdownButton(
            value: itemss.contains(userData.gender)
                ? userData.gender ?? jantina
                : jantina,
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            items: itemss.map((String items) {
              return DropdownMenuItem(value: items, child: Text(items));
            }).toList(),
            onChanged: (String? newValue) {
              //TODO: SET GENDER FOR BM VERSION
              setState(() {
                jantina = newValue!;
                userData.gender = newValue;
              });
            },
          ),
        16.height,
        Row(
          children: [
            Text(locale.title!, style: boldTextStyle()),
            Text(' *', style: boldTextStyle(color: Colors.redAccent)),
          ],
        ),
        Row(
          children: [
            // _buildItem("Datuk/Datin", 1, _focusNodes[0]),
            // 5.width,
            if (gender == 'Male' ||
                jantina == 'Lelaki' ||
                userData.gender == 'Male' ||
                userData.gender == 'Lelaki')
              _buildItem(locale.mr!, 2, _focusNodes[1]),

            if (gender == 'Female' ||
                jantina == 'Perempuan' ||
                userData.gender == 'Female' ||
                userData.gender == 'Perempuan')
              _buildItem(locale.mrs!, 2, _focusNodes[1]),
            5.width,
            _buildItem(locale.other!, 3, _focusNodes[2]),
          ],
        ),
        if (_groupValue == 3) 16.height,
        if (_groupValue == 3)
          Row(
            children: [
              Text(locale.other!, style: boldTextStyle()),
              Text(' *', style: boldTextStyle(color: Colors.redAccent)),
            ],
          ),
        if (_groupValue == 3)
          AppTextField(
            onChanged: (value) => setState(() {
              //TODO : SET TITLE
              userData.title = value;
            }),
            suffix: const Icon(Icons.mode_edit),
            decoration: InputDecoration(
              hintText: locale.fillYourTitle,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kGreyColor),
              ),
            ),
            textFieldType: TextFieldType.NAME,
          ),
        16.height,
        Row(
          children: [
            Text(locale.dateOfBirth!, style: boldTextStyle()),
            Text(' *', style: boldTextStyle(color: Colors.redAccent)),
          ],
        ),
        AppTextField(
          readOnly: true,
          textFieldType: TextFieldType.OTHER,
          decoration: InputDecoration(
            hintText: userData.dob ?? _date,
            hintStyle: secondaryTextStyle(size: 16),
            suffixIcon: InkWell(
                onTap: () {
                  var now = DateTime.now();
                  DatePicker.showDatePicker(
                    context,
                    theme: DatePickerTheme(
                        backgroundColor: Colors.white,
                        headerColor: Colors.grey[100],
                        doneStyle: const TextStyle(
                            color: Colors.blueAccent, fontSize: 18),
                        cancelStyle:
                            const TextStyle(color: Colors.red, fontSize: 18),
                        itemStyle:
                            const TextStyle(color: Colors.black, fontSize: 18)),
                    showTitleActions: true,
                    minTime: DateTime(1900, 1, 1),
                    maxTime: DateTime(now.year - 4, 12, 31),
                    onChanged: (date) {},
                    onConfirm: (date) {
                      //TODO:SET BIRTHDATE
                      var now = DateFormat("dd-MM-yyyy").format(date);
                      setState(() {
                        _date = now;
                        userData.dob = _date;
                        _now = date;
                      });
                    },
                    currentTime: _now,
                  );
                },
                child: const Icon(
                  Icons.calendar_today_outlined,
                  color: kPrimaryColor,
                )),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kGreyColor),
            ),
          ),
        ),
        16.height,
        Row(
          children: [
            Text(locale.country!, style: boldTextStyle()),
            Text(' *', style: boldTextStyle(color: Colors.redAccent)),
          ],
        ),
        CountryListPick(
          appBar: AppBar(
            backgroundColor: ManyColors.textColor2,
            title: Text(locale.pickYourCountry!),
            centerTitle: true,
          ),

          theme: CountryTheme(
            isShowFlag: true,
            isShowTitle: true,
            isShowCode: false,
            isDownIcon: true,
            showEnglishName: true,
          ),
          initialSelection: '+60',
          // or
          // initialSelection: 'US'
          onChanged: (CountryCode? code) {
            //TODO: SET COUNTRY
            setState(() {
              country = code!.name.toString().trim();
              userData.country = country;
            });

            print(country);
          },
        ),
        16.height,
        Row(
          children: [
            Text(locale.state!, style: boldTextStyle()),
            Text(' *', style: boldTextStyle(color: Colors.redAccent)),
          ],
        ),
        if (country != 'Malaysia')
          AppTextField(
            onChanged: (value) => setState(() {
              //TODO:SET STATE FOR USER NOT IN MALAYSIA
              selectedState = value;
              userData.state = selectedState;
            }),
            decoration: InputDecoration(
              hintText: locale.enterState,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kGreyColor),
              ),
            ),
            textFieldType: TextFieldType.NAME,
          ),
        if (country == 'Malaysia')
          DropdownButton(
              value: stateValue,
              isExpanded: true,
              icon: const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Icon(Icons.arrow_drop_down),
              ),
              iconSize: 25,
              onChanged: (Object? e) {
                //TODO:SET STATE FOR USER IN MALAYSIA
                setState(() {
                  districtValue = 'Select City';
                  getAllCity(e.toString());
                  stateValue = e.toString();
                  userData.state = e.toString();
                  selectedState = e.toString();
                });
                print(selectedState);
              },
              hint: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(locale.state!),
              ),
              items: state.map((data) {
                return DropdownMenuItem(
                  value: data['code'],
                  child: Text(
                    data['name'],
                  ),
                );
              }).toList()),
        16.height,
        Visibility(
            visible: _district.length > 1 ? false : true,
            child: const Center(child: Text('Loading ...'))),
        Visibility(
          visible: _district.length > 1 || country != 'Malaysia' ? true : false,
          child: Row(
            children: [
              Text(locale.city!, style: boldTextStyle()),
              Text(' *', style: boldTextStyle(color: Colors.redAccent)),
            ],
          ),
        ),
        Visibility(
          visible: country != 'Malaysia' ? true : false,
          child: AppTextField(
            onChanged: (value) => setState(() {
              //TODO:SET CITY FOR USER NOT IN MALAYSIA
              selectedCity = value;
              userData.city = selectedCity;
            }),
            decoration: InputDecoration(
              hintText: userData.city ?? locale.enterCity,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kGreyColor),
              ),
            ),
            textFieldType: TextFieldType.NAME,
          ),
        ),
        Visibility(
          visible: _district.length > 1 && country == 'Malaysia' ? true : false,
          child: DropdownButton(
            value: _district.contains(userData.city)
                ? userData.city ?? districtValue
                : districtValue,
            isExpanded: true,
            icon: const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Icon(Icons.arrow_drop_down),
            ),
            items: _district.map((data) {
              return DropdownMenuItem(value: data, child: Text('$data'));
            }).toList(),
            onChanged: (Object? e) {
              //TODO:SET CITY FOR USER IN MALAYSIA
              setState(() {
                districtValue = e.toString();
                userData.city = e.toString();
              });
              print(districtValue);
            },
            hint: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(locale.enterPostCode!),
            ),
          ),
        ),
        16.height,
        Visibility(
          visible: _district.length > 1 ? true : false,
          child: Row(
            children: [
              Text(locale.postcode!, style: boldTextStyle()),
              //Text(' *', style: boldTextStyle(color: Colors.redAccent)),
            ],
          ),
        ),
        Visibility(
          visible: _district.length > 1 ? true : false,
          child: AppTextField(
            onChanged: (v) => setState(() {
              //TODO: SET POSTCODE
              postcode = v;
              userData.postcode = v;
            }),
            textFieldType: TextFieldType.PHONE,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              hintText: userData.postcode ?? locale.enterPostCode,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kGreyColor),
              ),
            ),
          ),
        ),
        16.height,
        Visibility(
          visible: _district.length > 1 ? true : false,
          child: Row(
            children: [
              Text(locale.address1!, style: boldTextStyle()),
              //Text(' *', style: boldTextStyle(color: Colors.redAccent)),
            ],
          ),
        ),
        Visibility(
          visible: _district.length > 1 ? true : false,
          child: AppTextField(
            textFieldType: TextFieldType.NAME,
            onChanged: (v) => setState(() {
              //TODO:SET ADDRESS LINE 1
              address1 = v;
              userData.address1 = v;
            }),
            decoration: InputDecoration(
              hintText: userData.address1 != ''
                  ? userData.address1 ?? locale.enterAddress1
                  : locale.enterAddress1,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kGreyColor),
              ),
            ),
          ),
        ),
        16.height,
        Visibility(
          visible: _district.length > 1 ? true : false,
          child: Row(
            children: [
              Text(locale.address2!, style: boldTextStyle()),
              Text('', style: boldTextStyle(color: Colors.redAccent)),
            ],
          ),
        ),
        Visibility(
          visible: _district.length > 1 ? true : false,
          child: AppTextField(
            textFieldType: TextFieldType.NAME,
            onChanged: (v) => setState(() {
              //TODO:SET ADDRESS LINE 2
              address2 = v;
              userData.address2 = v;
            }),
            decoration: InputDecoration(
              hintText: userData.address2 != ''
                  ? userData.address2 ?? locale.enterAddress2
                  : locale.enterAddress2,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kGreyColor),
              ),
            ),
          ),
        ),
        16.height,
        Visibility(
          visible: _district.length > 1 ? true : false,
          child: Row(
            children: [
              Text(locale.address3!, style: boldTextStyle()),
              Text('', style: boldTextStyle(color: Colors.redAccent)),
            ],
          ),
        ),
        Visibility(
          visible: _district.length > 1 ? true : false,
          child: AppTextField(
            textFieldType: TextFieldType.NAME,
            onChanged: (v) => setState(() {
              //TODO:SET ADDRESS LINE 3
              address3 = v;
              userData.address3 = v;
            }),
            decoration: InputDecoration(
              hintText: userData.address3 != ''
                  ? userData.address3 ?? locale.enterAddress3
                  : locale.enterAddress3,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kGreyColor),
              ),
            ),
          ),
        ),
        16.height,
        Visibility(
          visible: _district.length > 1 && !widget.update ? true : false,
          child: Row(
            children: [
              Text(locale.phoneNumber!, style: boldTextStyle()),
              Text(' *', style: boldTextStyle(color: Colors.redAccent)),
            ],
          ),
        ),
        Visibility(
          visible: _district.length > 1 && !widget.update ? true : false,
          child: Row(
            children: [
              const MLCountryPickerComponent(),
              const SizedBox(width: 5),
              AppTextField(
                onChanged: (v) => setState(() {
                  //TODO:SET PHONE NUMBER
                  userData.phoneNo = v;
                  userData.complete = true;
                }),
                textFieldType: TextFieldType.PHONE,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: userData.phoneNo ?? 'e.g: 12 345 6789',
                  labelStyle: secondaryTextStyle(size: 16),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: kGreyColor),
                  ),
                ),
              ).expand(),
            ],
          ),
        ),
        16.height,
      ],
    );
  }

  Future<void> getAllState() async {
    final collectionState = FirebaseFirestore.instance.collection('states');
    List states = await collectionState
        .orderBy('name', descending: false)
        .get()
        .then((snapshot) => snapshot.docs);
    setState(() {
      state = states;
    });
  }

  Future<void> getAllCity(String code) async {
    setState(() {
      _district = ['Select City'];
    });
    final collectionState = FirebaseFirestore.instance.collection('postcode');
    await collectionState
        .where('unknown', isEqualTo: code)
        .orderBy('state')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        setState(() {
          if (!_district.contains(doc['state'])) {
            _district.add(doc['state']);
          }
        });
      }
      print(_district.length);
    });
  }
}
