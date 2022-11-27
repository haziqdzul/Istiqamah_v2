import 'package:flutter/material.dart';
import 'package:istiqamah_app/constants/constant.dart';

import '../Locale/locales.dart';
import '../screen/all.hadis.dart';

class ExpandedWidget extends StatefulWidget {
  final String text;
  final String title;

  const ExpandedWidget({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  State<ExpandedWidget> createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 300) {
      firstHalf = widget.text.substring(0, 300);
      secondHalf = widget.text.substring(301, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            secondHalf.length != null
                ? Text(widget.text)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.title,
                        style: textStyleBoldSmall,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        flag ? firstHalf : widget.text,
                        style: textStyleNormal,
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          print("Tapped");
                          setState(() {
                            flag = !flag;
                          });
                        },
                        child: Row(
                          children: [
                            Text(flag ? locale.readmore! : " ",
                                style: textStyleNormalGrey)
                            //Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),
            // : Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Text(
            //         widget.title,
            //         style: textStyleBoldSmall,
            //         textAlign: TextAlign.center,
            //       ),
            //       Text(
            //         widget.text,
            //         style: textStyleNormal,
            //         textAlign: TextAlign.justify,
            //       ),
            //     ],
            //   ),
            const SizedBox(height: 15),
            Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AllHadis()));
                      },
                      child: Row(
                        children: [
                          Text(locale.morecollection!,
                              style: textStyleNormalGrey),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
