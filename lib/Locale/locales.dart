import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'dart:async';
import 'Languages/arabic.dart';
import 'Languages/english.dart';
import 'Languages/french.dart';
import 'Languages/indonesian.dart';
import 'Languages/italian.dart';
import 'Languages/portuguese.dart';
import 'Languages/spanish.dart';
import 'Languages/swahili.dart';
import 'Languages/turkish.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': english(),
    'ar': arabic(),
    'pt': portuguese(),
    'fr': french(),
    'id': indonesian(),
    'es': spanish(),
    'tr': turkish(),
    'it': italian(),
    'sw': swahili(),
    // 'ms': malaysian()
  };

  String? get setting_profile {
    return _localizedValues[locale.languageCode]!['setting_profile'];
  }
  String? get update_error {
    return _localizedValues[locale.languageCode]!['update_error'];
  }
  String? get dayAgo {
    return _localizedValues[locale.languageCode]!['dayAgo'];
  }

  String? get hourAgo {
    return _localizedValues[locale.languageCode]!['hourAgo'];
  }

  String? get minuteAgo {
    return _localizedValues[locale.languageCode]!['minuteAgo'];
  }

  String? get secondAgo {
    return _localizedValues[locale.languageCode]!['secondAgo'];
  }

  String? get justNow {
    return _localizedValues[locale.languageCode]!['justNow'];
  }

  String? get selectIntake {
    return _localizedValues[locale.languageCode]!['selectIntake'];
  }

  String? get intake {
    return _localizedValues[locale.languageCode]!['intake'];
  }

  String? get sHadithP {
    return _localizedValues[locale.languageCode]!['sHadithP'];
  }

  String? get sQuranP {
    return _localizedValues[locale.languageCode]!['sQuranP'];
  }

  String? get asian {
    return _localizedValues[locale.languageCode]!['asian'];
  }

  String? get general {
    return _localizedValues[locale.languageCode]!['general'];
  }

  String? get who {
    return _localizedValues[locale.languageCode]!['who'];
  }

  String? get bmi {
    return _localizedValues[locale.languageCode]!['bmi'];
  }

  String? get strongHadisT {
    return _localizedValues[locale.languageCode]!['strongHadisT'];
  }

  String? get strongHadisS {
    return _localizedValues[locale.languageCode]!['strongHadisS'];
  }

  String? get strongHadisM {
    return _localizedValues[locale.languageCode]!['strongHadisM'];
  }

  String? get strongHadisW {
    return _localizedValues[locale.languageCode]!['strongHadisW'];
  }

  String? get strongQuranT {
    return _localizedValues[locale.languageCode]!['strongQuranT'];
  }

  String? get strongQuranS {
    return _localizedValues[locale.languageCode]!['strongQuranS'];
  }

  String? get strongQuranM {
    return _localizedValues[locale.languageCode]!['strongQuranM'];
  }

  String? get doaW {
    return _localizedValues[locale.languageCode]!['doaW'];
  }

  String? get quranHadith {
    return _localizedValues[locale.languageCode]!['quranHadith'];
  }

  String? get unread {
    return _localizedValues[locale.languageCode]!['unread'];
  }

  String? get takeMedicine {
    return _localizedValues[locale.languageCode]!['takeMedicine'];
  }

  String? get view {
    return _localizedValues[locale.languageCode]!['view'];
  }

  String? get text1 {
    return _localizedValues[locale.languageCode]!['text1'];
  }

  String? get text2 {
    return _localizedValues[locale.languageCode]!['text2'];
  }

  String? get text3 {
    return _localizedValues[locale.languageCode]!['text3'];
  }

  String? get text4 {
    return _localizedValues[locale.languageCode]!['text4'];
  }

  String? get update_profile {
    return _localizedValues[locale.languageCode]!['update_profile'];
  }

  String? get enterText_profile {
    return _localizedValues[locale.languageCode]!['enterText_profile'];
  }

  String? get success_profile {
    return _localizedValues[locale.languageCode]!['success_profile'];
  }

  String? get heightcm_profile {
    return _localizedValues[locale.languageCode]!['heightcm_profile'];
  }

  String? get weightkg_profile {
    return _localizedValues[locale.languageCode]!['weightkg_profile'];
  }

  String? get update_profile_button {
    return _localizedValues[locale.languageCode]!['update_profile_button'];
  }

  String? get language_profile {
    return _localizedValues[locale.languageCode]!['language_profile'];
  }

  String? get logout_profile {
    return _localizedValues[locale.languageCode]!['logout_profile'];
  }

  String? get aboutUs_profile {
    return _localizedValues[locale.languageCode]!['aboutUs_profile'];
  }

  String? get notification_history {
    return _localizedValues[locale.languageCode]!['notification_history'];
  }

  String? get sunnah_reminder {
    return _localizedValues[locale.languageCode]!['sunnah_reminder'];
  }

  String? get welcome_home {
    return _localizedValues[locale.languageCode]!['welcome_home'];
  }

  String? get option_profile {
    return _localizedValues[locale.languageCode]!['option_profile'];
  }

  String? get camera_profile {
    return _localizedValues[locale.languageCode]!['camera_profile'];
  }

  String? get gallery_profile {
    return _localizedValues[locale.languageCode]!['gallery_profile'];
  }

  String? get remove_profile {
    return _localizedValues[locale.languageCode]!['remove_profile'];
  }

  String? get visitour_profile {
    return _localizedValues[locale.languageCode]!['visitour_profile'];
  }

  String? get website_profile {
    return _localizedValues[locale.languageCode]!['website_profile'];
  }

  String? get fmi_profile {
    return _localizedValues[locale.languageCode]!['fmi_profile'];
  }

  String? get enterMobileNumber {
    return _localizedValues[locale.languageCode]!['enterMobileNumber'];
  }

  String? get signInNow {
    return _localizedValues[locale.languageCode]!['signInNow'];
  }

  String? get orContinueWith {
    return _localizedValues[locale.languageCode]!['orContinueWith'];
  }

  String? get facebook {
    return _localizedValues[locale.languageCode]!['facebook'];
  }

  String? get support {
    return _localizedValues[locale.languageCode]!['support'];
  }

  String? get account {
    return _localizedValues[locale.languageCode]!['account'];
  }

  String? get hatchback {
    return _localizedValues[locale.languageCode]!['hatchback'];
  }

  String? get google {
    return _localizedValues[locale.languageCode]!['google'];
  }

  String? get am {
    return _localizedValues[locale.languageCode]!['am'];
  }

  String? get logout {
    return _localizedValues[locale.languageCode]!['logout'];
  }

  String? get letUsKnow {
    return _localizedValues[locale.languageCode]!['letUsKnow'];
  }

  String? get pm {
    return _localizedValues[locale.languageCode]!['pm'];
  }

  String? get jun {
    return _localizedValues[locale.languageCode]!['jun'];
  }

  String? get phoneNumber {
    return _localizedValues[locale.languageCode]!['phoneNumber'];
  }

  String? get fullName {
    return _localizedValues[locale.languageCode]!['fullName'];
  }

  String? get title {
    return _localizedValues[locale.languageCode]!['title'];
  }

  String? get ethnicity {
    return _localizedValues[locale.languageCode]!['ethnicity'];
  }

  String? get fillYourTitle {
    return _localizedValues[locale.languageCode]!['fillYourTitle'];
  }

  String? get fillYourEthnicity {
    return _localizedValues[locale.languageCode]!['fillYourEthnicity'];
  }

  String? get mr {
    return _localizedValues[locale.languageCode]!['mr'];
  }

  String? get mrs {
    return _localizedValues[locale.languageCode]!['mrs'];
  }

  String? get emailAddress {
    return _localizedValues[locale.languageCode]!['emailAddress'];
  }

  String? get continuee {
    return _localizedValues[locale.languageCode]!['continuee'];
  }

  String? get backToSignIn {
    return _localizedValues[locale.languageCode]!['backToSignIn'];
  }

  String? get phoneCode {
    return _localizedValues[locale.languageCode]!['phoneCode'];
  }

  String? get enterVerificationCodeWeveSent {
    return _localizedValues[locale.languageCode]![
        'enterVerificationCodeWeveSent'];
  }

  String? get enterVerificationCode {
    return _localizedValues[locale.languageCode]!['enterVerificationCode'];
  }

  String? get verification {
    return _localizedValues[locale.languageCode]!['verification'];
  }

  String? get enter6digit {
    return _localizedValues[locale.languageCode]!['enter6digit'];
  }

  String? get continueWord {
    return _localizedValues[locale.languageCode]!['continueWord'];
  }

  String? get inLessThanAmin {
    return _localizedValues[locale.languageCode]!['inLessThanAmin'];
  }

  String? get getStarted {
    return _localizedValues[locale.languageCode]!['getStarted'];
  }

  String? get enterFullName {
    return _localizedValues[locale.languageCode]!['enterFullName'];
  }

  String? get enterEmailAddress {
    return _localizedValues[locale.languageCode]!['enterEmailAddress'];
  }

  String? get enterPassword {
    return _localizedValues[locale.languageCode]!['enterPassword'];
  }

  String? get enterPhoneNumber {
    return _localizedValues[locale.languageCode]!['enterPhoneNumber'];
  }

  String? get address1 {
    return _localizedValues[locale.languageCode]!['address1'];
  }

  String? get address2 {
    return _localizedValues[locale.languageCode]!['address2'];
  }

  String? get address3 {
    return _localizedValues[locale.languageCode]!['address3'];
  }

  String? get city {
    return _localizedValues[locale.languageCode]!['city'];
  }

  String? get state {
    return _localizedValues[locale.languageCode]!['state'];
  }

  String? get success {
    return _localizedValues[locale.languageCode]!['success'];
  }

  String? get success1 {
    return _localizedValues[locale.languageCode]!['success1'];
  }

  String? get send {
    return _localizedValues[locale.languageCode]!['send'];
  }

  String? get chooseState {
    return _localizedValues[locale.languageCode]!['chooseState'];
  }

  String? get chooseCity {
    return _localizedValues[locale.languageCode]!['chooseCity'];
  }

  String? get postcode {
    return _localizedValues[locale.languageCode]!['postcode'];
  }

  String? get country {
    return _localizedValues[locale.languageCode]!['country'];
  }

  String? get pickYourCountry {
    return _localizedValues[locale.languageCode]!['pickYourCountry'];
  }

  String? get gender {
    return _localizedValues[locale.languageCode]!['gender'];
  }

  String? get selectYourGender {
    return _localizedValues[locale.languageCode]!['selectYourGender'];
  }

  String? get female {
    return _localizedValues[locale.languageCode]!['female'];
  }

  String? get next {
    return _localizedValues[locale.languageCode]!['next'];
  }

  String? get male {
    return _localizedValues[locale.languageCode]!['male'];
  }

  String? get height {
    return _localizedValues[locale.languageCode]!['height'];
  }

  String? get weight {
    return _localizedValues[locale.languageCode]!['weight'];
  }

  String? get noResult {
    return _localizedValues[locale.languageCode]!['noResult'];
  }

  String? get message {
    return _localizedValues[locale.languageCode]!['message'];
  }

  String? get underWeight {
    return _localizedValues[locale.languageCode]!['underWeight'];
  }

  String? get fine {
    return _localizedValues[locale.languageCode]!['fine'];
  }

  String? get overWeight {
    return _localizedValues[locale.languageCode]!['overWeight'];
  }

  String? get obese {
    return _localizedValues[locale.languageCode]!['obese'];
  }

  String? get enterHeight {
    return _localizedValues[locale.languageCode]!['enterHeight'];
  }

  String? get enterWeight {
    return _localizedValues[locale.languageCode]!['enterWeight'];
  }

  String? get enterCountry {
    return _localizedValues[locale.languageCode]!['enterCountry'];
  }

  String? get enterCity {
    return _localizedValues[locale.languageCode]!['enterCity'];
  }

  String? get enterPostCode {
    return _localizedValues[locale.languageCode]!['enterPostCode'];
  }

  String? get enterState {
    return _localizedValues[locale.languageCode]!['enterState'];
  }

  String? get enterAddress1 {
    return _localizedValues[locale.languageCode]!['enterAddress1'];
  }

  String? get enterAddress2 {
    return _localizedValues[locale.languageCode]!['enterAddress2'];
  }

  String? get enterAddress3 {
    return _localizedValues[locale.languageCode]!['enterAddress3'];
  }

  String? get reenterPassword {
    return _localizedValues[locale.languageCode]!['reenterPassword'];
  }

  String? get termText {
    return _localizedValues[locale.languageCode]!['termText'];
  }

  String? get forgotPassword {
    return _localizedValues[locale.languageCode]!['forgotPassword'];
  }

  String? get rememberMe {
    return _localizedValues[locale.languageCode]!['rememberMe'];
  }

  String? get wellSendCode {
    return _localizedValues[locale.languageCode]!['wellSendCode'];
  }

  String? get searchLocation {
    return _localizedValues[locale.languageCode]!['searchLocation'];
  }

  String? get now {
    return _localizedValues[locale.languageCode]!['now'];
  }

  String? get panadolSkip {
    return _localizedValues[locale.languageCode]!['panadolSkip'];
  }

  String? get skipAfiyah {
    return _localizedValues[locale.languageCode]!['skipAfiyah'];
  }

  String? get skipWater {
    return _localizedValues[locale.languageCode]!['skipWater'];
  }

  String? get skipTahajjud {
    return _localizedValues[locale.languageCode]!['skipTahajjud'];
  }

  String? get skipSedekah {
    return _localizedValues[locale.languageCode]!['skipSedekah'];
  }

  String? get panadolReminder {
    return _localizedValues[locale.languageCode]!['panadolReminder'];
  }

  String? get drink {
    return _localizedValues[locale.languageCode]!['drink'];
  }

  String? get give {
    return _localizedValues[locale.languageCode]!['give'];
  }

  String? get perform {
    return _localizedValues[locale.languageCode]!['perform'];
  }

  String? get find {
    return _localizedValues[locale.languageCode]!['find'];
  }

  String? get bookings {
    return _localizedValues[locale.languageCode]!['bookings'];
  }

  String? get more {
    return _localizedValues[locale.languageCode]!['more'];
  }

  String? get product {
    return _localizedValues[locale.languageCode]!['product'];
  }

  String? get tahajjud {
    return _localizedValues[locale.languageCode]!['tahajjud'];
  }

  String? get sedekah {
    return _localizedValues[locale.languageCode]!['sedekah'];
  }

  String? get medicine {
    return _localizedValues[locale.languageCode]!['medicine'];
  }

  String? get water {
    return _localizedValues[locale.languageCode]!['water'];
  }

  String? get home {
    return _localizedValues[locale.languageCode]!['home'];
  }

  String? get other {
    return _localizedValues[locale.languageCode]!['other'];
  }

  String? get office {
    return _localizedValues[locale.languageCode]!['office'];
  }

  String? get bookSpot {
    return _localizedValues[locale.languageCode]!['bookSpot'];
  }

  String? get spots {
    return _localizedValues[locale.languageCode]!['spots'];
  }

  String? get workingHours {
    return _localizedValues[locale.languageCode]!['workingHours'];
  }

  String? get openNow {
    return _localizedValues[locale.languageCode]!['openNow'];
  }

  String? get info {
    return _localizedValues[locale.languageCode]!['info'];
  }

  String? get facilities {
    return _localizedValues[locale.languageCode]!['facilities'];
  }

  String? get coveredRoof {
    return _localizedValues[locale.languageCode]!['coveredRoof'];
  }

  String? get camera {
    return _localizedValues[locale.languageCode]!['camera'];
  }

  String? get overnight {
    return _localizedValues[locale.languageCode]!['overnight'];
  }

  String? get charging {
    return _localizedValues[locale.languageCode]!['charging'];
  }

  String? get disabledParking {
    return _localizedValues[locale.languageCode]!['disabledParking'];
  }

  String? get selectVehicle {
    return _localizedValues[locale.languageCode]!['selectVehicle'];
  }

  String? get change {
    return _localizedValues[locale.languageCode]!['change'];
  }

  String? get selectHours {
    return _localizedValues[locale.languageCode]!['selectHours'];
  }

  String? get aboutUs {
    return _localizedValues[locale.languageCode]!['aboutUs'];
  }

  String? get min {
    return _localizedValues[locale.languageCode]!['min'];
  }

  String? get hours {
    return _localizedValues[locale.languageCode]!['hours'];
  }

  String? get paymentMode {
    return _localizedValues[locale.languageCode]!['paymentMode'];
  }

  String? get wallet {
    return _localizedValues[locale.languageCode]!['wallet'];
  }

  String? get payOnSpot {
    return _localizedValues[locale.languageCode]!['payOnSpot'];
  }

  String? get creditCard {
    return _localizedValues[locale.languageCode]!['creditCard'];
  }

  String? get paypal {
    return _localizedValues[locale.languageCode]!['paypal'];
  }

  String? get pay {
    return _localizedValues[locale.languageCode]!['pay'];
  }

  String? get close {
    return _localizedValues[locale.languageCode]!['close'];
  }

  String? get yayBooked {
    return _localizedValues[locale.languageCode]!['yayBooked'];
  }

  String? get youveBooked {
    return _localizedValues[locale.languageCode]!['youveBooked'];
  }

  String? get parkingId {
    return _localizedValues[locale.languageCode]!['parkingId'];
  }

  String? get vehicle {
    return _localizedValues[locale.languageCode]!['vehicle'];
  }

  String? get payment {
    return _localizedValues[locale.languageCode]!['payment'];
  }

  String? get parkingSpot {
    return _localizedValues[locale.languageCode]!['parkingSpot'];
  }

  String? get enterAfter {
    return _localizedValues[locale.languageCode]!['enterAfter'];
  }

  String? get exitBefore {
    return _localizedValues[locale.languageCode]!['exitBefore'];
  }

  String? get getDirection {
    return _localizedValues[locale.languageCode]!['getDirection'];
  }

  String? get myBookings {
    return _localizedValues[locale.languageCode]!['myBookings'];
  }

  String? get parkingTimeEnds {
    return _localizedValues[locale.languageCode]!['parkingTimeEnds'];
  }

  String? get addTime {
    return _localizedValues[locale.languageCode]!['addTime'];
  }

  String? get repark {
    return _localizedValues[locale.languageCode]!['repark'];
  }

  String? get parkedOn {
    return _localizedValues[locale.languageCode]!['parkedOn'];
  }

  String? get quickPayments {
    return _localizedValues[locale.languageCode]!['quickPayments'];
  }

  String? get myVehicle {
    return _localizedValues[locale.languageCode]!['myVehicle'];
  }

  String? get manageAddress {
    return _localizedValues[locale.languageCode]!['manageAddress'];
  }

  String? get privacyPolicy {
    return _localizedValues[locale.languageCode]!['privacyPolicy'];
  }

  String? get termCondition {
    return _localizedValues[locale.languageCode]!['termCondition'];
  }

  String? get and {
    return _localizedValues[locale.languageCode]!['and'];
  }

  String? get faq {
    return _localizedValues[locale.languageCode]!['faq'];
  }

  String? get language {
    return _localizedValues[locale.languageCode]!['language'];
  }

  String? get preferredLanguage {
    return _localizedValues[locale.languageCode]!['preferredLanguage'];
  }

  String? get addVehicleinfo {
    return _localizedValues[locale.languageCode]!['addVehicleinfo'];
  }

  String? get presavedAddress {
    return _localizedValues[locale.languageCode]!['presavedAddress'];
  }

  String? get connectUsFor {
    return _localizedValues[locale.languageCode]!['connectUsFor'];
  }

  String? get knowPrivacy {
    return _localizedValues[locale.languageCode]!['knowPrivacy'];
  }

  String? get setYourlanguage {
    return _localizedValues[locale.languageCode]!['setYourlanguage'];
  }

  String? get getYouranswers {
    return _localizedValues[locale.languageCode]!['getYouranswers'];
  }

  String? get myProfile {
    return _localizedValues[locale.languageCode]!['myProfile'];
  }

  String? get everythingAboutyou {
    return _localizedValues[locale.languageCode]!['everythingAboutyou'];
  }

  String? get writeyourMessage {
    return _localizedValues[locale.languageCode]!['writeyourMessage'];
  }

  String? get availableBalance {
    return _localizedValues[locale.languageCode]!['availableBalance'];
  }

  String? get addMoney {
    return _localizedValues[locale.languageCode]!['addMoney'];
  }

  String? get sendToBank {
    return _localizedValues[locale.languageCode]!['sendToBank'];
  }

  String? get paidForParking {
    return _localizedValues[locale.languageCode]!['paidForParking'];
  }

  String? get addedToWallet {
    return _localizedValues[locale.languageCode]!['addedToWallet'];
  }

  String? get receivedFrom {
    return _localizedValues[locale.languageCode]!['receivedFrom'];
  }

  String? get vehiclesYouOwn {
    return _localizedValues[locale.languageCode]!['vehiclesYouOwn'];
  }

  String? get addNewWehicle {
    return _localizedValues[locale.languageCode]!['addNewWehicle'];
  }

  String? get addVehicle {
    return _localizedValues[locale.languageCode]!['addVehicle'];
  }

  String? get vehicleType {
    return _localizedValues[locale.languageCode]!['vehicleType'];
  }

  String? get vehicleName {
    return _localizedValues[locale.languageCode]!['vehicleName'];
  }

  String? get vehicleReg {
    return _localizedValues[locale.languageCode]!['vehicleReg'];
  }

  String? get addLandmark {
    return _localizedValues[locale.languageCode]!['addLandmark'];
  }

  String? get writeAddressLandmark {
    return _localizedValues[locale.languageCode]!['writeAddressLandmark'];
  }

  String? get connectUs {
    return _localizedValues[locale.languageCode]!['connectUs'];
  }

  String? get writeUs {
    return _localizedValues[locale.languageCode]!['writeUs'];
  }

  String? get email {
    return _localizedValues[locale.languageCode]!['email'];
  }

  String? get name {
    return _localizedValues[locale.languageCode]!['name'];
  }

  String? get subject {
    return _localizedValues[locale.languageCode]!['subject'];
  }

  String? get emailMessage {
    return _localizedValues[locale.languageCode]!['emailMessage'];
  }

  String? get submit {
    return _localizedValues[locale.languageCode]!['submit'];
  }

  String? get saveAddress {
    return _localizedValues[locale.languageCode]!['saveAddress'];
  }

  String? get addYourIssue {
    return _localizedValues[locale.languageCode]!['addYourIssue'];
  }

  String? get addContactInfo {
    return _localizedValues[locale.languageCode]!['addContactInfo'];
  }

  String? get termsOfUse {
    return _localizedValues[locale.languageCode]!['termsOfUse'];
  }

  String? get howWeWork {
    return _localizedValues[locale.languageCode]!['howWeWork'];
  }

  String? get selectPreferredLanguage {
    return _localizedValues[locale.languageCode]!['selectPreferredLanguage'];
  }

  String? get registerNow {
    return _localizedValues[locale.languageCode]!['registerNow'];
  }

  String? get loginNow {
    return _localizedValues[locale.languageCode]!['loginNow'];
  }

  String? get register {
    return _localizedValues[locale.languageCode]!['register'];
  }

  String? get registerToContinue {
    return _localizedValues[locale.languageCode]!['registerToContinue'];
  }

  String? get enterName {
    return _localizedValues[locale.languageCode]!['enterName'];
  }

  String? get enterCode {
    return _localizedValues[locale.languageCode]!['enterCode'];
  }

  String? get setLocation {
    return _localizedValues[locale.languageCode]!['setLocation'];
  }

  String? get viewProfile {
    return _localizedValues[locale.languageCode]!['viewProfile'];
  }

  String? get savedAddresses {
    return _localizedValues[locale.languageCode]!['savedAddresses'];
  }

  String? get addNewLocation {
    return _localizedValues[locale.languageCode]!['addNewLocation'];
  }

  String? get selectAddressType {
    return _localizedValues[locale.languageCode]!['selectAddressType'];
  }

  String? get enterAddressDetails {
    return _localizedValues[locale.languageCode]!['enterAddressDetails'];
  }

  String? get selectPaymentMethod {
    return _localizedValues[locale.languageCode]!['selectPaymentMethod'];
  }

  String? get callUs {
    return _localizedValues[locale.languageCode]!['callUs'];
  }

  String? get mailUs {
    return _localizedValues[locale.languageCode]!['mailUs'];
  }

  String? get about {
    return _localizedValues[locale.languageCode]!['about'];
  }

  String? get address {
    return _localizedValues[locale.languageCode]!['address'];
  }

  String? get location {
    return _localizedValues[locale.languageCode]!['location'];
  }

  String? get days {
    return _localizedValues[locale.languageCode]!['days'];
  }

  String? get done {
    return _localizedValues[locale.languageCode]!['done'];
  }

  String? get time {
    return _localizedValues[locale.languageCode]!['time'];
  }

  String? get addNewAddress {
    return _localizedValues[locale.languageCode]!['addNewAddress'];
  }

  String? get to {
    return _localizedValues[locale.languageCode]!['to'];
  }

  String? get quickPayment {
    return _localizedValues[locale.languageCode]!['quickPayment'];
  }

  String? get contactUs {
    return _localizedValues[locale.languageCode]!['contactUs'];
  }

  String? get save {
    return _localizedValues[locale.languageCode]!['save'];
  }

  String? get myAddresses {
    return _localizedValues[locale.languageCode]!['myAddresses'];
  }

  String? get changeLanguage {
    return _localizedValues[locale.languageCode]!['changeLanguage'];
  }

  String? get selectLanguage {
    return _localizedValues[locale.languageCode]!['selectLanguage'];
  }

  String? get contactNumber {
    return _localizedValues[locale.languageCode]!['contactNumber'];
  }

  String? get writeYourNumber {
    return _localizedValues[locale.languageCode]!['writeYourNumber'];
  }

  String? get howToBookAParking {
    return _localizedValues[locale.languageCode]!['howToBookAParking'];
  }

  String? get howToAddMoneyInWallet {
    return _localizedValues[locale.languageCode]!['howToAddMoneyInWallet'];
  }

  String? get howToChangeLanguage {
    return _localizedValues[locale.languageCode]!['howToChangeLanguage'];
  }

  String? get howToLogoutMyAccount {
    return _localizedValues[locale.languageCode]!['howToLogoutMyAccount'];
  }

  String? get englishh {
    return _localizedValues[locale.languageCode]!['english'];
  }

  String? get arabicc {
    return _localizedValues[locale.languageCode]!['arabic'];
  }

  String? get frenchh {
    return _localizedValues[locale.languageCode]!['french'];
  }

  String? get portuguesee {
    return _localizedValues[locale.languageCode]!['portuguese'];
  }

  String? get sun {
    return _localizedValues[locale.languageCode]!['sun'];
  }

  String? get mon {
    return _localizedValues[locale.languageCode]!['mon'];
  }

  String? get tue {
    return _localizedValues[locale.languageCode]!['tue'];
  }

  String? get wed {
    return _localizedValues[locale.languageCode]!['wed'];
  }

  String? get thr {
    return _localizedValues[locale.languageCode]!['thr'];
  }

  String? get fri {
    return _localizedValues[locale.languageCode]!['fri'];
  }

  String? get sat {
    return _localizedValues[locale.languageCode]!['sat'];
  }

  String? get lorem {
    return _localizedValues[locale.languageCode]!['lorem'];
  }

  String? get indonesiann {
    return _localizedValues[locale.languageCode]!['indonesian'];
  }

  String? get italiann {
    return _localizedValues[locale.languageCode]!['italian'];
  }

  String? get spanishh {
    return _localizedValues[locale.languageCode]!['spanish'];
  }

  String? get swahilii {
    return _localizedValues[locale.languageCode]!['swahili'];
  }

  String? get turkishh {
    return _localizedValues[locale.languageCode]!['turkish'];
  }

  String? get skip {
    return _localizedValues[locale.languageCode]!['skip'];
  }

  String? get tagline {
    return _localizedValues[locale.languageCode]!['tagline'];
  }

  String? get usingTechnology {
    return _localizedValues[locale.languageCode]!['usingTechnology'];
  }

  String? get whatOurAppDo {
    return _localizedValues[locale.languageCode]!['whatOurAppDo'];
  }

  String? get BMItable {
    return _localizedValues[locale.languageCode]!['BMItable'];
  }

  String? get scrollable {
    return _localizedValues[locale.languageCode]!['scrollable'];
  }

  String? get medicineNameUpdated {
    return _localizedValues[locale.languageCode]!['medicineNameUpdated'];
  }

  String? get medicineUpdated {
    return _localizedValues[locale.languageCode]!['medicineUpdated'];
  }

  String? get pleaseFillAllFields {
    return _localizedValues[locale.languageCode]!['pleaseFillAllFields'];
  }

  String? get asSunnahApp {
    return _localizedValues[locale.languageCode]!['asSunnahApp'];
  }

  String? get enterCorrectOTP {
    return _localizedValues[locale.languageCode]!['asSunnahApp'];
  }

  String? get verifyPhoneNumber {
    return _localizedValues[locale.languageCode]!['verifyPhoneNumber'];
  }

  String? get verifyDescription {
    return _localizedValues[locale.languageCode]!['verifyDescription'];
  }

  String? get listeningOTP {
    return _localizedValues[locale.languageCode]!['listeningOTP'];
  }

  String? get or {
    return _localizedValues[locale.languageCode]!['or'];
  }

  String? get enterOTP {
    return _localizedValues[locale.languageCode]!['enterOTP'];
  }

  String? get sendingOTP {
    return _localizedValues[locale.languageCode]!['sendingOTP'];
  }
  String? get resetPasswordSent {
    return _localizedValues[locale.languageCode]!['resetPasswordSent'];
  }

  String? get inputCorrectEmail {
    return _localizedValues[locale.languageCode]!['inputCorrectEmail'];
  }

  String? get yourEmail {
    return _localizedValues[locale.languageCode]!['yourEmail'];
  }

  String? get resetPassword {
    return _localizedValues[locale.languageCode]!['resetPassword'];
  }

  String? get resetPasswordDesc {
    return _localizedValues[locale.languageCode]!['resetPasswordDesc'];
  }

  String? get verificationCode {
    return _localizedValues[locale.languageCode]!['verificationCode'];
  }

  String? get otpDescription {
    return _localizedValues[locale.languageCode]!['otpDescription'];
  }

  String? get resentOTP {
    return _localizedValues[locale.languageCode]!['resentOTP'];
  }

  String? get successVerified {
    return _localizedValues[locale.languageCode]!['successVerified'];
  }

  String? get authenticationFailed {
    return _localizedValues[locale.languageCode]!['authenticationFailed'];
  }

  String? get otpSuccessSend {
    return _localizedValues[locale.languageCode]!['otpSuccessSend'];
  }

  String? get yes {
    return _localizedValues[locale.languageCode]!['yes'];
  }

  String? get no {
    return _localizedValues[locale.languageCode]!['no'];
  }

  String? get confirmToLogout {
    return _localizedValues[locale.languageCode]!['confirmToLogout'];
  }

  String? get exitApp {
    return _localizedValues[locale.languageCode]!['exitApp'];
  }

  String? get confirmExitApp {
    return _localizedValues[locale.languageCode]!['confirmExitApp'];
  }

  String? get waterIntakeError {
    return _localizedValues[locale.languageCode]!['waterIntakeError'];
  }

  String? get habbatusMadu {
    return _localizedValues[locale.languageCode]!['habbatusMadu'];
  }

  String? get beforeWaterReminder {
    return _localizedValues[locale.languageCode]!['beforeWaterReminder'];
  }

  String? get HH {
    return _localizedValues[locale.languageCode]!['HH'];
  }

  String? get noData {
    return _localizedValues[locale.languageCode]!['noData'];
  }

  String? get navigationHome {
    return _localizedValues[locale.languageCode]!['navigationHome'];
  }

  String? get navigationReminder {
    return _localizedValues[locale.languageCode]!['navigationReminder'];
  }

  String? get navigationHistory {
    return _localizedValues[locale.languageCode]!['navigationHistory'];
  }

  String? get navigationSettings {
    return _localizedValues[locale.languageCode]!['navigationSettings'];
  }

  String? get snoozeReminder {
    return _localizedValues[locale.languageCode]!['snoozeReminder'];
  }

  String? get snoozeProduct {
    return _localizedValues[locale.languageCode]!['snoozeProduct'];
  }

  String? get snoozeTahajjud {
    return _localizedValues[locale.languageCode]!['snoozeTahajjud'];
  }

  String? get snoozeSadaqah {
    return _localizedValues[locale.languageCode]!['snoozeSadaqah'];
  }

  String? get snoozeWater {
    return _localizedValues[locale.languageCode]!['snoozeWater'];
  }

  String? get snoozeMedicine {
    return _localizedValues[locale.languageCode]!['snoozeMedicine'];
  }

  String? get snoozeMedicine2 {
    return _localizedValues[locale.languageCode]!['snoozeMedicine2'];
  }

  String? get takeWaterReminderToday {
    return _localizedValues[locale.languageCode]!['takeWaterReminderToday'];
  }

  String? get delete {
    return _localizedValues[locale.languageCode]!['delete'];
  }

  String? get skipToday {
    return _localizedValues[locale.languageCode]!['skipToday'];
  }

  String? get takeAfiyahLater {
    return _localizedValues[locale.languageCode]!['takeAfiyahLater'];
  }

  String? get takeAfiyahNow {
    return _localizedValues[locale.languageCode]!['takeAfiyahNow'];
  }

  String? get doYour {
    return _localizedValues[locale.languageCode]!['doYour'];
  }

  String? get takeYour {
    return _localizedValues[locale.languageCode]!['takeYour'];
  }

  String? get later {
    return _localizedValues[locale.languageCode]!['later'];
  }

  String? get takeMedicineLater {
    return _localizedValues[locale.languageCode]!['takeMedicineLater'];
  }

  String? get editTime {
    return _localizedValues[locale.languageCode]!['editTime'];
  }

  String? get skipNotification {
    return _localizedValues[locale.languageCode]!['skipNotification'];
  }

  String? get markAsDone {
    return _localizedValues[locale.languageCode]!['markAsDone'];
  }

  String? get snooze {
    return _localizedValues[locale.languageCode]!['snooze'];
  }

  String? get addToBookmark {
    return _localizedValues[locale.languageCode]!['addToBookmark'];
  }

  String? get tapToFav {
    return _localizedValues[locale.languageCode]!['tapToFav'];
  }

  String? get tooltipEdit {
    return _localizedValues[locale.languageCode]!['tooltipEdit'];
  }

  String? get selectTime {
    return _localizedValues[locale.languageCode]!['selectTime'];
  }

  String? get cancelTahajjudReminder {
    return _localizedValues[locale.languageCode]!['cancelTahajjudReminder'];
  }

  String? get cancelSadaqahReminder {
    return _localizedValues[locale.languageCode]!['cancelSadaqahReminder'];
  }

  String? get add {
    return _localizedValues[locale.languageCode]!['add'];
  }

  String? get done1 {
    return _localizedValues[locale.languageCode]!['done1'];
  }

  String? get back {
    return _localizedValues[locale.languageCode]!['back'];
  }

  String? get cancelWaterReminder {
    return _localizedValues[locale.languageCode]!['cancelWaterReminder'];
  }

  String? get cancelReminder1 {
    return _localizedValues[locale.languageCode]!['cancelReminder1'];
  }

  String? get cancelReminder2 {
    return _localizedValues[locale.languageCode]!['cancelReminder2'];
  }

  String? get update {
    return _localizedValues[locale.languageCode]!['update'];
  }

  String? get editMedicineTitle {
    return _localizedValues[locale.languageCode]!['editMedicineTitle'];
  }

  String? get editMedicineName {
    return _localizedValues[locale.languageCode]!['editMedicineName'];
  }

  String? get Acknowledgement_text {
    return _localizedValues[locale.languageCode]!['Acknowledgement_text'];
  }

  String? get Acknowledgement_text1 {
    return _localizedValues[locale.languageCode]!['Acknowledgement_text1'];
  }

  String? get Acknowledgement_text2 {
    return _localizedValues[locale.languageCode]!['Acknowledgement_text2'];
  }

  String? get Acknowledgement_text3 {
    return _localizedValues[locale.languageCode]!['Acknowledgement_text3'];
  }

  String? get Acknowledgement_text4 {
    return _localizedValues[locale.languageCode]!['Acknowledgement_text4'];
  }

  String? get Acknowledgement_text5 {
    return _localizedValues[locale.languageCode]!['Acknowledgement_text5'];
  }

  String? get Acknowledgement_text6 {
    return _localizedValues[locale.languageCode]!['Acknowledgement_text6'];
  }

  String? get timeReminder {
    return _localizedValues[locale.languageCode]!['timeReminder'];
  }

  String? get glassOfWater {
    return _localizedValues[locale.languageCode]!['glassOfWater'];
  }

  String? get medicineNo1 {
    return _localizedValues[locale.languageCode]!['medicineNo1'];
  }

  String? get medicineNo2 {
    return _localizedValues[locale.languageCode]!['medicineNo2'];
  }

  String? get QHrelated {
    return _localizedValues[locale.languageCode]!['QHrelated'];
  }

  String? get afiyah {
    return _localizedValues[locale.languageCode]!['afiyah'];
  }

  String? get tahajjudcategory {
    return _localizedValues[locale.languageCode]!['tahajjudcategory'];
  }

  String? get tahajjud1 {
    return _localizedValues[locale.languageCode]!['tahajjud1'];
  }

  String? get sadaqah {
    return _localizedValues[locale.languageCode]!['sadaqah'];
  }

  String? get sadaqah1 {
    return _localizedValues[locale.languageCode]!['sadaqah1'];
  }

  String? get water1 {
    return _localizedValues[locale.languageCode]!['water1'];
  }

  String? get water2 {
    return _localizedValues[locale.languageCode]!['water2'];
  }

  String? get categories {
    return _localizedValues[locale.languageCode]!['categories'];
  }

  String? get search {
    return _localizedValues[locale.languageCode]!['search'];
  }

  String? get bookmarks {
    return _localizedValues[locale.languageCode]!['bookmarks'];
  }

  String? get searchQH {
    return _localizedValues[locale.languageCode]!['searchQH'];
  }

  String? get ofTheDay {
    return _localizedValues[locale.languageCode]!['ofTheDay'];
  }

  String? get collectionQH {
    return _localizedValues[locale.languageCode]!['collectionQH'];
  }

  String? get showAllReminder {
    return _localizedValues[locale.languageCode]!['showAllReminder'];
  }

  String? get editMedicine {
    return _localizedValues[locale.languageCode]!['editMedicine'];
  }

  String? get medicine1 {
    return _localizedValues[locale.languageCode]!['medicine1'];
  }

  String? get reminder {
    return _localizedValues[locale.languageCode]!['reminder'];
  }

  String? get afiyahReminder {
    return _localizedValues[locale.languageCode]!['afiyahReminder'];
  }

  String? get tahajjudReminder {
    return _localizedValues[locale.languageCode]!['tahajjudReminder'];
  }

  String? get sadaqahReminder {
    return _localizedValues[locale.languageCode]!['sadaqahReminder'];
  }

  String? get waterReminder {
    return _localizedValues[locale.languageCode]!['waterReminder'];
  }

  String? get setNotificationTime {
    return _localizedValues[locale.languageCode]!['setNotificationTime'];
  }

  String? get markAll {
    return _localizedValues[locale.languageCode]!['markAll'];
  }

  String? get deleteAll {
    return _localizedValues[locale.languageCode]!['deleteAll'];
  }

  String? get companyHadith {
    return _localizedValues[locale.languageCode]!['companyHadith'];
  }

  String? get companyHadithNarrated {
    return _localizedValues[locale.languageCode]!['companyHadithNarrated'];
  }

  String? get proceed {
    return _localizedValues[locale.languageCode]!['proceed'];
  }

  String? get Acknowledgement_profile {
    return _localizedValues[locale.languageCode]!['Acknowledgement_profile'];
  }

  String? get required {
    return _localizedValues[locale.languageCode]!['required'];
  }

  String? get helpdesk {
    return _localizedValues[locale.languageCode]!['helpdesk'];
  }

  String? get sentEmail {
    return _localizedValues[locale.languageCode]!['sentEmail'];
  }

  String? get categoryBMItable {
    return _localizedValues[locale.languageCode]!['categoryBMItable'];
  }

  String? get emailHandling {
    return _localizedValues[locale.languageCode]!['emailHandling'];
  }

  String? get fullnameHandling {
    return _localizedValues[locale.languageCode]!['fullnameHandling'];
  }

  String? get passwordHandling {
    return _localizedValues[locale.languageCode]!['passwordHandling'];
  }

  String? get repasswordHandling {
    return _localizedValues[locale.languageCode]!['repasswordHandling'];
  }

  String? get WHO1 {
    return _localizedValues[locale.languageCode]!['WHO1'];
  }

  String? get WHO2 {
    return _localizedValues[locale.languageCode]!['WHO2'];
  }

  String? get normalWeight {
    return _localizedValues[locale.languageCode]!['normalWeight'];
  }

  String? get loadingScreen {
    return _localizedValues[locale.languageCode]!['loadingScreen'];
  }

  String? get loadingBack {
    return _localizedValues[locale.languageCode]!['loadingBack'];
  }

  String? get letgetstarted {
    return _localizedValues[locale.languageCode]!['letgetstarted'];
  }

  String? get letgetstartedmessage {
    return _localizedValues[locale.languageCode]!['letgetstartedmessage'];
  }

  String? get hadith {
    return _localizedValues[locale.languageCode]!['hadith'];
  }

  String? get hadithNarrated {
    return _localizedValues[locale.languageCode]!['hadithNarrated'];
  }

  String? get login {
    return _localizedValues[locale.languageCode]!['login'];
  }

  String? get pleaseInputFillAllFields {
    return _localizedValues[locale.languageCode]!['pleaseInputFillAllFields'];
  }

  String? get error {
    return _localizedValues[locale.languageCode]!['error'];
  }

  String? get errors {
    return _localizedValues[locale.languageCode]!['errors'];
  }

  String? get dontHaveAnAccount {
    return _localizedValues[locale.languageCode]!['dontHaveAnAccount'];
  }

  String? get haveAnAccount {
    return _localizedValues[locale.languageCode]!['haveAnAccount'];
  }

  String? get confirmEmailAddress {
    return _localizedValues[locale.languageCode]!['confirmEmailAddress'];
  }

  String? get pleaseVerify {
    return _localizedValues[locale.languageCode]!['pleaseVerify'];
  }

  String? get reSend {
    return _localizedValues[locale.languageCode]!['reSend'];
  }

  String? get dismiss {
    return _localizedValues[locale.languageCode]!['dismiss'];
  }

  String? get emailSent {
    return _localizedValues[locale.languageCode]!['emailSent'];
  }

  String? get updateYourInformation {
    return _localizedValues[locale.languageCode]!['updateYourInformation'];
  }

  String? get fillAllInformation {
    return _localizedValues[locale.languageCode]!['fillAllInformation'];
  }

  String? get dateOfBirth {
    return _localizedValues[locale.languageCode]!['dateOfBirth'];
  }

  String? get wellnessWatch {
    return _localizedValues[locale.languageCode]!['wellnessWatch'];
  }

  String? get wellnessMessage {
    return _localizedValues[locale.languageCode]!['wellnessMessage'];
  }

  String? get term1 {
    return _localizedValues[locale.languageCode]!['term1'];
  }

  String? get term2 {
    return _localizedValues[locale.languageCode]!['term2'];
  }

  String? get term3 {
    return _localizedValues[locale.languageCode]!['term3'];
  }

  String? get term4 {
    return _localizedValues[locale.languageCode]!['term4'];
  }

  String? get term5 {
    return _localizedValues[locale.languageCode]!['term5'];
  }

  String? get term6 {
    return _localizedValues[locale.languageCode]!['term6'];
  }

  String? get privacy1 {
    return _localizedValues[locale.languageCode]!['privacy1'];
  }

  String? get privacy2 {
    return _localizedValues[locale.languageCode]!['privacy2'];
  }

  String? get privacy3 {
    return _localizedValues[locale.languageCode]!['privacy3'];
  }

  String? get privacy4 {
    return _localizedValues[locale.languageCode]!['privacy4'];
  }

  String? get privacy5 {
    return _localizedValues[locale.languageCode]!['privacy5'];
  }

  String? get privacy6 {
    return _localizedValues[locale.languageCode]!['privacy6'];
  }

  String? get privacy7 {
    return _localizedValues[locale.languageCode]!['privacy7'];
  }

  String? get privacy8 {
    return _localizedValues[locale.languageCode]!['privacy8'];
  }

  String? get privacy9 {
    return _localizedValues[locale.languageCode]!['privacy9'];
  }

  String? get privacy10 {
    return _localizedValues[locale.languageCode]!['privacy10'];
  }

  String? get privacy11 {
    return _localizedValues[locale.languageCode]!['privacy11'];
  }

  String? get privacy12 {
    return _localizedValues[locale.languageCode]!['privacy12'];
  }

  String? get privacy13 {
    return _localizedValues[locale.languageCode]!['privacy13'];
  }

  String? get privacy14 {
    return _localizedValues[locale.languageCode]!['privacy14'];
  }

  String? get privacy15 {
    return _localizedValues[locale.languageCode]!['privacy15'];
  }

  String? get privacy16 {
    return _localizedValues[locale.languageCode]!['privacy16'];
  }

  String? get privacy17 {
    return _localizedValues[locale.languageCode]!['privacy17'];
  }

  String? get privacy18 {
    return _localizedValues[locale.languageCode]!['privacy18'];
  }

  String? get privacy19 {
    return _localizedValues[locale.languageCode]!['privacy19'];
  }

  String? get privacy20 {
    return _localizedValues[locale.languageCode]!['privacy20'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
        'ar',
        'id',
        'pt',
        'fr',
        'es',
        'tr',
        'it',
        'sw',
      ].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
