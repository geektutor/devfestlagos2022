import 'package:devfest/utils/colors.dart';
import 'package:devfest/views/controller_page/widgets/agenda_card.dart';
import 'package:devfest/widgets/speaker_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/model/session_response.dart';
import '../../core/state/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/touchable_opacity.dart';

List<String> categories = [
  'All',
  'Career',
  'Design',
  'Web3',
  'Product Management'
];

List<Speaker> speakerDets = [
  Speaker(
      firstName: 'Aise',
      lastName: 'Idahor',
      avatar: 'Aise',
      role: 'Product Designer, Valist',
      time: '9.00 AM',
      topic: 'Building a Career In the Web3 Space',
      venue: 'Hall A',
      backgroundImage: 'Rectangle_1',
      category: 'Career'),
  Speaker(
      firstName: 'Sodiq',
      lastName: 'Akinjobi',
      avatar: 'Sodiq',
      role: 'Lead Product Manager, Google',
      time: '9.00 AM',
      topic: 'Understanding Product Management',
      venue: 'Hall A',
      backgroundImage: 'Rectangle_2',
      category: 'Product Management'),
  Speaker(
      firstName: 'Sodiq',
      lastName: 'Akinjobi',
      avatar: 'Sodiq',
      role: 'Lead Product Manager, Google',
      time: '9.00 AM',
      topic: 'Understanding Product Management',
      venue: 'Hall A',
      backgroundImage: 'Rectangle_3',
      category: 'Product Management'),
];

class SpeakersPage extends ConsumerStatefulWidget {
  const SpeakersPage({Key? key}) : super(key: key);
  @override
  ConsumerState<SpeakersPage> createState() => _SpeakersPageState();
}

class _SpeakersPageState extends ConsumerState<SpeakersPage> {
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const EmptyAppBar(
        color: AppColors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const Text(
              'Speakers',
              style: TextStyle(
                  color: AppColors.grey0,
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
            const Gap(24),
            SizedBox(
              height: 31,
              child: ref.watch(categoriesStreamProvider).when(
                    data: (data) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: data?.length ?? 0,
                        separatorBuilder: (context, index) => const Gap(8),
                        itemBuilder: ((context, index) {
                          return TouchableOpacity(
                            height: 31,
                            onTap: () {
                              setState(() {
                                selectedCategory = index;
                              });
                            },
                            decoration: BoxDecoration(
                                color: selectedCategory == index
                                    ? AppColors.blue1
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: selectedCategory == index
                                        ? AppColors.blue1
                                        : AppColors.grey16,
                                    width: 2)),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Center(
                              child: Text(
                                data?[index].name ?? '',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: selectedCategory == index
                                        ? AppColors.blue7
                                        : AppColors.grey6),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                    error: (err, stack) => Center(
                      child: Text('Error $err'),
                    ),
                    loading: () => const Center(
                      child: LinearProgressIndicator(),
                    ),
                  ),
            ),
            ref.watch(sessionsStreamProvider).when(
                  data: (data) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: AppConstants.horizontalPadding),
                      itemCount: data?.length ?? 0,
                      itemBuilder: (_, i) => FutureBuilder<Session>(
                        future: data?.elementAt(i),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            final session = snapshot.requireData;
                            return SpeakerCard(
                              backgroundImage: 'Rectangle_3',
                              title: session.title ?? '',
                              avatar: session.speaker?.avatar ?? '',
                              name: session.speaker?.name ?? '',
                              role:
                                  '${session.speaker?.role ?? ''} ${session.speaker?.organisation ?? ''}',
                              time: (session.startTime ?? DateTime.now())
                                  .timeOfDay,
                              venue: session.venue?.name ?? '',
                              category: session.category?.name ?? '',
                            );
                          }
                          return const Center(
                            child: Text('Fetching Session...'),
                          );
                        },
                      ),
                      separatorBuilder: (_, __) => const Gap(8),
                    );
                  },
                  error: (err, stack) => Center(
                    child: Text('Error: $err'),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
          ],
        ),
      ),
    );
  }
}
