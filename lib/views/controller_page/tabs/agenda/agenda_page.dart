import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/constants.dart';
import 'package:devfest/views/controller_page/widgets/agenda_card.dart';
import 'package:devfest/views/controller_page/widgets/agenda_status_chip.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/colors.dart';
import '../../../../widgets/app_bar.dart';

// DateTime(2022, 10, 23, 9);

class AgendaPage extends ConsumerStatefulWidget {
  const AgendaPage({super.key});

  @override
  ConsumerState<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends ConsumerState<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const EmptyAppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            const Gap(10),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding),
              child: Text(
                'Agenda',
                style: TextStyle(
                  color: AppColors.grey0,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding, vertical: 8),
              child: Text(
                'Tap a tile to view more details',
                style: TextStyle(
                  color: AppColors.grey6,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ref.watch(agendaStreamProvider).when(
                  data: (data) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: AppConstants.horizontalPadding),
                      itemCount: data?.length ?? 0,
                      itemBuilder: (_, i) {
                        data?.sort(
                            (a, b) => (a.order ?? 0).compareTo((b.order ?? 0)));
                        return AgendaCardWidget(
                          agenda: Agenda(
                              time: data?.elementAt(i).time ?? '',
                              status: AgendaStatus.pending,
                              sessionTitle:
                                  (data?.elementAt(i).schedule?.isNotEmpty ??
                                          false)
                                      ? data?.elementAt(i).schedule ?? ''
                                      : data?.elementAt(i).time ?? '',
                              venue: '',
                              name: data?.elementAt(i).facilitator ?? '',
                              avatar: '',
                              sessionSynopsis: '',
                              role: '',
                              breakoutSession:
                                  data?.elementAt(i).sessions ?? []),
                          index: i,
                        );
                      },
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
