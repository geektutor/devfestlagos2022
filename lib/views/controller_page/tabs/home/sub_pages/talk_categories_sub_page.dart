import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TalkCategoriesSubPage extends HookConsumerWidget {
  const TalkCategoriesSubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return ListView(
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
        for (var i = 0; i < 10; i++)
          Column(
            children: [
              const Gap(21),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('robot'.svg),
                  const Gap(11.5),
                  Text(
                    'Machine Learning',
                    style: const TextStyle(
                      color: AppColors.grey0,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset('arrow'.svg).rotate(turns: 2),
                ],
              ),
              const Gap(21),
              Container(
                height: 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(237, 238, 241, 0.4),
                  borderRadius: BorderRadius.circular(16),
                ),
              )
            ],
          ),
      ],
    );
  }
}
