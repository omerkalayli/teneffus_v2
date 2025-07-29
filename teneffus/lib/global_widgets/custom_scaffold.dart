import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    this.bottomNavigationBar,
    this.appBar,
    this.body,
    this.flotingActionButton,
    this.backgroundColor = const Color(0xffF5F5F5),
    super.key,
  });

  final Widget? body;
  final AppBar? appBar;
  final Widget? bottomNavigationBar;
  final Widget? flotingActionButton;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: backgroundColor,
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
