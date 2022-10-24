import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/router/navigator.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../widgets/info_card_widget.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({super.key});

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
            'Team',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 28,
              color: AppColors.grey0,
            ),
          ),
          const Gap(8),
          const Text(
            'Here are the amazing people that made DevFest 2022 a success 💪🏼',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: AppColors.grey6,
            ),
          ),
          const Gap(24),
          const Text(
            'Organizers',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.grey0,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: 16,
                bottom: MediaQuery.of(context).viewPadding.bottom + 16),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) => InfoCardWidget(
              title: i % 2 == 0 ? 'Maryann Onuoha' : 'Sodiq Akinjobi',
              subtitle: i % 2 == 0
                  ? 'Community Manager, Google, Ex-Apple'
                  : 'Product Lead, Google',
            ),
            separatorBuilder: (_, __) => const Gap(16),
            itemCount: 4,
          ),
        ],
      ),
    );
  }
}
