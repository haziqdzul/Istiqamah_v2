class User {
  static final User _userData = User._internal();
  String? gender;
  String? title;
  String? dob;
  String? country;
  String? state;
  String? city;
  String? postcode;
  String? address1;
  String? address2;
  String? address3;
  String? phoneNo;
  String? ethnicity;
  String? height;
  String? weight;
  String? bmi;
  String? cc;
  String? email;
  String? password;
  bool? complete;

  factory User() {
    return _userData;
  }

  User._internal();
}

final userData = User();

