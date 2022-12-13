import 'package:flutter/material.dart';
import 'package:istiqamah_app/constants/constant.dart';
import 'package:istiqamah_app/fancy_btm_navi/paint/half_clipper.dart';
import 'package:istiqamah_app/fancy_btm_navi/paint/half_painter.dart';

import 'internal/tab_item.dart';

const double circle_size = 60;
const double arc_height = 70;
const double arc_width = 90;
const double circle_outline = 10;
const double shadow_allowance = 20;
const double bar_height = 60;

class FancyBottomNavigation extends StatefulWidget {
  FancyBottomNavigation(
      {required this.tabs,
      required this.onTabChangedListener,
      this.key,
      this.onTap,
      this.currentIndex = 0,
      this.initialSelection = 1,
      this.circleColor,
      this.activeIconColor,
      this.inactiveIconColor,
      this.textColor,
      this.barBackgroundColor})
      : assert(tabs.length > 1 && tabs.length < 5);

  final ValueChanged<int>? onTap;
  final int currentIndex;
  final Function(int position) onTabChangedListener;
  final Color? circleColor;
  final Color? activeIconColor;
  final Color? inactiveIconColor;
  final Color? textColor;
  final Color? barBackgroundColor;
  final List<TabData> tabs;
  final int initialSelection;

  final Key? key;

  @override
  FancyBottomNavigationState createState() => FancyBottomNavigationState();
}

class FancyBottomNavigationState extends State<FancyBottomNavigation>
    with TickerProviderStateMixin, RouteAware {
  IconData nextIcon = Icons.search;
  IconData activeIcon = Icons.search;

  int currentSelected = 0;
  double _circleAlignX = 0;
  double _circleIconAlpha = 1;

  late Color circleColor;
  late Color activeIconColor;
  late Color inactiveIconColor;
  late Color barBackgroundColor;
  late Color textColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    activeIcon = widget.tabs[currentSelected].iconData;

    circleColor = widget.circleColor ??
        ((Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : kPrimaryColor);

    activeIconColor = widget.activeIconColor ??
        ((Theme.of(context).brightness == Brightness.dark)
            ? Colors.black54
            : Colors.white);

    barBackgroundColor = Colors.black38;
    // barBackgroundColor = widget.barBackgroundColor ??
    //     ((Theme.of(context).brightness == Brightness.dark)
    //         ? Color(0xFF212121)
    //         : Colors.white);
    textColor = Colors.white;
    // textColor = widget.textColor ??
    //     ((Theme.of(context).brightness == Brightness.dark)
    //         ? Colors.white
    //         : Colors.black54);
    inactiveIconColor = Colors.white;
    // inactiveIconColor = (widget.inactiveIconColor) ??
    //     ((Theme.of(context).brightness == Brightness.dark)
    //         ? Colors.white
    //         : Theme.of(context).primaryColor);
  }

  @override
  void initState() {
    super.initState();
    _setSelected(widget.tabs[widget.initialSelection].key);
  }

  _setSelected(UniqueKey key) {
    int selected = widget.tabs.indexWhere((tabData) => tabData.key == key);

    if (mounted) {
      setState(() {
        currentSelected = selected;
        _circleAlignX = -1 + (2 / (widget.tabs.length - 1) * selected);
        nextIcon = widget.tabs[selected].iconData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: bar_height,
          decoration:
              BoxDecoration(color: barBackgroundColor, boxShadow: const [
            BoxShadow(
              // color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)
              color: Colors.black12, offset: Offset(0, -1),
            )
          ]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.tabs
                .map((t) => TabItem(
                    uniqueKey: t.key,
                    selected: t.key == widget.tabs[currentSelected].key,
                    iconData: t.iconData,
                    title: t.title,
                    iconColor: inactiveIconColor,
                    textColor: textColor,
                    callbackFunction: (uniqueKey) {
                      int selected = widget.tabs
                          .indexWhere((tabData) => tabData.key == uniqueKey);
                      widget.onTabChangedListener(selected);
                      _setSelected(uniqueKey);
                      _initAnimationAndStart(_circleAlignX, 1);
                    }))
                .toList(),
          ),
        ),
        Positioned.fill(
          top: -(circle_size + circle_outline + shadow_allowance) / 2,
          child: AnimatedAlign(
            duration: const Duration(milliseconds: ANIM_DURATION),
            curve: Curves.easeOut,
            alignment: Alignment(_circleAlignX, 1),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: FractionallySizedBox(
                widthFactor: 1 / widget.tabs.length,
                child: GestureDetector(
                  onTap:
                      widget.tabs[currentSelected].onclick as void Function()?,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: circle_size + circle_outline + shadow_allowance,
                        width: circle_size + circle_outline + shadow_allowance,
                        child: ClipRect(
                            clipper: HalfClipper(),
                            child: Center(
                              child: Container(
                                  width: circle_size + circle_outline,
                                  height: circle_size + circle_outline,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 8)
                                      ])),
                            )),
                      ),
                      SizedBox(
                          height: arc_height,
                          width: arc_width,
                          child: CustomPaint(
                            painter: HalfPainter(barBackgroundColor),
                          )),
                      SizedBox(
                        height: circle_size,
                        width: circle_size,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: circleColor),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: AnimatedOpacity(
                              duration: const Duration(
                                  milliseconds: ANIM_DURATION ~/ 5),
                              opacity: _circleIconAlpha,
                              child: Icon(
                                activeIcon,
                                color: activeIconColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _initAnimationAndStart(double from, double to) {
    _circleIconAlpha = 0;

    Future.delayed(const Duration(milliseconds: ANIM_DURATION ~/ 5), () {
      setState(() {
        activeIcon = nextIcon;
      });
    }).then((_) {
      Future.delayed(const Duration(milliseconds: (ANIM_DURATION ~/ 5 * 3)),
          () {
        setState(() {
          _circleIconAlpha = 1;
        });
      });
    });
  }

  void setPage(int page) {
    widget.onTabChangedListener(page);
    _setSelected(widget.tabs[page].key);
    _initAnimationAndStart(_circleAlignX, 1);

    setState(() {
      currentSelected = page;
    });
  }
}

class TabData {
  TabData({required this.iconData, required this.title, this.onclick});

  IconData iconData;
  String title;
  Function? onclick;
  final UniqueKey key = UniqueKey();
}
