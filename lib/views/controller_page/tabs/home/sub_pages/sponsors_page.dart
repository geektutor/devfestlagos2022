import 'package:devfest/core/state/providers.dart';
import 'package:devfest/views/controller_page/widgets/info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/router/navigator.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';

class SponsorsPage extends ConsumerWidget {
  const SponsorsPage({super.key});

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
          ref.watch(sponsorsStreamProvider).when<Widget>(
                data: (data) => ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      top: 16,
                      bottom: MediaQuery.of(context).viewPadding.bottom + 16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, i) => InfoCardWidget(
                    title: data?.elementAt(i).name ?? 'NOT_FOUND',
                    externalLinks: data?.elementAt(i).website ?? '',
                    avatarUrl: data?.elementAt(i).logoImage,
                    bgImgUrl:
                        data?.elementAt(i).backgroundImage ?? 'google_banner',
                    isSponsor: true,
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
