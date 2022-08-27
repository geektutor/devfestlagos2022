import 'package:flutter/material.dart';

class ControllerPageItem {
  const ControllerPageItem({
    required this.page,
    required this.image,
    required this.name,
  });

  final Widget page;
  final String image, name;
}
