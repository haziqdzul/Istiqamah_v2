import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // collection reference
  FirebaseFirestore fs = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

// TODO: FUNCTION TO SAVE USER DATA TO DATABASE
//save user detail
  Future<void> userData(
      String gender,
      String title,
      String dob,
      String country,
      String state,
      String city,
      String pCode,
      String ad1,
      String ad2,
      String ad3,
      String eth,
      String pNo,
      String height,
      String weight,
      String bmi) async {
    return await users.doc(uid).set({
      'uid': uid,
      'gender': gender,
      'title': title,
      'date of birth': dob,
      'country': country,
      'state': state,
      'city': city,
      'postcode': pCode,
      'address line 1': ad1,
      'address line 2': ad2,
      'address line 3': ad3,
      'ethnicity': eth,
      'phone number': pNo,
      'height': height,
      'weight': weight,
      'bmi': bmi,
    });
  }

  Future<bool> checkData(String uid) async {
    if (users.doc(uid).id == uid) {
      return await users.get().then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) return true;
        return false;
      });
    }
    return false;
  }
}
