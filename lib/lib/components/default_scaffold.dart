import 'package:flutter/material.dart';
//import 'package:istiqamah_app/constants/constant.dart';

class DefaultBody extends StatelessWidget {
  const DefaultBody({required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double appbarSize = AppBar().preferredSize.height;
    // double toolbar = kToolbarHeight;
    var statusbar = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        // automaticallyImplyLeading: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: statusbar),
        child: Stack(
          children: [
            SizedBox(
              height: height * .2 + (appbarSize),
              width: width,
              // color: kPrimaryColor,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  'assets/masjid.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(top: appbarSize), child: body))
          ],
        ),
      ),
    );
  }
}

// ShaderMask(
            //   shaderCallback: (bound) {
            //     return LinearGradient(
            //         end: FractionalOffset.topCenter,
            //         begin: FractionalOffset.bottomCenter,
            //         colors: [
            //           // Colors.white.withOpacity(0.99),
            //           // Colors.white.withOpacity(0.7),
            //           // Colors.transparent,
            //           Colors.white.withOpacity(0.99),
            //           Colors.white.withOpacity(0.7),
            //           Colors.transparent,
            //         ],
            //         stops: [
            //           0.0,
            //           0.1,
            //           0.2
            //         ]).createShader(bound);
            //   },
            //   blendMode: BlendMode.srcOver,
            //   child: Container(
            //     height: height * .2 + (appbarSize),
            //     width: width,
            //     // color: kPrimaryColor,
            //     child: Opacity(
            //       opacity: 0.5,
            //       child: Image.asset(
            //         'assets/newdelhi.png',
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // ),
