import 'package:devfest/core/router/router.dart';
import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/views/signin_page/alert_page.dart';
import 'package:devfest/widgets/button.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/state/providers.dart';

class SignInPage extends StatefulHookConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.maybePop(context);
                    },
                    child: Container(
                      height: 26,
                      width: 26,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.grey6,
                          width: 3,
                        ),
                        color: AppColors.lightYellow,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 84,
                  width: 84,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.yellowPrimary,
                      width: 3,
                    ),
                    color: AppColors.lightYellow,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '🤔',
                      style: TextStyle(
                        color: AppColors.grey6,
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Gap(16),
                Column(
                  children: const [
                    Text(
                      'This email has not been registered yet',
                      style: TextStyle(
                        color: AppColors.grey0,
                        fontSize: 24,
                        height: 30 / 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(8),
                    Text(
                      'Visit Devfest.com to register your email address',
                      style: TextStyle(
                        color: AppColors.grey6,
                        fontSize: 16,
                        height: 22 / 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const Gap(24),
                const DevFestButton(
                  text: 'Register Email Address',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var vm = ref.read(signinVM);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SizedBox(
            height: context.screenHeight(.4),
            child: Stack(
              children: [
                Image.asset(
                  'signin_banner'.png,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Center(
                  child: SvgPicture.asset(
                    'logo'.svg,
                  ).scale(.8).nudge(y: -20),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: context.screenHeight(.7),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                children: [
                  const Text(
                    'Hey there 👋🏼',
                    style: TextStyle(
                      color: AppColors.grey0,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(8),
                  const Text(
                    'Input the email you used to register for DevFest Lagos to get started',
                    style: TextStyle(
                      color: AppColors.grey6,
                      fontSize: 16,
                    ),
                  ),
                  const Gap(32),
                  TouchableOpacity(
                    onTap: () => context.go(
                      Routes.alertPage,
                      extra: {
                        'type': AlertParams(
                            type: AlertType.almost,
                            title: 'Almost there!',
                            description:
                                'All that is left is to scan the nearest QR code to check-in to the event. You can also do this later.',
                            primaryAction: () => vm.scanQrCode(),
                            primaryBtnText: 'Scan QR Code',
                            secondaryAction: () => vm.skip(),
                            secondaryBtnText: 'Skip For Now')
                      },
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        color: AppColors.greyWhite80,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('google'.svg),
                          const Gap(10),
                          const Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: AppColors.grey2,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(24),
                  SvgPicture.asset('or'.svg),
                  const Gap(24),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter your email address',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.greyWhite80,
                        ),
                      ),
                      focusColor: AppColors.blue2,
                    ),
                  ),
                  const Gap(33),
                  Text.rich(
                    TextSpan(
                      text: 'You have not registered yet? ',
                      children: [
                        TextSpan(
                          text: 'Register',
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.primaryBlue,
                            fontFamily: 'CerebriSans',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.grey0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(80),
                  DevFestButton(
                    text: 'Verify Email Address',
                    onTap: _showDialog,
                  ),
                  const Gap(30),
                  DevFestButton(
                    text: 'Skip For Now',
                    color: Colors.transparent,
                    textColor: AppColors.grey16,
                    onTap: () => context.go(Routes.controllerPage),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
