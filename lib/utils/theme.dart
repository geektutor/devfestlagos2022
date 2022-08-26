import 'package:flutter/material.dart';

TextStyle segmentedControlStyle(bool val) => TextStyle(
     // color: val ? kGreyPrimary : kGreyTertiary,
      fontSize: 15,
      fontWeight: val ? FontWeight.w500 : FontWeight.w400,
    );
