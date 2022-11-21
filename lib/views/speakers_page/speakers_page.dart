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

class SpeakersPage extends ConsumerWidget {
  const SpeakersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const EmptyAppBar(
        color: AppColors.white,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding),
              child: Text(
                'Speakers',
                style: TextStyle(
                    color: AppColors.grey0,
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const Gap(24),
            SizedBox(
              height: 31,
              child: ref.watch(categoriesStreamProvider).when(
                    data: (data) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(
                                width: AppConstants.horizontalPadding),
                            _CategoryChip(
                              title: 'All',
                              selected: ref.watch(categoryProvider) == null,
                              onTap: () {
                                ref.read(categoryProvider.notifier).state =
                                    null;
                              },
                            ),
                            const SizedBox(width: 8),
                            Wrap(
                              spacing: 8,
                              children: data?.map((e) {
                                    return _CategoryChip(
                                      title: e.name ?? '',
                                      selected:
                                          ref.watch(categoryProvider) == e.name,
                                      onTap: () {
                                        ref
                                            .read(categoryProvider.notifier)
                                            .state = e.name;
                                      },
                                    );
                                  }).toList() ??
                                  const [],
                            ),
                            const SizedBox(
                                width: AppConstants.horizontalPadding),
                          ],
                        ),
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
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: AppConstants.horizontalPadding,
                      ),
                      itemCount: data?.length ?? 0,
                      itemBuilder: (_, i) => FutureBuilder<Session>(
                        future: data?.elementAt(i),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            final session = snapshot.requireData;
                            return Visibility(
                              visible: ref.watch(categoryProvider) == null ||
                                  ref.watch(categoryProvider) ==
                                      session.category?.name,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: SpeakerCard(
                                  backgroundImage:
                                      session.bgColor ?? 'Rectangle_3',
                                  title: session.title ?? '',
                                  avatar: session.speaker?.avatar ?? '',
                                  name: session.speaker?.name ?? '',
                                  role:
                                      '${session.speaker?.role ?? ''} ${session.speaker?.organisation ?? ''}',
                                  time: (DateTime.now()).timeOfDay,
                                  venue: session.venue?.name ?? '',
                                  category: session.category?.name ?? '',
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: Text('Fetching Session...'),
                          );
                        },
                      ),
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

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    this.selected = false,
    required this.title,
    this.onTap,
  });
  final VoidCallback? onTap;
  final bool selected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      height: 31,
      onTap: onTap,
      decoration: BoxDecoration(
          color: selected ? AppColors.blue1 : AppColors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
              color: selected ? AppColors.blue1 : AppColors.grey16, width: 2)),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: selected ? AppColors.blue7 : AppColors.grey6),
        ),
      ),
    );
  }
}
