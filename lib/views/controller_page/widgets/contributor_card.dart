import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/global_extensions.dart';
import 'package:devfest/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/model/contributor_response.dart';
import 'info_card_widget.dart';

class ContributorCard extends StatelessWidget {
  const ContributorCard({
    super.key,
    this.contributor,
  });
  final Contributor? contributor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Image.asset(
                (contributor?.category?.toLowerCase() ?? "google_banner").png,
                height: 90,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    height: 116,
                    width: 116,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 3, color: AppColors.greyWhite80),
                    ),
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: contributor?.image != null
                          ? AvatarImage(url: contributor!.image!)
                          : Image.asset('Sodiq'.png),
                    ),
                  ),
                  const Gap(13),
                  Text(
                    contributor?.name ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.grey0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    contributor?.tagline ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: contributor?.portfolio?.isNotEmpty ?? false,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () => launchUrl(
                                  Uri.parse(parseUrl(contributor!.portfolio!)),
                                  mode: LaunchMode.externalApplication),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.greyWhite80,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      PhosphorIcons.globe_bold,
                                      size: 18,
                                    ),
                                    Gap(11),
                                    Text(
                                      'Portfolio',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.grey0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: contributor?.linkedIn?.isNotEmpty ?? false,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () => launchUrl(
                                  Uri.parse(parseUrl(contributor!.linkedIn!)),
                                  mode: LaunchMode.externalApplication),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.greyWhite80,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      PhosphorIcons.linkedin_logo_bold,
                                      size: 18,
                                    ),
                                    Gap(11),
                                    Text(
                                      'LinkedIn',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.grey0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: contributor?.email?.isNotEmpty ?? false,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () => launchUrl(
                                  Uri.parse(parseUrl(contributor!.email!,
                                      isMail: true)),
                                  mode: LaunchMode.externalApplication),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.greyWhite80,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      PhosphorIcons.envelope_bold,
                                      size: 18,
                                    ),
                                    Gap(11),
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.grey0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
