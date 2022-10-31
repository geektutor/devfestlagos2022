import 'package:devfest/utils/colors.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DevFestPillWidget extends StatelessWidget {
  const DevFestPillWidget({
    super.key,
    required this.title,
    this.iconUrl,
  });

  final String title;
  final String? iconUrl;

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
              SvgPicture.network(
                iconUrl ?? '',
                height: 21,
                width: 21,
                placeholderBuilder: (_) => const Icon(
                  PhosphorIcons.globe,
                  size: 21,
                  color: AppColors.pillContent,
                ),
              ),
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
