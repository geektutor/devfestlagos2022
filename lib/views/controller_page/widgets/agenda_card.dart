import 'package:devfest/core/router/navigator.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/model/agenda_response.dart';
import '../../../core/state/providers.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import 'agenda_status_chip.dart';

class Agenda {
  final AgendaStatus status;
  final String sessionTitle;
  final String sessionSynopsis;
  final String venue;
  final String time;
  final String name;
  final String avatar;
  final String backgroundImage;
  final String role;
  final List<BreakoutSession> breakoutSession;

  const Agenda({
    this.status = AgendaStatus.pending,
    this.sessionTitle = '',
    this.venue = '',
    this.sessionSynopsis = '',
    this.name = '',
    this.avatar = '',
    this.backgroundImage = '',
    this.role = '',
    this.time = '',
    this.breakoutSession = const [],
  });
}

class AgendaCardWidget extends HookConsumerWidget {
  const AgendaCardWidget({super.key, this.index = 0, required this.agenda});

  final int index;
  final Agenda agenda;

  @override
  Widget build(BuildContext context, ref) {
    final speakers = ref.watch(speakersVM);
    final progressColor = agenda.status == AgendaStatus.complete
        ? AppColors.primaryBlue
        : AppColors.blue1;
    return GestureDetector(
      onTap: () {
        if (agenda.breakoutSession.isNotEmpty) {
          var data = agenda.breakoutSession;
          AppNavigator.push(
            Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                backgroundColor: AppColors.white,
                elevation: 0,
                automaticallyImplyLeading: true,
                leading: IconButton(
                  onPressed: () {
                    AppNavigator.maybePop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.black,
                  ),
                ),
              ),
              body: SafeArea(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: AppConstants.horizontalPadding),
                  itemCount: data.length,
                  itemBuilder: (_, i) {
                    return AgendaCardWidget(
                      agenda: Agenda(
                        time: data.elementAt(i).time ?? '',
                        status: AgendaStatus.pending,
                        sessionTitle:
                            (data.elementAt(i).schedule?.isNotEmpty ?? false)
                                ? data.elementAt(i).schedule ?? ''
                                : data.elementAt(i).time ?? '',
                        venue: data.elementAt(i).venue ?? '',
                        name: data.elementAt(i).facilitator ?? '',
                        avatar: '',
                        sessionSynopsis: '',
                        role: '',
                      ),
                      index: i,
                    );
                  },
                  separatorBuilder: (_, __) => const Gap(8),
                ),
              ),
            ),
          );
          return;
        }
        AppNavigator.pushNamed(Routes.moreInfoPage);
        speakers.updateSpeaker(
          status: agenda.status,
          avatar: agenda.avatar,
          title: agenda.sessionTitle,
          synopsis: agenda.sessionSynopsis,
          venue: agenda.venue,
          bgImage: agenda.backgroundImage,
          role: agenda.role,
          name: agenda.name,
          time: agenda.time,
        );
      },
      child: Container(
        width: double.infinity,
        // height: context.screenHeight(.13) + 56,
        decoration: BoxDecoration(
          color: AppColors.greyWhite80.withOpacity(0.3),
          borderRadius: BorderRadius.circular(18),
        ),

        child: Row(
          children: [
            const Gap(16),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 24,
                  width: 4,
                  color: index <= 0 ? Colors.transparent : progressColor,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryBlue,
                  ),
                  child: Center(
                    child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(
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
                  color: progressColor,
                ),
              ],
            ),
            const Gap(18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Gap(24),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      agenda.sessionTitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: false,
                      style: const TextStyle(
                        color: AppColors.grey0,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Gap(8),
                  Text(
                    agenda.breakoutSession.isEmpty
                        ? agenda.venue
                        : 'ROOM 1 - 6',
                    style: const TextStyle(
                      color: AppColors.grey12,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    agenda.time,
                    style: const TextStyle(
                      color: AppColors.grey12,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(24),
                  StatusChip(status: agenda.status),
                  const Gap(8),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension DisplayTime on DateTime {
  String get timeOfDay {
    final timeOfDay = TimeOfDay.fromDateTime(this);
    return '${timeOfDay.hour}.${NumberFormat('00').format(timeOfDay.minute)} ${timeOfDay.period.name.toLowerCase()}';
  }
}
