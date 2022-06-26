import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:digitization/const/const.dart';
import 'package:digitization/widgets/blogs.dart';
import 'package:digitization/widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../widgets/carousel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future onrefresh() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(
        () {
          blogs(context);
          carousel(context);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressed;
    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        backgroundColor: primaryColor,
        title: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            ColorizeAnimatedText(
              'Digital शिक्षा',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 10),
        //     child: IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context, MaterialPageRoute(builder: (context) => Notice()));
        //       },
        //       icon: const Icon(
        //         Icons.blur_circular_sharp,
        //         size: 40,
        //       ),
        //     ),
        //   )
        // ],
      ),
      drawer: myDrawer(context),
      body: RefreshIndicator(
        onRefresh: onrefresh,
        child: WillPopScope(
          onWillPop: () async {
            final now = DateTime.now();
            // ignore: prefer_const_declarations
            final maxDuration = const Duration(seconds: 2);
            final isWarning = lastPressed == null ||
                now.difference(lastPressed!) > maxDuration;
            if (isWarning) {
              lastPressed = DateTime.now();

              final snackBar = SnackBar(
                content: const Text('Double Tap To Close App'),
                duration: maxDuration,
              );

              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(snackBar);
              return false;
            } else {
              return true;
            }
          },
          // Code end Here of DOuble tap
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Slider Component
                carousel(context),
                blogs(context),
                // Course Type Components
              ],
            ),
          ),
        ),
      ),
    );
  }
}
