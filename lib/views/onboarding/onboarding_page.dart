import 'package:devfest/core/router/router.dart';
import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/widgets/app_bar.dart';
import 'package:devfest/widgets/stories/flutter_stories.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:devfest/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _momentDuration = const Duration(seconds: 6);

  final storyList = const [
    _OnboardingItem(
      image: 'ob_1',
      title: 'Welcome to DevFest Lagos!',
      subtitle:
          'We are glad to have you here at this event\ncreated with you in mind 😁',
      bgColor: AppColors.lightYellow,
    ),
    _OnboardingItem(
      image: 'ob_2',
      title: 'See all Sessions and Event',
      subtitle:
          'To check-in, input the email you used to\nregister for the DevFest.',
      bgColor: AppColors.lightBlue,
    ),
    _OnboardingItem(
      image: 'ob_3',
      title: 'Easy Check-in on Event Day',
      subtitle:
          'At the registration desk, scan the QR code and\nyou are ready to go!',
      bgColor: AppColors.white,
    ),
  ];

  final controller = StoryController();

  int currIndex = 0;

  Color get bgColor => storyList[currIndex].bgColor;

  @override
  void initState() {
    super.initState();
    controller.onChange = (val) {
      setState(() {
        currIndex = val + 1;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: EmptyAppBar(color: bgColor),
      body: Stack(
        children: [
          Positioned.fill(
            child: Story(
              controller: controller,
              momentCount: storyList.length,
              fullscreen: false,
              onFlashForward: () => context.go(Routes.signInPage),
              momentDurationGetter: (idx) => _momentDuration,
              topOffset: 40,
              momentBuilder: (context, index) {
                return _OnboardingBuilder(
                  item: storyList[index],
                  controller: controller,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingBuilder extends StatelessWidget {
  const _OnboardingBuilder({
    required this.item,
    required this.index,
    this.controller,
  });

  final _OnboardingItem item;
  final int index;
  final StoryController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(100),
        Text(
          item.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 28,
            color: AppColors.grey0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(6),
        Text(
          item.subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.grey6,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        if (index != 2) ...[
          TouchableOpacity(
            onTap: () => controller?.next(),
            child: const Text(
              'SKIP',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.grey4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ] else ...[
          DevFestButton(
            text: 'Lets Go!',
            onTap: () => context.go(Routes.signInPage),
          )
        ],
        const Spacer(),
        SvgPicture.asset(item.image.svg),
      ],
    );
  }
}

class _OnboardingItem {
  final String title;
  final String subtitle;
  final String image;
  final Color bgColor;

  const _OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.bgColor,
  });
}
