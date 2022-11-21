import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/constants.dart';
import 'package:devfest/views/controller_page/widgets/agenda_card.dart';
import 'package:devfest/views/controller_page/widgets/agenda_status_chip.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/model/session_response.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/app_bar.dart';

// DateTime(2022, 10, 23, 9);

class AgendaPage extends ConsumerStatefulWidget {
  const AgendaPage({super.key});

  @override
  ConsumerState<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends ConsumerState<AgendaPage> {
  final dummyAgenda = <Agenda>[
    Agenda(
      startTime: DateTime(2022, 10, 23, 9),
      endTime: DateTime(2022, 10, 23, 10),
      sessionTitle: 'WTM + WW Breakfast / Registration',
      venue: 'Hall A',
      status: AgendaStatus.complete,
      name: 'Aise Idahor',
      avatar: 'Aise',
      role: 'Product Designer, Valist',
      backgroundImage: 'Rectangle_1',
      sessionSynopsis:
          'In this talk, Aise instructs all adventurers looking into Web3 and tells them how to find opporunities best suited for them.',
    ),
    Agenda(
      startTime: DateTime(2022, 10, 23, 10),
      endTime: DateTime(2022, 10, 23, 10, 30),
      sessionTitle: 'Welcome to GDG Lagos',
      venue: 'Hall A',
      status: AgendaStatus.ongoing,
      name: 'Sodiq Akinjobi',
      avatar: 'Sodiq',
      role: 'Lead Product Manager, Google',
      backgroundImage: 'Rectangle_1',
      sessionSynopsis:
          'In this talk, Aise instructs all adventurers looking into Web3 and tells them how to find opporunities best suited for them.',
    ),
  ];

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
                            return AgendaCardWidget(
                                agenda: Agenda(
                                  startTime: DateTime.now(),
                                  endTime: DateTime.now(),
                                  status: AgendaStatus.pending,
                                  sessionTitle: session.title ?? '',
                                  venue: session.venue?.name ?? '',
                                  name: session.speaker?.name ?? '',
                                  avatar: session.speaker?.avatar ?? '',
                                  sessionSynopsis: session.description ?? '',
                                  role:
                                      '${session.speaker?.role ?? ''} ${session.speaker?.organisation ?? ''}',
                                ),
                                index: i);
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
