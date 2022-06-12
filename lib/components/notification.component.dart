import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Locale/locales.dart';
import '../Utils/shimmer.dart';
import '../providers/user.provider.dart';

class MLNotificationComponent extends StatefulWidget {
  static String tag = '/MLNotificationComponent';

  const MLNotificationComponent({Key? key}) : super(key: key);

  @override
  MLNotificationComponentState createState() => MLNotificationComponentState();
}

class MLNotificationComponentState extends State<MLNotificationComponent> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc(AppUser.instance.user!.uid)
      .collection('notifications')
      .orderBy("created-at", descending: true)
      .snapshots();

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);
    var locale = AppLocalizations.of(context)!;
    if (diff.inDays >= 1) {
      return '${diff.inDays} ${locale.dayAgo}';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} ${locale.hourAgo}';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} ${locale.minuteAgo}';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} ${locale.secondAgo}';
    } else {
      return '${locale.justNow}';
    }
  }

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
    var status = 'Completed';
    return StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: boxDecorationRoundedWithShadow(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('', style: primaryTextStyle()),
                            8.height,
                            (status != '')
                                ? Text('', style: secondaryTextStyle())
                                : 0.height,
                            (status != '') ? 8.height : 0.height,
                            Row(
                              children: [
                                Text('',
                                        style: boldTextStyle(
                                            size: 14, color: Colors.blue))
                                    .expand(),
                                (status != '')
                                    ? Container(
                                        padding: const EdgeInsets.all(2.0),
                                        decoration:
                                            boxDecorationWithRoundedCorners(
                                          backgroundColor:
                                              (status == 'Canceled')
                                                  ? Colors.red
                                                  : Colors.green,
                                          borderRadius: radius(10),
                                        ),
                                        child: Text('',
                                                style: secondaryTextStyle(
                                                    color: white))
                                            .paddingOnly(left: 8.0, right: 8.0),
                                      )
                                    : const SizedBox(width: 0, height: 0),
                              ],
                            ),
                          ],
                        ).expand(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: boxDecorationRoundedWithShadow(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('', style: primaryTextStyle()),
                            8.height,
                            (status != '')
                                ? Text('', style: secondaryTextStyle())
                                : 0.height,
                            (status != '') ? 8.height : 0.height,
                            Row(
                              children: [
                                Text('',
                                        style: boldTextStyle(
                                            size: 14, color: Colors.blue))
                                    .expand(),
                                (status != '')
                                    ? Container(
                                        padding: const EdgeInsets.all(2.0),
                                        decoration:
                                            boxDecorationWithRoundedCorners(
                                          backgroundColor:
                                              (status == 'Canceled')
                                                  ? Colors.red
                                                  : Colors.green,
                                          borderRadius: radius(10),
                                        ),
                                        child: Text('',
                                                style: secondaryTextStyle(
                                                    color: white))
                                            .paddingOnly(left: 8.0, right: 8.0),
                                      )
                                    : const SizedBox(width: 0, height: 0),
                              ],
                            ),
                          ],
                        ).expand(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: boxDecorationRoundedWithShadow(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('', style: primaryTextStyle()),
                            8.height,
                            (status != '')
                                ? Text('', style: secondaryTextStyle())
                                : 0.height,
                            (status != '') ? 8.height : 0.height,
                            Row(
                              children: [
                                Text('',
                                        style: boldTextStyle(
                                            size: 14, color: Colors.blue))
                                    .expand(),
                                (status != '')
                                    ? Container(
                                        padding: const EdgeInsets.all(2.0),
                                        decoration:
                                            boxDecorationWithRoundedCorners(
                                          backgroundColor:
                                              (status == 'Canceled')
                                                  ? Colors.red
                                                  : Colors.green,
                                          borderRadius: radius(10),
                                        ),
                                        child: Text('',
                                                style: secondaryTextStyle(
                                                    color: white))
                                            .paddingOnly(left: 8.0, right: 8.0),
                                      )
                                    : const SizedBox(width: 0, height: 0),
                              ],
                            ),
                          ],
                        ).expand(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: boxDecorationRoundedWithShadow(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('', style: primaryTextStyle()),
                            8.height,
                            (status != '')
                                ? Text('', style: secondaryTextStyle())
                                : 0.height,
                            (status != '') ? 8.height : 0.height,
                            Row(
                              children: [
                                Text('',
                                        style: boldTextStyle(
                                            size: 14, color: Colors.blue))
                                    .expand(),
                                (status != '')
                                    ? Container(
                                        padding: const EdgeInsets.all(2.0),
                                        decoration:
                                            boxDecorationWithRoundedCorners(
                                          backgroundColor:
                                              (status == 'Canceled')
                                                  ? Colors.red
                                                  : Colors.green,
                                          borderRadius: radius(10),
                                        ),
                                        child: Text('',
                                                style: secondaryTextStyle(
                                                    color: white))
                                            .paddingOnly(left: 8.0, right: 8.0),
                                      )
                                    : const SizedBox(width: 0, height: 0),
                              ],
                            ),
                          ],
                        ).expand(),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: boxDecorationRoundedWithShadow(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('', style: primaryTextStyle()),
                            8.height,
                            (status != '')
                                ? Text('', style: secondaryTextStyle())
                                : 0.height,
                            (status != '') ? 8.height : 0.height,
                            Row(
                              children: [
                                Text('',
                                        style: boldTextStyle(
                                            size: 14, color: Colors.blue))
                                    .expand(),
                                (status != '')
                                    ? Container(
                                        padding: const EdgeInsets.all(2.0),
                                        decoration:
                                            boxDecorationWithRoundedCorners(
                                          backgroundColor:
                                              (status == 'Canceled')
                                                  ? Colors.red
                                                  : Colors.green,
                                          borderRadius: radius(10),
                                        ),
                                        child: Text('',
                                                style: secondaryTextStyle(
                                                    color: white))
                                            .paddingOnly(left: 8.0, right: 8.0),
                                      )
                                    : const SizedBox(width: 0, height: 0),
                              ],
                            ),
                          ],
                        ).expand(),
                      ],
                    ),
                  )
                ]).paddingOnly(right: 16.0, left: 16.0),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No history available',
                style: TextStyle(color: black),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                final Timestamp timestamp = data['created-at'] as Timestamp;
                final DateTime dateTime = timestamp.toDate();
                final dateString = convertToAgo(dateTime);
                var a = data['uid'];
                return Container(
                  margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: boxDecorationRoundedWithShadow(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(data['text'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: primaryTextStyle()),
                              (data['read'] == false)
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 5,
                                        backgroundColor: Colors.red,
                                        // child: Text(locale.unread!,
                                        //         textAlign: TextAlign.center,
                                        //         maxLines: 2,
                                        //         style: secondaryTextStyle(
                                        //             color: mlColorRed))
                                        //     .paddingOnly(left: 8.0, right: 8.0),
                                      ),
                                    )
                                  : 0.height,
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    openBottomSheet(a);
                                  },
                                  icon: const Icon(Icons.more_vert))
                            ],
                          ),
                          Text(data['hadis'] ?? 'No Content',
                              style: secondaryTextStyle()),
                          8.height,
                          Row(
                            children: [
                              Text(dateString,
                                      style: boldTextStyle(
                                          size: 14, color: Colors.blue))
                                  .expand(),

                              const SizedBox(width: 8),
                              // (status != '')
                              //     ? Container(
                              //         padding: const EdgeInsets.all(2.0),
                              //         decoration:
                              //             boxDecorationWithRoundedCorners(
                              //           backgroundColor:
                              //               (data['label'] != 'product')
                              //                   ? checkColor(data['label'])
                              //                   : Colors.green,
                              //           borderRadius: radius(10),
                              //         ),
                              //         child: Text(data['label'],
                              //                 style: secondaryTextStyle(
                              //                     color: white))
                              //             .paddingOnly(left: 8.0, right: 8.0),
                              //       )
                              //     : const SizedBox(width: 0, height: 0),
                            ],
                          ),
                        ],
                      ).expand(),
                    ],
                  ),
                );
              }).toList(),
            ).paddingOnly(right: 16.0, left: 16.0),
          );
        });
  }

  void openBottomSheet(int id) {
    var locale = AppLocalizations.of(context)!;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
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
                    read(id);
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
                        Text(locale.markAsDone!,
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
                    delete(id);
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
                        Text(locale.delete!,
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

  CollectionReference users = FirebaseFirestore.instance
      .collection('users')
      .doc(AppUser.instance.user!.uid)
      .collection("notifications");

  Future<void> read(int id) {
    return users
        .doc('$id')
        .update({'read': true})
        .then((value) => print("Notification mark as readed"))
        .catchError((error) => print("Failed to update notification: $error"));
  }

  Future<void> delete(int id) async {
    return users.doc('$id').delete();
  }

// Color checkColor(String label) {
//   if (label == 'sadaqah') {
//     return Colors.pink;
//   } else if (label == 'tahajjud') {
//     return Colors.orange;
//   } else if (label == 'water') {
//     return Colors.blue;
//   } else if (label == 'medicine') {
//     return Colors.deepPurple;
//   } else {
//     return Colors.green;
//   }
// }
}
