import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Locale/locales.dart';
import '../Utils/shimmer.dart';
import '../components/notification.component.dart';
import '../models/MLNotificationData.dart';
import '../providers/data.provider.dart';
import '../providers/user.provider.dart';
import '../widgets/colors.dart';

class NotificationPage extends StatefulWidget {
  static String tag = '/NotificationPage';
  final int no;

  const NotificationPage(this.no, {Key? key}) : super(key: key);

  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  List<MLNotificationData> data = mlNotificationDataList();
  bool checked = false;
  Color customColor = Colors.yellow;
  bool valuefirst = false;
  bool valuesecond = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    countUnReadDocuments();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  int i = 0;
  bool empty = false;

  Future<dynamic> countUnReadDocuments() async {
    await Future.delayed(const Duration(seconds: 2));
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(AppUser.instance.user!.uid)
        .collection("notifications")
        .where("read", isEqualTo: false)
        .get();
    QuerySnapshot _allDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(AppUser.instance.user!.uid)
        .collection("notifications")
        .get();
    List<DocumentSnapshot> _allDocCount = _allDoc.docs;
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    int ii = _myDocCount.length; // Count of Documents in Collection

    setState(() {
      i = ii;
    });

    if (_allDocCount.isEmpty) {
      setState(() {
        empty = true;
      });
    }
    return ii;
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.yellow, Colors.red])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder(
              future: countUnReadDocuments(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Container(
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: radiusOnly(topRight: 32),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(locale.notification_history!,
                                      style: boldTextStyle(size: 20)),
                                ],
                              ).expand(),
                            ],
                          ).paddingAll(16.0),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            child: SingleChildScrollView(
                              child: Column(children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: boxDecorationRoundedWithShadow(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('', style: primaryTextStyle()),
                                          8.height,
                                          Row(
                                            children: [
                                              Text('',
                                                      style: boldTextStyle(
                                                          size: 14,
                                                          color: Colors.blue))
                                                  .expand(),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                decoration:
                                                    boxDecorationWithRoundedCorners(
                                                  borderRadius: radius(10),
                                                ),
                                                child: Text('',
                                                        style:
                                                            secondaryTextStyle(
                                                                color: white))
                                                    .paddingOnly(
                                                        left: 8.0, right: 8.0),
                                              )
                                            ],
                                          ),
                                        ],
                                      ).expand(),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: boxDecorationRoundedWithShadow(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('', style: primaryTextStyle()),
                                          8.height,
                                          Text('', style: secondaryTextStyle()),
                                          Row(
                                            children: [
                                              Text('',
                                                      style: boldTextStyle(
                                                          size: 14,
                                                          color: Colors.blue))
                                                  .expand(),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                decoration:
                                                    boxDecorationWithRoundedCorners(
                                                  borderRadius: radius(10),
                                                ),
                                                child: Text('',
                                                        style:
                                                            secondaryTextStyle(
                                                                color: white))
                                                    .paddingOnly(
                                                        left: 8.0, right: 8.0),
                                              )
                                            ],
                                          ),
                                        ],
                                      ).expand(),
                                    ],
                                  ),
                                ),
                              ]).paddingOnly(right: 16.0, left: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Container(
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: radiusOnly(topRight: 32),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(locale.notification_history!,
                                      style: boldTextStyle(size: 20)),
                                  8.width,
                                  checked == false && snapshot.data != 0
                                      ? Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration:
                                              boxDecorationWithRoundedCorners(
                                            backgroundColor: Colors.red,
                                            boxShape: BoxShape.circle,
                                          ),
                                          child: Text('${snapshot.data}',
                                              style: secondaryTextStyle(
                                                  color: white)),
                                        )
                                      : Container(),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.settings,
                                      color: Colors.blueAccent,
                                    ),
                                    onPressed: () {
                                      openBottomSheet();
                                    },
                                  )
                                ],
                              ).expand(),
                            ],
                          ).paddingAll(16.0),
                          empty
                              ? locale.water1 == 'air'
                                  ? const Text('Tiada sejarah pemberitahuan')
                                  : const Text('No reminder history')
                              : Container(),
                          const MLNotificationComponent().expand(),
                          8.height,
                        ],
                      ),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }

  CollectionReference users = FirebaseFirestore.instance
      .collection('users')
      .doc(AppUser.instance.user!.uid)
      .collection('notifications');

  void openBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        var locale = AppLocalizations.of(context)!;
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radiusOnly(topRight: 12, topLeft: 12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    batchUpdate();
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: context.width() / 2.5,
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    decoration: boxDecorationWithRoundedCorners(
                        border: Border.all(color: Colors.blue),
                        borderRadius: radius(12.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(locale.markAll!,
                            style: secondaryTextStyle(
                                color: Colors.blue, size: 14)),
                        4.width,
                        const Icon(Icons.check_box,
                            color: Colors.blue, size: 20)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    batchDelete();
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: context.width() / 2.5,
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: Colors.redAccent,
                      borderRadius: radius(12.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(locale.deleteAll!,
                            style: secondaryTextStyle(color: Colors.white)),
                        4.width,
                        const Icon(Icons.delete_outline,
                                color: Colors.white, size: 20)
                            .paddingBottom(4.0)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> batchDelete() {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    return users.get().then((querySnapshot) {
      for (var document in querySnapshot.docs) {
        batch.delete(document.reference);
      }

      return batch.commit();
    });
  }

  Future<void> batchUpdate() {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    return users.get().then((querySnapshot) {
      for (var document in querySnapshot.docs) {
        users.doc(document.id).set({'read': true}, SetOptions(merge: true));
      }
      return batch.commit();
    });
  }
}
