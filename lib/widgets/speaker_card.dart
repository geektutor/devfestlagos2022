import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/router/navigator.dart';

class SpeakerCard extends HookConsumerWidget {

  
  String synopsis = '';

  final String backgroundImage, title, avatar, name, role, time, venue;

  final String? category;
  SpeakerCard(
      {required this.backgroundImage,
      required this.title,
      required this.avatar,
      required this.name,
      required this.role,
      required this.time,
      required this.venue,
      this.category,
      key})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final speakers = ref.watch(speakersVM);

    return TouchableOpacity(
      onTap: () {
        AppNavigator.pushNamed(Routes.moreInfoPage);
        speakers.updateSpeaker(
            bgImage: backgroundImage,
            title: title,
            avatar: avatar,
            name: name,
            role: role,
            time: time,
            synopsis: '',
            venue: venue);

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0, top: 20),
            child: Container(
              height: 219,
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: ExactAssetImage(backgroundImage.png),
                    fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white),
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        avatar,
                        width: 40,
                        height: 40,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'Sodiq'.png,
                          height: 40,
                          width: 40,
                        ),
                      ),
                      const Gap(8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white),
                          ),
                          const Gap(4),
                          Text(
                            role,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Gap(27),
                  Text(
                    '$time . $venue',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),

          //category
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey16),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              category!,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.grey6),
            ),
          )
        ],
      ),
    );
  }
}

class Speaker {
  Speaker(
      {required this.firstName,
      required this.lastName,
      required this.avatar,
      required this.role,
      required this.time,
      required this.topic,
      required this.venue,
      required this.backgroundImage,
      this.category,
      this.synopsis});

  final String firstName,
      lastName,
      backgroundImage,
      role,
      time,
      venue,
      topic,
      avatar;
  String? category;
  String? synopsis;
}
