import 'package:flutter/material.dart';

class RapupAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool isProfileScreen;
  final Widget leading;
  final Widget center;
  final Widget trailing;
  final Color? backgroundColor;

  const RapupAppBar({
    Key? key,
    required this.height,
    required this.leading,
    required this.center,
    required this.trailing,
    this.isProfileScreen = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: height,
      color: backgroundColor ?? Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: leading,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: center,
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: trailing,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
