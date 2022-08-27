import 'package:devfest/utils/colors.dart';
import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EmptyAppBar({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? AppColors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
