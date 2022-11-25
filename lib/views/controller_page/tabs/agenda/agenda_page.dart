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
    return (DateTime(2022, 11, 26).difference(DateTime.now()).inHours <= 24)
        ? Scaffold(
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
                        horizontal: AppConstants.horizontalPadding,
                        vertical: 8),
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
                              data?.sort((a, b) =>
                                  (a.order ?? 0).compareTo((b.order ?? 0)));
                              return AgendaCardWidget(
                                agenda: Agenda(
                                    time: data?.elementAt(i).time ?? '',
                                    status: AgendaStatus.pending,
                                    sessionTitle: (data
                                                ?.elementAt(i)
                                                .schedule
                                                ?.isNotEmpty ??
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
            ))
        : Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              centerTitle: false,
              title: const Text(
                'Agenda',
                style: TextStyle(
                  color: AppColors.grey0,
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  CircleAvatar(
                    backgroundColor: AppColors.yellowPrimary,
                    maxRadius: 64,
                    child: CircleAvatar(
                      backgroundColor: AppColors.lightYellow,
                      maxRadius: 61,
                      child: CircleAvatar(
                        backgroundColor: AppColors.yellowPrimary,
                        maxRadius: 50,
                        child: CircleAvatar(
                          backgroundColor: AppColors.lightYellow,
                          radius: 47,
                          child: Center(
                            child: Text(
                              '😉',
                              style: TextStyle(
                                color: AppColors.grey6,
                                fontSize: 36,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(24),
                  Text(
                    "Agenda will be available soon",
                    style: TextStyle(
                      color: AppColors.grey0,
                      fontSize: 32,
                      height: 1.25,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(8),
                  Text(
                    "The agenda will be made available before the event. Just hold on a bit more 💪",
                    style: TextStyle(
                      color: AppColors.grey6,
                      fontSize: 16,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
  }
}
