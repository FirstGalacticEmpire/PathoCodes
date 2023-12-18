import 'package:flutter/material.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen({
    super.key,
    required this.appContext,
    required this.title,
    required this.body,
    this.rightButtons,
    this.leftButton,
    this.isFullScreen = true,
    this.withoutAppBar = false,
    this.buttons,
    this.titleTextStyle,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    this.backgroundColor,
  });

  final BuildContext appContext;
  final String title;
  final List<Widget>? rightButtons;
  final bool? withoutAppBar;
  final bool? isFullScreen;
  final Widget? leftButton;
  final Widget body;
  final List<Widget>? buttons;
  final TextStyle? titleTextStyle;
  final Color? appBarBackgroundColor;
  final Color? appBarForegroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          backgroundColor ?? Theme.of(appContext).colorScheme.background,
      appBar: withoutAppBar!
          ? null
          : AppBar(
              title: Text(title,
                  style: titleTextStyle ??
                      TextStyle(
                          color:
                              Theme.of(appContext).colorScheme.onBackground)),
              centerTitle: true,
              backgroundColor: appBarBackgroundColor ??
                  Theme.of(appContext).colorScheme.background,
              foregroundColor: appBarForegroundColor ??
                  Theme.of(appContext).colorScheme.background,
              elevation: 0,
              actions: rightButtons,
              leading: leftButton,
            ),
      body: Center(
        child: isFullScreen!
            ? SafeArea(bottom: false, top: false, child: body)
            : SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: body,
                ),
              ),
      ),
      persistentFooterButtons: buttons,
    );
  }
}
