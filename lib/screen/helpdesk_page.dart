import 'package:flutter/material.dart';
import 'package:istiqamah_app/components/alert_button.dart';
import 'package:istiqamah_app/constants/constant.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../components/corner_body.dart';

class HelpDeskPage extends StatefulWidget {
  static String tag = '/HelpDeskPage';
  const HelpDeskPage({Key? key}) : super(key: key);

  @override
  State<HelpDeskPage> createState() => _HelpDeskPageState();
}

class _HelpDeskPageState extends State<HelpDeskPage> {
  @override
  Widget build(BuildContext context) {
    return CornerBody(
      body: Column(
        children: [
          const Text(
            'Help Desk',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
              style: textStyleNormal, decoration: _textFieldDeco('Name')),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              style: textStyleNormal, decoration: _textFieldDeco('Email')),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              style: textStyleNormal, decoration: _textFieldDeco('Subject')),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              minLines: 5,
              maxLines: 10,
              style: textStyleNormal,
              decoration: _textFieldDeco('Message')),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            width: 100,
            child: DefaultButton(
              label: 'Submit',
              textStyle: textStyleBold,
              decoration: BoxDecoration(
                  color: kPrimaryColor, borderRadius: BorderRadius.circular(5)),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration _textFieldDeco(String label) {
    return InputDecoration(
      border: InputBorder.none,
      filled: true,
      label: Text(
        label,
        style: textStyleNormal,
      ),
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.only(left: 20.0, bottom: 6.0, top: 8.0),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: kPrimaryColor,
        ),
        // borderRadius: BorderRadius.circular(40.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
        // borderRadius: BorderRadius.circular(40.0),
      ),
    );
  }
}
