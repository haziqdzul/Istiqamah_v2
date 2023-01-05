import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReAuthScreen extends StatefulWidget {
  const ReAuthScreen({Key? key}) : super(key: key);

  @override
  State<ReAuthScreen> createState() => _ReAuthScreenState();
}

class _ReAuthScreenState extends State<ReAuthScreen> {
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Deleting account..')),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Please enter password to continue delete account'),
              TextFormField(
                  obscureText: true,
                  onChanged: (value) => setState(() {
                        password = value;
                      })),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      var data = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: FirebaseAuth.instance.currentUser!.email!,
                              password: password);
                      if (!mounted) return;
                      Navigator.pop(context, data);
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: const Text('Confirm'))
            ],
          ),
        ));
  }
}
