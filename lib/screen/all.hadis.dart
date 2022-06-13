import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/foundation.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:istiqamah_app/components/home_top.component.dart';
import 'package:istiqamah_app/screen/view.hadis.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Locale/locales.dart';

class AllHadis extends StatefulWidget {
  const AllHadis({Key? key}) : super(key: key);

  @override
  _AllHadisState createState() => _AllHadisState();
}

class _AllHadisState extends State<AllHadis> {
  TextEditingController myController = TextEditingController();

  var visible = false;
  List product = [];
  List penyakit = [];
  List tahajjud = [];
  List sadaqah = [];
  List _list = [];
  List all = [];
  List water = [];
  List others = [];

  List<String> _bookmark = [];

  var feature1OverflowMode = OverflowMode.clipContent;
  var feature1EnablePulsingAnimation = false;

  var feature3ItemCount = 15;

  GlobalKey<EnsureVisibleState> ensureVisibleGlobalKey =
      GlobalKey<EnsureVisibleState>();

  // We create the tooltip on the first use

  // create a Future that returns List

  @override
  void initState() {
    getAllHadis();
    // FeatureDiscovery.clearPreferences(context, <String>{
    //   'add_item_feature_id',
    // });
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      FeatureDiscovery.discoverFeatures(
        context,
        const <String>{
          // Feature ids for every feature that you want to showcase in order.
          'add_item_feature_id',
        },
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<Category> choices = <Category>[
      Category(
        title: locale.HH!,
        icon: 'assets/afiyah.png',
        path: product.isEmpty
            ? () {}
            : () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowByCatergory(product, locale.afiyah!)));
              },
      ),
      Category(
        title: locale.tahajjudcategory!,
        icon: 'assets/tahajjud2.png',
        path: tahajjud.isEmpty
            ? () {}
            : () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowByCatergory(
                            tahajjud, locale.tahajjudcategory!)));
              },
      ),
      Category(
        title: locale.sadaqah1!,
        icon: 'assets/sedekah2.png',
        path: sadaqah.isEmpty
            ? () {}
            : () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowByCatergory(sadaqah, locale.sadaqah!)));
              },
      ),
      Category(
        title: locale.water2!,
        icon: 'assets/water2.png',
        path: water.isEmpty
            ? () {}
            : () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowByCatergory(water, locale.water1!)));
              },
      ),
      Category(
        title: locale.medicine1!,
        icon: 'assets/medicine.png',
        path: penyakit.isEmpty
            ? () {}
            : () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowByCatergory(penyakit, locale.medicine1!)));
              },
      ),
      Category(
        title: locale.other!,
        icon: 'assets/other.png',
        path: others.isEmpty
            ? () {}
            : () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowByCatergory(
                              others,
                              locale.other!,
                            )));
              },
      ),
    ];

    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: FutureBuilder(
              future: readBookmark(),
              builder: (context, AsyncSnapshot snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          mini: true,
                          backgroundColor: Colors.white,
                          child: const Icon(
                            Icons.arrow_back,
                            color: black,
                          ),
                        ).paddingOnly(right: 16, left: 16, top: 31, bottom: 8),
                      ],
                    ),
                    Container(
                      color: Colors.transparent,
                      width: 800,
                      child: TabBar(labelColor: Colors.black, tabs: [
                        Tab(
                          text: locale.categories!,
                          icon: const Icon(Icons.apps),
                        ),
                        Tab(
                          text: locale.search!,
                          icon: const Icon(Icons.search),
                        ),
                        Tab(
                          text: locale.bookmarks!,
                          icon: const Icon(Icons.bookmarks),
                        ),
                      ]),
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GridView.count(
                              childAspectRatio: 1.1,
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 2.0,
                              mainAxisSpacing: 2.0,
                              children: List.generate(choices.length, (index) {
                                return Center(
                                  child: SelectCard(
                                    choice: choices[index],
                                    product: product,
                                  ),
                                );
                              })),
                        ),
                        Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 16),
                                child: TextField(
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        myController.clear();
                                        visible = false;
                                        setState(() {
                                          _list = all;
                                        });
                                      },
                                    ),
                                    prefixIcon: const Icon(Icons.search),
                                    hintText: locale.searchQH!,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  controller: myController,
                                  onChanged: _search,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Visibility(
                                visible: visible,
                                child: ListView.builder(
                                  itemCount: _list.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final search = _list[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: ListTile(
                                                  title: Text(
                                                    search,
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                              ),
                                              DescribedFeatureOverlay(
                                                featureId:
                                                    'add_item_feature_id',
                                                // Unique id that identifies this overlay.
                                                tapTarget:
                                                    const Icon(Icons.star),
                                                // The widget that will be displayed as the tap target.
                                                title: const Text(
                                                    'Add to Bookmark'),
                                                description: const Text(
                                                    'Tap the star icon to add Quran/Hadith to your bookmark list.'),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                targetColor: Colors.white,
                                                textColor: Colors.white,
                                                child: IconButton(
                                                  icon: !_bookmark
                                                          .contains('$search')
                                                      ? const Icon(
                                                          Icons.star,
                                                          color: Colors.grey,
                                                        )
                                                      : const Icon(
                                                          Icons.star,
                                                          color: Colors.orange,
                                                        ),
                                                  onPressed: () async {
                                                    final SharedPreferences
                                                        prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    if (_bookmark.contains(
                                                            '$search') ==
                                                        false) {
                                                      _bookmark.add('$search');
                                                    } else {
                                                      setState(() {
                                                        _bookmark
                                                            .remove('$search');
                                                      });
                                                    }
                                                    prefs.setStringList(
                                                        'bookMarks', _bookmark);
                                                    if (p.kDebugMode) {
                                                      print(prefs.getStringList(
                                                          'bookMarks'));
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          itemCount: _bookmark.length,
                          itemBuilder: (BuildContext context, int index) {
                            final search = _bookmark[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: ListTile(
                                          title: Text(
                                            search,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.remove_circle,
                                          color: Colors.redAccent,
                                        ),
                                        onPressed: () async {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          setState(() {
                                            _bookmark.remove(search);
                                          });

                                          prefs.setStringList(
                                              'bookMarks', _bookmark);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ]),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Future<void> getAllHadis() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookmark = prefs.getStringList('bookMarks') ?? [];
    });
    if (AppLocalizations.of(context)!.water1 == 'air') {
      await FirebaseFirestore.instance
          .collection('habbatus_madu')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["terjemahanQuran"] == '') {
            setState(() {
              _list.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              product.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              product.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    } else {
      await FirebaseFirestore.instance
          .collection('habbatus_madu')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["translation_quran"] == '') {
            setState(() {
              _list.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              product.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              product.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    }
    if (AppLocalizations.of(context)!.water1 == 'air') {
      await FirebaseFirestore.instance
          .collection('penyakit')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["terjemahanQuran"] == '') {
            setState(() {
              _list.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              penyakit.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              penyakit.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    } else {
      await FirebaseFirestore.instance
          .collection('penyakit')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["translation_quran"] == '') {
            setState(() {
              _list.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              penyakit.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              penyakit.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    }
    if (AppLocalizations.of(context)!.water1 == 'air') {
      await FirebaseFirestore.instance
          .collection('tahajjud')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["terjemahanQuran"] == '') {
            setState(() {
              _list.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              tahajjud.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              tahajjud.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    } else {
      await FirebaseFirestore.instance
          .collection('tahajjud')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["translation_quran"] == '') {
            setState(() {
              _list.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              tahajjud.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              tahajjud.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    }
    if (AppLocalizations.of(context)!.water1 == 'air') {
      await FirebaseFirestore.instance
          .collection('air')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["terjemahanQuran"] == '') {
            setState(() {
              _list.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              water.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              water.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    } else {
      await FirebaseFirestore.instance
          .collection('air')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["translation_quran"] == '') {
            setState(() {
              _list.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              water.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              water.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    }
    if (AppLocalizations.of(context)!.water1 == 'air') {
      await FirebaseFirestore.instance
          .collection('sedekah')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["terjemahanQuran"] == '') {
            setState(() {
              _list.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              sadaqah.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              sadaqah.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
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
            setState(() {
              _list.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              sadaqah.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              sadaqah.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    }
    if (AppLocalizations.of(context)!.water1 == 'air') {
      await FirebaseFirestore.instance
          .collection('doa_zikir')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["terjemahanQuran"] == '') {
            setState(() {
              _list.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              others.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              others.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    } else {
      await FirebaseFirestore.instance
          .collection('doa_zikir')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["translation_quran"] == '') {
            setState(() {
              _list.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              others.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              others.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    }
    if (AppLocalizations.of(context)!.water1 == 'air') {
      await FirebaseFirestore.instance
          .collection('istiqamah')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["terjemahanQuran"] == '') {
            setState(() {
              _list.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              others.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              others.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    } else {
      await FirebaseFirestore.instance
          .collection('istiqamah')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["translation_quran"] == '') {
            setState(() {
              _list.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              others.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              others.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    }
    if (AppLocalizations.of(context)!.water1 == 'Air') {
      await FirebaseFirestore.instance
          .collection('makanan_halal')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["terjemahanQuran"] == '') {
            setState(() {
              _list.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              others.add(
                  '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              others.add(
                  '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    } else {
      await FirebaseFirestore.instance
          .collection('makanan_halal')
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc["translation_quran"] == '') {
            setState(() {
              _list.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
              others.add(
                  '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"].replaceAll('�', '\'')})');
            });
          } else {
            setState(() {
              _list.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              all.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
              others.add(
                  '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"].replaceAll('�', '\'')})');
            });
          }
        }
      });
    }
  }

  Future<void> _search(String query) async {
    if (query != '') {
      final suggestions = _list.where((book) {
        final bookTitle = book.toLowerCase();

        final input = query.toLowerCase();
        return bookTitle.contains(input);
      }).toList();
      setState(() {
        visible = true;
        if (suggestions.isNotEmpty) {
          _list = suggestions;
        }
      });
    } else {
      visible = false;
      setState(() {
        _list = all;
      });
    }
  }

  readBookmark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookmark = prefs.getStringList('bookMarks') ?? [];
    });
  }
}
