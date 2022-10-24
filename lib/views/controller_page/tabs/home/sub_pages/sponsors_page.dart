import 'package:devfest/views/controller_page/widgets/info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/router/navigator.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';

class SponsorsPage extends StatefulWidget {
  const SponsorsPage({super.key});

  @override
  State<SponsorsPage> createState() => _SponsorsPageState();
}

class _SponsorsPageState extends State<SponsorsPage> {
  final sponsors = const <String>['Google', 'LinkedIn', 'Interswitch'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding),
        children: [
          const Text(
            'Sponsors',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 28,
              color: AppColors.grey0,
            ),
          ),
          const Gap(8),
          const Text(
            'Without these companies there will have been no DevFest',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: AppColors.grey6,
            ),
          ),
          const Gap(24),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                bottom: 16 + MediaQuery.of(context).viewPadding.bottom),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) => InfoCardWidget(
              title: sponsors.elementAt(i),
              isSponsor: true,
            ),
            separatorBuilder: (_, __) => const Gap(16),
            itemCount: sponsors.length,
          ),
        ],
      ),
    );
  }
}
