import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../Locale/locales.dart';
import '../components/profile_form.component.dart';
import '../constants/constant.dart';
import '../models/user.model.dart';
import '../providers/user.provider.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  UpdateProfilePageState createState() => UpdateProfilePageState();
}

class UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppUser().user!.uid)
        .get()
        .then((value) => setState(() {
              userData.gender = value.get('gender');
              userData.title = value.get('title');
              userData.dob = value.get('date of birth');
              userData.country = value.get('country');
              userData.state = value.get('state');
              userData.city = value.get('city');
              userData.postcode = value.get('postcode');
              userData.address1 = value.get('address line 1');
              userData.address2 = value.get('address line 2');
              userData.address3 = value.get('address line 3');
            }));
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
        appBar: AppBar(
          leading: Align(
              child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              //size: 20,
              color: Colors.white,
            ),
          )),

          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          // automaticallyImplyLeading: true,
        ),
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
                      update: true,
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
                  //TODO : Add name ??
                  if (userData.gender != null &&
                      userData.title != null &&
                      userData.dob != null &&
                      userData.country != null &&
                      userData.state != null &&
                      userData.city != null &&
                      userData.postcode != null &&
                      userData.address1 != null &&
                      userData.address2 != null &&
                      userData.address3 != null) {
                    update(
                        userData.gender!,
                        userData.title!,
                        userData.dob!,
                        userData.country!,
                        userData.state!,
                        userData.city!,
                        userData.postcode!,
                        userData.address1!,
                        userData.address2!,
                        userData.address3!);
                    showTopSnackBar(
                      context,
                      CustomSnackBar.success(
                        message: locale.success_profile!,
                      ),
                    );
                    Navigator.pop(context);
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

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> update(
      String gender,
      String title,
      String dob,
      String country,
      String state,
      String city,
      String postcode,
      String address1,
      String address2,
      String address3) {
    return users
        // existing document in 'users' collection: "ABC123"
        .doc(AppUser.instance.user!.uid)
        .set({
          'gender': gender,
          'title': title,
          'dob': dob,
          'country': country,
          'state': state,
          'city': city,
          'postcode': postcode,
          'address line 1': address1,
          'address line 2': address2,
          'address line 3': address3,
        }, SetOptions(merge: true))
        .then((value) => print("Update merged with existing data!"))
        .catchError((error) => print("Failed to merge data: $error"));
  }
}
