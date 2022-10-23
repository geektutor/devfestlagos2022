import 'package:devfest/utils/constants.dart';
import 'package:devfest/views/controller_page/widgets/agenda_card.dart';
import 'package:devfest/views/controller_page/widgets/agenda_status_chip.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../utils/colors.dart';
import '../../../../widgets/app_bar.dart';

// DateTime(2022, 10, 23, 9);

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final dummyAgenda = <Agenda>[
    Agenda(
      startTime: DateTime(2022, 10, 23, 9),
      endTime: DateTime(2022, 10, 23, 10),
      sessionTitle: 'WTM + WW Breakfast / Registration',
      venue: 'Hall A',
      status: AgendaStatus.complete,
      firstName: 'Aise',
      lastName: 'Idahor',
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
      firstName: 'Sodiq',
      lastName: 'Akinjobi',
      avatar: 'Sodiq',
      role: 'Lead Product Manager, Google',
      backgroundImage: 'Rectangle_1',
      sessionSynopsis:
          'In this talk, Aise instructs all adventurers looking into Web3 and tells them how to find opporunities best suited for them.',
    ),
    Agenda(
      startTime: DateTime(2022, 10, 23, 10, 30),
      endTime: DateTime(2022, 10, 23, 11),
      sessionTitle: 'Google DevRel',
      venue: 'Hall A',
      status: AgendaStatus.pending,
      firstName: 'Sodiq',
      lastName: 'Akinjobi',
      avatar: 'Sodiq',
      role: 'Lead Product Manager, Google',
      backgroundImage: 'Rectangle_2',
      sessionSynopsis:
          'In this talk, Aise instructs all adventurers looking into Web3 and tells them how to find opporunities best suited for them.',
    ),
    Agenda(
      startTime: DateTime(2022, 10, 23, 11),
      endTime: DateTime(2022, 10, 23, 11, 30),
      sessionTitle: 'Google Country Director(Juliet)',
      venue: 'Hall A',
      status: AgendaStatus.pending,
      firstName: 'Sodiq',
      lastName: 'Akinjobi',
      avatar: 'Sodiq',
      role: 'Lead Product Manager, Google',
      backgroundImage: 'Rectangle_3',
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
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: AppConstants.horizontalPadding),
              itemCount: dummyAgenda.length,
              itemBuilder: (_, i) =>
                  AgendaCardWidget(agenda: dummyAgenda[i], index: i),
              separatorBuilder: (_, __) => const Gap(8),
            ),
          ],
        ),
      ),
    );
  }
}
