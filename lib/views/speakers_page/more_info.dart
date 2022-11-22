import 'package:cached_network_image/cached_network_image.dart';
import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/views/controller_page/widgets/agenda_status_chip.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/router/navigator.dart';

class MoreInfoPage extends HookConsumerWidget {
  const MoreInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final speakers = ref.watch(speakersVM);

    //trim venue name
    String trimmedVenue = speakers.venue.replaceAll(' ', '').toLowerCase();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                width: double.infinity,
                height: 231,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage('banner'.png), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                  left: 15,
                  top: 49,
                  child: IconButton(
                    onPressed: () {
                      AppNavigator.maybePop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                    ),
                  ))
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(24),
                  if (speakers.title.isNotEmpty) ...[
                    Text(
                      speakers.title,
                      style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey0),
                    ),
                    const Gap(8),
                    const Text(
                      "",
                      // speakers.venue,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey12,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const Text(
                      "",
                      // speakers.time,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey12),
                    ),
                    const Gap(16),
                  ],
                  Row(
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: speakers.avatar,
                          width: 40,
                          height: 40,
                          errorWidget: (_, __, ___) => Image.asset(
                            'Sodiq'.png,
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                      const Gap(16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            speakers.name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.grey0),
                          ),
                          const Gap(4),
                          Text(
                            speakers.role,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grey8),
                          )
                        ],
                      )
                    ],
                  ),
                  const Gap(16),
                  if (speakers.title.isNotEmpty)
                    StatusChip(status: speakers.status),
                  const Gap(24),
                  Text(
                    speakers.synopsis,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey6),
                  ),
                  const Gap(32),
                  if (speakers.title.isNotEmpty) ...[
                    const Text(
                      'VENUE',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey0),
                    ),
                    const Gap(8),
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 161,
                            child: CachedNetworkImage(
                              imageUrl: trimmedVenue,
                              width: 40,
                              height: 40,
                              fit: BoxFit.fill,
                              errorWidget: (_, __, ___) => Image.asset(
                                'halla'.png,
                                width: 40,
                                height: 40,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        if (speakers.venue.isNotEmpty)
                          Positioned(
                            left: 8,
                            bottom: 16,
                            child: CustomChip(
                              color: AppColors.white,
                              text: speakers.venue,
                              textColor: AppColors.grey6,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                          ),
                      ],
                    )
                  ]
                ],
              ),
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip(
      {Key? key, this.text, this.padding, this.color, this.textColor})
      : super(key: key);

  final String? text;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: padding,
      child: Text(
        text ?? '',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
