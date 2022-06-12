import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Locale/locales.dart';

class ShowByCatergory extends StatefulWidget {
  const ShowByCatergory(this.categoryList, this.title, {Key? key})
      : super(key: key);
  final List categoryList;
  final String title;

  @override
  _ShowByCatergoryState createState() => _ShowByCatergoryState();
}

class _ShowByCatergoryState extends State<ShowByCatergory> {
  List fav = [false, false, false];

  List<String> list = [];

  @override
  void initState() {
    // TODO: implement initState
    init();
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
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/app_coming_soon2.jpg'),
                  fit: BoxFit.fill),
            ),
          ),
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
          Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 18, right: 18),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                locale.quranHadith!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0, left: 8, right: 8),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: widget.categoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Row(
                        children: [
                          Flexible(
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.categoryList[index],
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                          DescribedFeatureOverlay(
                            featureId: 'add_item_feature_id',
                            // Unique id that identifies this overlay.
                            tapTarget: const Icon(Icons.star),
                            // The widget that will be displayed as the tap target.
                            title: Text(locale.addToBookmark!),
                            description: Text(
                                locale.tapToFav!),
                            backgroundColor: Theme.of(context).primaryColor,
                            targetColor: Colors.white,
                            textColor: Colors.white,
                            child: IconButton(
                              icon: !list
                                      .contains('${widget.categoryList[index]}')
                                  ? const Icon(
                                      Icons.star,
                                      color: Colors.grey,
                                    )
                                  : const Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                              onPressed: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                setState(() {
                                  if (list.contains(
                                          '${widget.categoryList[index]}') ==
                                      false) {
                                    list.add('${widget.categoryList[index]}');
                                  } else {
                                    setState(() {
                                      list.remove(
                                          '${widget.categoryList[index]}');
                                    });
                                  }
                                });
                                prefs.setStringList('bookMarks', list);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      list = prefs.getStringList('bookMarks') ?? [];
    });
  }
}
