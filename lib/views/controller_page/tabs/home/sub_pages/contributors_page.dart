import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/router/navigator.dart';
import '../../../../../core/state/providers.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';
import '../../../widgets/contributor_card.dart';

class ContributorsPage extends ConsumerWidget {
  const ContributorsPage({super.key});

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
            'Contributors',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 28,
              color: AppColors.grey0,
            ),
          ),
          const Gap(8),
          const Text(
            'These amazing volunteers came together to create the DevFest app and website. Bunch of amazing people',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: AppColors.grey6,
            ),
          ),
          const Gap(24),
          ref.watch(contributorsStreamProvider).when<Widget>(
                data: (data) => ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      top: 16,
                      bottom: MediaQuery.of(context).viewPadding.bottom + 16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, i) {
                    data?.sort(
                        (a, b) => (a.order ?? 0).compareTo((b.order ?? 0)));
                    return ContributorCard(contributor: data?.elementAt(i));
                  },
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
