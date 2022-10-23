import 'package:card_swiper/card_swiper.dart';
import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/widgets/app_bar.dart';
import 'package:devfest/widgets/pill_widget.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                        image: 'robot',
                        title: 'Machine Learning',
                      ),
                      DevFestPillWidget(
                        image: 'web',
                        title: 'Web',
                      ),
                      DevFestPillWidget(
                        image: 'design',
                        title: 'Design',
                      ),
                      DevFestPillWidget(
                        image: 'android',
                        title: 'Android',
                      ),
                      DevFestPillWidget(
                        image: 'flutter',
                        title: 'Flutter',
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
                        onTap: () {},
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
                  const AgendaCardWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AgendaCardWidget extends StatelessWidget {
  const AgendaCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.screenHeight(.19),
      decoration: BoxDecoration(
        color: AppColors.greyWhite80.withOpacity(0.3),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Gap(30),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryBlue,
                ),
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: context.screenHeight(.13),
                width: 4,
                color: AppColors.blue1,
              ),
            ],
          ),
          const Gap(18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(26),
              const Text(
                'WTM + WW Breakfast / Registration',
                style: TextStyle(
                  color: AppColors.grey0,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(8),
              const Text(
                'Venue Entrance',
                style: TextStyle(
                  color: AppColors.grey12,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(8),
              const Text(
                '9.00 am - 10.00 am',
                style: TextStyle(
                  color: AppColors.grey12,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.yellow1,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'ONGOING',
                  style: TextStyle(
                    color: AppColors.yellowPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )
        ],
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
