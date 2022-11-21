import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/router/navigator.dart';
import '../../../../../core/state/providers.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../widgets/info_card_widget.dart';

class TeamsPage extends ConsumerWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          ref.watch(organizersStreamProvider).when<Widget>(
                data: (data) => ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      top: 16,
                      bottom: MediaQuery.of(context).viewPadding.bottom + 16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, i) => InfoCardWidget(
                    title: data?.elementAt(i).name ?? 'NOT_FOUND',
                    subtitle:
                        '${data?.elementAt(i).role ?? ''} ${data?.elementAt(i).organization ?? ''}',
                    externalLinks: data?.elementAt(i).twitterUrl ?? '',
                    avatarUrl: data?.elementAt(i).avatar,
                  ),
                  separatorBuilder: (_, __) => const Gap(16),
                  itemCount: data?.length ?? 0,
                ),
                error: (err, stack) => Center(child: Text('Error: $err')),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
        ],
      ),
    );
  }
}
