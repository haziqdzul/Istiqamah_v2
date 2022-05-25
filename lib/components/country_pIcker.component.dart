import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/user.model.dart';

class MLCountryPickerComponent extends StatefulWidget {
  static String tag = '/MLCountryPickerComponent';

  const MLCountryPickerComponent({Key? key}) : super(key: key);

  @override
  MLCountryPickerComponentState createState() =>
      MLCountryPickerComponentState();
}

class MLCountryPickerComponentState extends State<MLCountryPickerComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        CountryCodePicker(
          onChanged: (code) {
            log;
            setState(() {
              userData.cc = code.dialCode;
            });
          },
          initialSelection: 'MY',
          favorite: const ['+60'],
          showFlag: false,
          alignLeft: false,
          padding: const EdgeInsets.all(0),
        ),
        // const Icon(Icons.arrow_drop_down, size: 16).paddingRight(0.0),
      ],
    );
  }
}
