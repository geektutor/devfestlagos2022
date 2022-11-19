import 'package:card_swiper/card_swiper.dart';
import 'package:devfest/core/router/navigator.dart';
import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/views/controller_page/widgets/info_card_widget.dart';
import 'package:devfest/widgets/app_bar.dart';
import 'package:devfest/widgets/pill_widget.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/model/session_response.dart';
import '../../../../widgets/speaker_card.dart';
import '../../widgets/agenda_card.dart';
import '../../widgets/agenda_status_chip.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.read(authProvider).currentUser;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const EmptyAppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Hi there, ${user?.displayName?.split(' ')[0].capitalize ?? ''} 🤗',
                style: const TextStyle(
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
                  ref.watch(categoriesStreamProvider).when<Widget>(
                        data: (data) {
                          final categories = data?.take(5);
                          return Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: categories
                                    ?.map(
                                      (e) => TouchableOpacity(
                                        onTap: () {
                                          ref
                                              .read(controllerVM)
                                              .goToSpeakers(e.name);
                                        },
                                        child: DevFestPillWidget(
                                          title: e.name ?? 'NOT_FOUND',
                                          iconUrl: e.imageUrl,
                                        ),
                                      ),
                                    )
                                    .toList() ??
                                const [],
                          );
                        },
                        error: (err, stack) =>
                            Center(child: Text('Error: $err')),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
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
                  ref.watch(sessionsStreamProvider).when(
                        data: (data) {
                          final session = data?[0];
                          return FutureBuilder<Session>(
                            future: session,
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                final session = snapshot.requireData;
                                return AgendaCardWidget(
                                    agenda: Agenda(
                                      startTime: DateTime.now(),
                                      endTime: DateTime.now(),
                                      status: AgendaStatus.pending,
                                      sessionTitle: session.title ?? '',
                                      venue: session.venue?.name ?? '',
                                      name: session.speaker?.name ?? '',
                                      avatar: session.speaker?.avatar ?? '',
                                      sessionSynopsis:
                                          session.description ?? '',
                                      role:
                                          '${session.speaker?.role ?? ''} ${session.speaker?.organisation ?? ''}',
                                    ),
                                    index: 0);
                              }

                              return const Center(
                                child: Text('Fetching Session...'),
                              );
                            },
                          );
                        },
                        error: (err, stack) => Center(
                          child: Text('Error: $err'),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
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
                  ref.watch(sessionsStreamProvider).when(
                        data: (data) {
                          return FutureBuilder<Session>(
                            future: data?[0],
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                final session = snapshot.requireData;
                                return SpeakerCard(
                                  backgroundImage: 'Rectangle_1',
                                  title: session.title ?? '',
                                  avatar: session.speaker?.avatar ?? '',
                                  name: session.speaker?.name ?? '',
                                  role:
                                      '${session.speaker?.role ?? ''} ${session.speaker?.organisation ?? ''}',
                                  time: (DateTime.now()).timeOfDay,
                                  venue: session.venue?.name ?? '',
                                  category: session.category?.name ?? '',
                                );
                              }
                              return const Center(
                                child: Text('Fetching Session...'),
                              );
                            },
                          );
                        },
                        error: (err, _) => Center(
                          child: Text('Error: $err'),
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  const Gap(32),
                  Row(
                    children: [
                      const Text(
                        'Sponsors',
                        style: TextStyle(
                          color: AppColors.grey0,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      TouchableOpacity(
                        onTap: () =>
                            AppNavigator.pushNamed(Routes.sponsorsPage),
                        child: const Text(
                          'View Sponsors',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ref.watch(sponsorsStreamProvider).when(
                          data: (data) {
                            data?.sort((a, b) =>
                                (a.order ?? 0).compareTo((b.order ?? 0)));
                            return SizedBox(
                              height: 50,
                              child: Swiper(
                                autoplay: true,
                                itemCount: data?.length ?? 0,
                                itemBuilder: (_, i) => SizedBox(
                                  height: 50,
                                  child: AvatarImage(
                                      fit: BoxFit.contain,
                                      url: data?.elementAt(i).logoUrl ?? ''),
                                ),
                              ),
                            );
                          },
                          error: (err, stack) =>
                              Center(child: Text('Error: $err')),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                  ),
                  const Gap(32),
                  Row(
                    children: [
                      const Text(
                        'Team',
                        style: TextStyle(
                          color: AppColors.grey0,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      TouchableOpacity(
                        onTap: () => AppNavigator.pushNamed(Routes.teamPage),
                        child: const Text(
                          'View Team',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: ref.watch(organizersStreamProvider).when<Widget>(
                          data: (data) => InfoCardWidget(
                            title: data?[0].name ?? 'NOT_FOUND',
                            subtitle:
                                '${data?[0].role ?? ''} ${data?[0].organization ?? ''}',
                            externalLinks: data?[0].twitterUrl ?? '',
                            avatarUrl: data?[0].avatar,
                          ),
                          error: (err, stack) =>
                              Center(child: Text('Error: $err')),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
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
