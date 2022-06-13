import 'package:flutter/material.dart';
import 'package:istiqamah_app/screen/verify.phone.number.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../Locale/locales.dart';
import '../components/profile_form.component.dart';
import '../constants/constant.dart';
import '../models/user.model.dart';

class MLUpdateProfileScreen extends StatefulWidget {
  const MLUpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _MLUpdateProfileScreenState createState() => _MLUpdateProfileScreenState();
}

class _MLUpdateProfileScreenState extends State<MLUpdateProfileScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Container(
      decoration: const BoxDecoration(
        color: kSecondaryColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24.0),
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: 32)),
              height: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    54.height,
                    Text(locale.updateYourInformation!,
                        style: boldTextStyle(size: 24)),
                    32.height,
                    const MLProfileFormComponent(
                      update: false,
                    ),
                    42.height,
                  ],
                ),
              ),
            ),

            ///back button///
            // Positioned(top: 45, child: mlBackToPrevious(context, blackColor)),
            Positioned(
              bottom: 8,
              left: 16,
              right: 16,
              child: AppButton(
                height: 50,
                width: context.width(),
                color: kPrimaryColor,
                onTap: () async {
                  if (userData.gender != null &&
                      userData.title != null &&
                      userData.dob != null &&
                      userData.country != null &&
                      userData.state != null &&
                      userData.city != null &&
                      // userData.postcode != null &&
                      // userData.address1 != null &&
                      userData.phoneNo != null &&
                      userData.complete == true) {
                    //todo: pass phone number to next screen to verify
                    VerifyPhoneNumberScreen(
                      phoneNumber: '${userData.cc}${userData.phoneNo}',
                    ).launch(context);
                  } else {
                    showTopSnackBar(
                      context,
                      CustomSnackBar.error(
                        message: locale.fillAllInformation!,
                      ),
                    );
                  }
                },
                child: Text(locale.next!, style: boldTextStyle(color: black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
