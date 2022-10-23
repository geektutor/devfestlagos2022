import 'package:devfest/utils/colors.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class DevFestPillWidget extends StatelessWidget {
  const DevFestPillWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          color: AppColors.pillBackground,
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const Gap(11.5),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.grey0,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
