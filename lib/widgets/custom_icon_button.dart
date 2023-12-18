import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.appContext,
    required this.onPressed,
    this.icon,
    this.iconColor,
    this.width = 0.2,
    this.height = 0.06,
    this.backgroundColor,
  });
  final BuildContext appContext;
  final Function()? onPressed;
  final IconData? icon;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              backgroundColor ?? Theme.of(appContext).colorScheme.onBackground,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Center(
            child: Icon(icon,
                color:
                    iconColor ?? Theme.of(appContext).colorScheme.onBackground,
                size: 30)),
      ),
    );
  }
}
