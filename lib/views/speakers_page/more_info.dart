import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MoreInfoPage extends HookConsumerWidget {
  const MoreInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final speakers = ref.watch(speakersVM);

    //trim venue name
    String trimmedVenue = speakers.venue.replaceAll(' ', '').toLowerCase();

    return Scaffold(
      body: Column(
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
                    context.canPop();
                  },
                  icon: Icon(
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
                Gap(24),
                Text(
                  speakers.title,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey0),
                ),
                Gap(8),
                Text(
                  'Venue Entrance',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey12,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  speakers.time,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey12),
                ),
                Gap(16),
                Row(
                  children: [
                    Image.asset(
                      speakers.avatar.png,
                      width: 40,
                      height: 40,
                    ),
                    Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${speakers.firstName} ${speakers.lastName}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey0),
                        ),
                        Gap(4),
                        Text(
                          speakers.role,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey8),
                        )
                      ],
                    )
                  ],
                ),
                Gap(16),
                Chip(
                  label: Text(
                    'PENDING',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.redPrimary),
                  ),
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  backgroundColor: AppColors.lightRed2,
                ),
                Gap(24),
                Text(
                  'In this talk, Aise instructs all adventurers looking into Web3 and tells them how to find opportunities best suited for them.',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey6),
                ),
                Gap(32),
                Text(
                  'VENUE',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey0),
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 161,
                        child: Image.asset(
                          trimmedVenue.png,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 8,
                      bottom: 16,
                      child: Chip(
                        label: Text(
                          speakers.venue,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.grey6,
                              letterSpacing: 1.1),
                        ),
                        labelPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        backgroundColor: AppColors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
