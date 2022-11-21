import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class DevFestControllerBottomNav extends HookConsumerWidget {
  const DevFestControllerBottomNav({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final pages = ref.watch(
      controllerVM.select(
        (v) => v.pages,
      ),
    );

    final currentTab = ref.watch(
      controllerVM.select(
        (v) => v.currentTab,
      ),
    );

    return Container(
      color: AppColors.blueBackground,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            color: const Color(0xffF1F4F2),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var i = 0; i < pages.length; i++)
                  Tooltip(
                    message: pages[i].name,
                    child: TouchableOpacity(
                      onTap: () => ref.read(controllerVM).onPageChanged(i),
                      child: Builder(
                        builder: (BuildContext context) {
                          final item = pages[i];
                          final selected = i == currentTab;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                height: 38,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 8,
                                ),
                                decoration: selected
                                    ? BoxDecoration(
                                        color: AppColors.blueIconBackground,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      )
                                    : null,
                                duration: const Duration(milliseconds: 350),
                                child: SvgPicture.asset(
                                  item.image.svg,
                                  width: i == 1 || i == 4 ? 20 : 24,
                                  fit: BoxFit.fitWidth,
                                  color: selected
                                      ? AppColors.blueIcon
                                      : AppColors.grey12,
                                ),
                              ),
                              const Gap(6),
                              Text(
                                item.name,
                                style: TextStyle(
                                  color: selected
                                      ? AppColors.blueIcon
                                      : AppColors.grey12,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
