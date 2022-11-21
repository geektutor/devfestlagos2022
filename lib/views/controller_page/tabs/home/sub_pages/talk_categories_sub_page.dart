import 'package:cached_network_image/cached_network_image.dart';
import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../widgets/app_bar.dart';

class TalkCategory {
  String name;
  Icon icon;

  TalkCategory({required this.name, required this.icon});
}

class TalkCategoriesSubPage extends HookConsumerWidget {
  const TalkCategoriesSubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const EmptyAppBar(
        color: AppColors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Row(
              children: [
                TouchableOpacity(
                  onTap: () => ref.read(controllerVM).returnToDefaultPage(),
                  child: SvgPicture.asset('arrow'.svg),
                ),
              ],
            ),
            const Gap(24),
            const Text(
              'Talk Categories',
              style: TextStyle(
                color: AppColors.grey0,
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
            ref.watch(categoriesStreamProvider).when<Widget>(
                  data: (data) => Column(
                    children: data
                            ?.map((e) => GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(controllerVM)
                                        .returnToDefaultPage();
                                    ref.read(controllerVM).goToSessions(e.name);
                                  },
                                  child: Column(
                                    children: [
                                      const Gap(21),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: e.imageUrl ?? '',
                                            height: 24,
                                            width: 24,
                                            errorWidget: (_, __, ___) =>
                                                const Icon(
                                              PhosphorIcons.globe,
                                              size: 24,
                                            ),
                                          ),
                                          const Gap(11.5),
                                          Text(
                                            e.name ?? 'NOT_FOUND',
                                            style: const TextStyle(
                                              color: AppColors.grey0,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Spacer(),
                                          SvgPicture.asset('arrow'.svg)
                                              .rotate(turns: 2),
                                        ],
                                      ),
                                      const Gap(21),
                                      Container(
                                        height: 2,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              237, 238, 241, 0.4),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                            .toList() ??
                        const [],
                  ),
                  error: (err, stack) => Text('Error: $err'),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
