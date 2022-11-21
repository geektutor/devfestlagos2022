import 'package:devfest/utils/colors.dart';
import 'package:devfest/widgets/speaker_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/state/providers.dart';
import '../../utils/constants.dart';
import '../../widgets/app_bar.dart';

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
            // const Gap(24),
            // SizedBox(
            //   height: 31,
            //   child: ref.watch(categoriesStreamProvider).when(
            //         data: (data) {
            //           return SingleChildScrollView(
            //             scrollDirection: Axis.horizontal,
            //             child: Row(
            //               children: [
            //                 const SizedBox(
            //                     width: AppConstants.horizontalPadding),
            //                 _CategoryChip(
            //                   title: 'All',
            //                   selected: ref.watch(categoryProvider) == null,
            //                   onTap: () {
            //                     ref.read(categoryProvider.notifier).state =
            //                         null;
            //                   },
            //                 ),
            //                 const SizedBox(width: 8),
            //                 Wrap(
            //                   spacing: 8,
            //                   children: data?.map((e) {
            //                         return _CategoryChip(
            //                           title: e.name ?? '',
            //                           selected:
            //                               ref.watch(categoryProvider) == e.name,
            //                           onTap: () {
            //                             ref
            //                                 .read(categoryProvider.notifier)
            //                                 .state = e.name;
            //                           },
            //                         );
            //                       }).toList() ??
            //                       const [],
            //                 ),
            //                 const SizedBox(
            //                     width: AppConstants.horizontalPadding),
            //               ],
            //             ),
            //           );
            //         },
            //         error: (err, stack) => Center(
            //           child: Text('Error $err'),
            //         ),
            //         loading: () => const Center(
            //           child: LinearProgressIndicator(),
            //         ),
            //       ),
            // ),
            ref.watch(speakersStreamProvider).when(
                  data: (data) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: AppConstants.horizontalPadding,
                      ),
                      itemCount: data?.length ?? 0,
                      itemBuilder: (_, i) {
                        data?.sort(
                            (a, b) => (a.order ?? 0).compareTo((b.order ?? 0)));
                        return SpeakerCard(
                          backgroundImage: data?[i].bgColor ?? 'Rectangle_1',
                          title: '',
                          avatar: data?[i].avatar ?? '',
                          name: data?[i].name ?? '',
                          role: data?[i].role ?? '',
                          time: '',
                          venue: '',
                          category: '',
                          description: data?[i].bio,
                        );
                      },
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
