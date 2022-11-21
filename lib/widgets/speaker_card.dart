import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/router/navigator.dart';

class SessionCard extends HookConsumerWidget {
  final String backgroundImage, title, avatar, name, role, time, venue;
  final String? category, description;
  const SessionCard(
      {required this.backgroundImage,
      required this.title,
      required this.avatar,
      required this.name,
      required this.role,
      required this.time,
      required this.venue,
      this.category,
      this.description,
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
            synopsis: description ?? '',
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
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.greyWhite40),
                          shape: BoxShape.circle,
                          color: AppColors.greyWhite40,
                        ),
                        alignment: Alignment.center,
                        child: ClipOval(
                          child: Image.network(
                            avatar,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Image.asset(
                              'Sodiq'.png,
                              height: 40,
                              width: 40,
                            ),
                          ),
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
                  const Text(
                    "",
                    // '$time . $venue',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),

          //category
          if (title.isNotEmpty)
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

class SpeakerCard extends HookConsumerWidget {
  final String backgroundImage, title, avatar, name, role, time, venue;
  final String? category, description;
  const SpeakerCard(
      {required this.backgroundImage,
      required this.title,
      required this.avatar,
      required this.name,
      required this.role,
      required this.time,
      required this.venue,
      this.category,
      this.description,
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
            synopsis: description ?? '',
            venue: venue);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, top: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: ExactAssetImage(backgroundImage.png), fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyWhite40),
                  shape: BoxShape.circle,
                  color: AppColors.greyWhite40,
                ),
                alignment: Alignment.center,
                child: ClipOval(
                  child: Image.network(
                    avatar,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Image.asset(
                      'Sodiq'.png,
                      height: 64,
                      width: 64,
                    ),
                  ),
                ),
              ),
              const Gap(8),
              Text(
                name,
                style: const TextStyle(
                    fontSize: 24,
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
          ),
        ),
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
