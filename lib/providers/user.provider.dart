import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppUser extends ChangeNotifier {
  // User? user;
  String? phoneNumber, verificationId;

  update() {
    notifyListeners();
  }

  AppUser._() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      notifyListeners();
    });
  }

  User? get user => FirebaseAuth.instance.currentUser;
  factory AppUser() => AppUser._();
  static AppUser get instance => AppUser();

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> signIn({required String email, required String password}) async {
    print('Email: $email');
    print('Password: $password');

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('Sign in Succesful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      } else {
        throw (e.toString());
      }
    }
  }

  //TODO: add name to kemas kini profil
  Future<void> updateName(String name) async {
    user!.updateDisplayName(name);
    notifyListeners();
  }

  Future<void> updatePassword(String password) async {
    user!.updatePassword(password);
    notifyListeners();
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      user!.updateDisplayName(name);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
