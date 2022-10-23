import 'package:card_swiper/card_swiper.dart';
import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/views/controller_page/widgets/agenda_status_chip.dart';
import 'package:devfest/widgets/app_bar.dart';
import 'package:devfest/widgets/pill_widget.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../widgets/speaker_card.dart';
import '../../../speakers_page/speakers_page.dart';
import '../../widgets/agenda_card.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const EmptyAppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            const Gap(10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Hi there, Samuel 🤗',
                style: TextStyle(
                  color: AppColors.grey0,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Gap(20),
            const HomeSlider(),
            const Gap(29),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Talk Categories',
                        style: TextStyle(
                          color: AppColors.grey0,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      TouchableOpacity(
                        onTap: () =>
                            ref.read(controllerVM).goToTalkCategories(),
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      DevFestPillWidget(
                        icon: Icon(
                          PhosphorIcons.robot,
                          size: 21,
                          color: AppColors.pillContent,
                        ),
                        title: 'Machine Learning',
                      ),
                      DevFestPillWidget(
                        icon: Icon(
                          PhosphorIcons.globe,
                          size: 21,
                          color: AppColors.pillContent,
                        ),
                        title: 'Web',
                      ),
                      DevFestPillWidget(
                        icon: Icon(
                          PhosphorIcons.paint_brush,
                          size: 21,
                          color: AppColors.pillContent,
                        ),
                        title: 'Design',
                      ),
                      DevFestPillWidget(
                        icon: Icon(
                          PhosphorIcons.android_logo,
                          size: 21,
                          color: AppColors.pillContent,
                        ),
                        title: 'Android',
                      ),
                      DevFestPillWidget(
                        icon: Icon(
                          PhosphorIcons.device_mobile,
                          size: 21,
                          color: AppColors.pillContent,
                        ),
                        title: 'Mobile',
                      ),
                    ],
                  ),
                  const Gap(32),
                  Row(
                    children: [
                      const Text(
                        'Agenda',
                        style: TextStyle(
                          color: AppColors.grey0,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      TouchableOpacity(
                        onTap: () => ref.read(controllerVM).goToAgenda(),
                        child: const Text(
                          'View Agenda',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  AgendaCardWidget(
                    agenda: Agenda(
                      startTime: DateTime(2022, 10, 23, 9),
                      endTime: DateTime(2022, 10, 23, 10),
                      status: AgendaStatus.ongoing,
                      sessionTitle: 'WTM + WW Breakfast / Registration',
                      venue: 'Hall A',
                      firstName: 'Sodiq',
                      lastName: 'Akinjobi',
                      avatar: 'Sodiq',
                      role: 'Lead Product Manager, Google',
                      backgroundImage: 'Rectangle_1',
                      sessionSynopsis: 'Attendees Registration.',
                    ),
                  ),
                  const Gap(32),
                  Row(
                    children: [
                      const Text(
                        'Speakers',
                        style: TextStyle(
                          color: AppColors.grey0,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      TouchableOpacity(
                        onTap: () => ref.read(controllerVM).goToSpeakers(),
                        child: const Text(
                          'View Speakers',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SpeakerCard(
                    backgroundImage: speakerDets.first.backgroundImage,
                    title: speakerDets.first.topic,
                    avatar: speakerDets.first.avatar,
                    firstName: speakerDets.first.firstName,
                    lastName: speakerDets.first.lastName,
                    role: speakerDets.first.role,
                    time: speakerDets.first.time,
                    venue: speakerDets.first.venue,
                    category: speakerDets.first.category,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeSlider extends StatelessWidget {
  const HomeSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Swiper(
        autoplay: true,
        curve: Curves.fastOutSlowIn,
        duration: 500,
        itemBuilder: (context, i) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 207,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: ExactAssetImage(
                          'banner_${i + 1}'.png,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: 3,
        itemWidth: context.screenWidth(),
        pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: AppColors.greyWhite40,
            activeColor: AppColors.primaryBlue,
            size: 8,
            activeSize: 8,
            space: 3,
          ),
        ),
      ),
    );
  }
}
