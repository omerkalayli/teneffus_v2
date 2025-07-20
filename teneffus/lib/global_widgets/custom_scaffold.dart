import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    this.bottomNavigationBar,
    this.appBar,
    this.body,
    this.flotingActionButton,
    super.key,
  });

  final Widget? body;
  final AppBar? appBar;
  final Widget? bottomNavigationBar;
  final Widget? flotingActionButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Color(0xff4DD0E1),
            // Color(0xff69AAFF),
            Color(0xffF5F5F5),
            Color(0xffF5F5F5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        resizeToAvoidBottomInset: false,
        floatingActionButton: flotingActionButton,
        appBar: appBar,
        bottomNavigationBar: bottomNavigationBar,
        backgroundColor: Colors.transparent,
        body: body,
      ),
    );
  }
}
