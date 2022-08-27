import 'package:devfest/utils/colors.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:devfest/utils/extensions/extensions.dart';
import 'package:gap/gap.dart';

class DevFestPillWidget extends StatelessWidget {
  const DevFestPillWidget({
    super.key,
    required this.title,
    required this.image,
  });

  final String title, image;

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
              SvgPicture.asset(image.svg),
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
