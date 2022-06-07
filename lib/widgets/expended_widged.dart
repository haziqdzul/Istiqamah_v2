import 'package:flutter/material.dart';
import 'package:istiqamah_app/constants/constant.dart';

import '../screen/all.hadis.dart';

class ExpendedWidget extends StatefulWidget {
  final String text;
  final String title;

  const ExpendedWidget({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  State<ExpendedWidget> createState() => _ExpendedWidgetState();
}

class _ExpendedWidgetState extends State<ExpendedWidget> {
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 250);
      secondHalf = widget.text.substring(251, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            secondHalf.length == ""
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.title,
                        style: textStyleBoldSmall,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.text,
                        style: textStyleNormal,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  )
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
                          children: const [
                            Text("more", style: textStyleNormalGrey)
                            //Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                        children: const [
                          Text('More Collection', style: textStyleNormalGrey),
                          Icon(
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
