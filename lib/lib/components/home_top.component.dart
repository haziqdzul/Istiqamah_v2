import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../Locale/locales.dart';
import '../Utils/shimmer.dart';
import '../providers/user.provider.dart';
import '../screen/all.hadis.dart';
import '../widgets/colors.dart';

class MLHomeTopComponent extends StatefulWidget {
  static String tag = '/MLHomeTopComponent';

  const MLHomeTopComponent({Key? key}) : super(key: key);

  @override
  _MLHomeTopComponentState createState() => _MLHomeTopComponentState();
}

class _MLHomeTopComponentState extends State<MLHomeTopComponent> {
  // List<MLServicesData> data = mlServiceDataList();
  final List _list = [];
  var numb = 0;
  final _stopLoad = AsyncMemoizer();
  List<String> _bookmark = [];

  @override
  void initState() {
    super.initState();
    getAllHadis();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    return Container(
        height: size.height * 0.8,
        width: context.width(),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: boxDecorationWithRoundedCorners(
          gradient: const LinearGradient(
              colors: [ManyColors.textColor2, ManyColors.textColor1]),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(MediaQuery.of(context).size.width, 80.0),
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          18.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.cyan,
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(AppUser
                                .instance.user!.photoURL ??
                            'https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg'),
                        radius: 22,
                        backgroundColor: Colors.cyan),
                  ),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppUser.instance.user!.displayName ?? '',
                          style: boldTextStyle(color: black)),
                      4.height,
                      Text(locale.welcome_home!,
                          style: secondaryTextStyle(
                              color: black.withOpacity(0.7))),
                    ],
                  ),
                ],
              ),
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
          const Spacer(),
          _list.length > 288
              ? Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  elevation: 8,
                  color: white,
                  child: ListTile(
                      minVerticalPadding: 16,
                      title: Text(
                        locale.ofTheDay!,
                        textAlign: TextAlign.center,
                        style: boldTextStyle(
                            size: 16,
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                      ),
                      subtitle: Text(
                        _list[DateTime.now().month * DateTime.now().day]
                            .trim()
                            .replaceAll('�', '')
                            .replaceAll('(?)', '')
                            .replaceAll('?\n', '')
                            .replaceAll('Rasulullah ?', 'Rasulullah'),
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.justify,
                      )),
                )
              : Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: const Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    elevation: 8,
                    color: white,
                    child: ListTile(
                        minVerticalPadding: 16, title: Text('loading..')),
                  ),
                ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllHadis()));
                },
                icon: const Icon(
                  Icons.menu_book_sharp,
                  color: Colors.blue,
                  size: 30,
                ),
                label: Text(locale.collectionQH!,
                    style: boldTextStyle(size: 16, color: Colors.black)),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('Collection of Qurans & Hadiths',
          //       style: GoogleFonts.alatsi()),
          // ),
          const Spacer(),
        ]));
  }

  Future getAllHadis() => _stopLoad.runOnce(() async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        setState(() {
          _bookmark = prefs.getStringList('bookMarks') ?? [];
        });
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('habbatus_madu')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('habbatus_madu')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('penyakit')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('penyakit')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('tahajjud')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('tahajjud')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('air')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('tahajjud')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('sedekah')
              .get()
              .then((QuerySnapshot querySnapshot) {
            for (var doc in querySnapshot.docs) {
              if (doc["terjemahanQuran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            }
          });
        } else {
          await FirebaseFirestore.instance
              .collection('sedekah')
              .get()
              .then((QuerySnapshot querySnapshot) {
            for (var doc in querySnapshot.docs) {
              if (doc["translation_quran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            }
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('doa_zikir')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('doa_zikir')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('istiqamah')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('istiqamah')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('makanan_halal')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('makanan_halal')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        }
        print(_list.length);
      });
}

class Category {
  const Category({required this.title, required this.icon, required this.path});

  final VoidCallback path;
  final String title;
  final String icon;
}

class SelectCard extends StatelessWidget {
  final Category choice;
  final List product;

  const SelectCard({required this.choice, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: choice.path,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 180,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    0.1,
                    0.7
                  ],
                  colors: [
                    ManyColors.textColor2,
                    ManyColors.textColor1,
                  ])),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: ImageIcon(
                      AssetImage(choice.icon),
                      size: 130,
                      color: Colors.white,
                    )),
                Flexible(
                    flex: 2,
                    child: Text(
                      choice.title,
                      textAlign: TextAlign.center,
                      style: boldTextStyle(color: Colors.white, size: 17),
                      maxLines: 2,
                    )),
              ]),
        ),
      ),
    );
  }
}
