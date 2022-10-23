import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/global_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gap/gap.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({
    super.key,
    this.title = '',
    this.subtitle,
    this.locateUrl = '',
    this.bgImgUrl = 'google_banner',
    this.isSponsor = false,
  });
  final String title;
  final String? subtitle;
  final String locateUrl;
  final String bgImgUrl;
  final bool isSponsor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.greyWhite80,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                bgImgUrl.png,
                height: 90,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    height: 116,
                    width: 116,
                    decoration: BoxDecoration(
                      color: AppColors.blue1,
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 3, color: AppColors.greyWhite80),
                      image: DecorationImage(
                        image: AssetImage('Sodiq'.png),
                      ),
                    ),
                  ),
                  const Gap(13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.grey0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (subtitle != null) const Gap(5),
                          if (subtitle != null)
                            Text(
                              subtitle!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.grey12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                      Icon(
                        isSponsor
                            ? PhosphorIcons.globe
                            : PhosphorIcons.linkedin_logo,
                        size: isSponsor ? 24 : 32,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
