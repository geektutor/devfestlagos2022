import 'dart:math';

import 'package:devfest/core/model/user_info.dart';
import 'package:devfest/core/router/navigator.dart';
import 'package:devfest/core/state/providers.dart';
import 'package:devfest/services/firestore_db.dart';
import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/widgets/button.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/state/viewmodels/signin_vm.dart';
import '../../../../utils/utils.dart';

List<String> checkedInTweets = [
  "https://twitter.com/intent/tweet?text=I'm%20at%20the%20biggest%20tech%20event%20in%20the%20country%20%23DevFestLagos.%20Where%20are%20you%3F%20%23DevFest%20%23DevFest2022&url=",
  "https://twitter.com/intent/tweet?text=Here%20for%20the%20panels%20and%20the%20swags.%20%20%23DevFestLagos!!%20%23DevFest%20%23DevFest2022&url=",
  "https://twitter.com/intent/tweet?text=If%20you're%20not%20at%20%23DevFestLagos%2C%20you%20are%20wrong!%20%23DevFest%20%23DevFest2022&url=",
  "https://twitter.com/intent/tweet?text=Best%20in%20attending%20tech%20events.%20We're%20out%20for%20%23DevFestLagos!%20Come%20say%20hi%3F%20%23DevFest%20%23DevFest2022&url=",
];

List<String> notCheckedInTweet = [
  "https://twitter.com/intent/tweet?text=I'm%20going%20to%20be%20at%20the%20biggest%20tech%20event%20in%20the%20country%20%23DevFestLagos.%20Where%20will%20you%20be%3F%20%23DevFest%20%23DevFest2022%0A&url=",
  "https://twitter.com/intent/tweet?text=Anticipating%20%23DevFestLagos%2C%20I%20can't%20wait.%20%23DevFest%20%23DevFest2022&url=",
  "https://twitter.com/intent/tweet?text=Going%20for%20the%20panels%20and%20the%20swags.%20See%20you%20at%20%23DevFestLagos!!%20%23DevFest%20%23DevFest2022&url=",
  "https://twitter.com/intent/tweet?text=If%20you're%20not%20going%20to%20be%20at%20%23DevFestLagos%2C%20you%20are%20wrong!%20%23DevFest%20%23DevFest2022&url=",
  "https://twitter.com/intent/tweet?text=Gotten%20your%20ticket%20for%20%23DevFestLagos%20yet%3F%20I%20have!%20Can't%20wait%20to%20be%20there!!%20%23DevFest%20%23DevFest2022&url=",
];

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final signinVm = ref.watch(signinVM);
    final user = auth.currentUser;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox.shrink(),
      ),
      body: StreamBuilder<UserAttendanceInfoModel?>(
        initialData: const UserAttendanceInfoModel(),
        stream: (user?.email?.isNotEmpty ?? false)
            ? FirestoreUserDBService.instance.userInfoStream(user?.email ?? '')
            : null,
        builder: (context, snapshot) {
          final userInfo = snapshot.data;
          final isCheckedIn = userInfo?.checkedIn ?? false;
          return SafeArea(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/png/signin_bg.png'),
                        fit: BoxFit.contain),
                  ),
                ),
                ListView(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.topCenter,
                      fit: StackFit.loose,
                      children: <Widget>[
                        Image.asset(
                          'profile_banner'.png,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: context.screenHeight(.3),
                        ),
                        Positioned(
                          bottom: -60,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF7E1),
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 3, color: AppColors.white),
                            ),
                            child: Center(
                              child: user == null
                                  ? Text(
                                      user?.displayName?[0].toUpperCase() ?? '',
                                      style: const TextStyle(
                                        color: AppColors.grey2,
                                        fontSize: 57,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : ClipOval(
                                      child: Image.network(
                                        "https://robohash.org/${user.email}",
                                        height: 100,
                                        width: 100,
                                        errorBuilder: (_, __, ___) =>
                                            const ClipOval(
                                          child: Icon(
                                            Icons.person,
                                            size: 80,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Gap(70),
                    if (user == null)
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Text(
                            'Not Registered',
                            style: TextStyle(
                              color: AppColors.grey0,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                user.displayName?.capitalizeFirstofEach ?? '',
                                style: const TextStyle(
                                  color: AppColors.grey0,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isCheckedIn
                                      ? const Color(0xFFF3FBF5)
                                      : const Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  isCheckedIn ? 'Attendee' : 'Not Checked In',
                                  style: TextStyle(
                                    color: isCheckedIn
                                        ? AppColors.greenPrimary
                                        : AppColors.grey0,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor:
                                  const Color(0xFF1DA1F2).withOpacity(.1),
                              radius: 32,
                              child: const Image(
                                image: AssetImage(
                                  "assets/images/png/twitter.png",
                                ),
                                width: 32,
                              ),
                            ),
                            Text(
                                !(userInfo?.checkedIn ?? false)
                                    ? "Want to let everyone know you're here? Make a tweet!!"
                                    : "Tell your timeline you're here at DevFest Lagos! Tweet about it!",
                                style: const TextStyle(
                                  color: AppColors.grey0,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                )),
                            const Gap(40),
                            Center(
                                child: DevFestButton(
                              text: "Tell Your Friends!",
                              color: !(userInfo?.checkedIn ?? false)
                                  ? AppColors.greyWhite80
                                  : null,
                              textColor: !(userInfo?.checkedIn ?? false)
                                  ? AppColors.grey0
                                  : null,
                              onTap: () => launchUrl(
                                  Uri.parse(parseUrl(!(userInfo?.checkedIn ??
                                          false)
                                      ? notCheckedInTweet.elementAt(Random()
                                          .nextInt(notCheckedInTweet.length))
                                      : checkedInTweets.elementAt(Random()
                                          .nextInt(checkedInTweets.length)))),
                                  mode: LaunchMode.externalApplication),
                            )),
                          ],
                        ),
                      ),
                    const Gap(8),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 50),
                      child: Column(
                        children: [
                          if (user == null) ...[
                            const Text(
                              'Fast track your check-in into the event',
                              style: TextStyle(
                                color: AppColors.grey0,
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Gap(8),
                            const Text(
                              'You can complete your registration here.',
                              style: TextStyle(
                                color: AppColors.grey6,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Gap(32),
                            TouchableOpacity(
                              onTap: () async {
                                var user = await ref
                                    .read(authProvider)
                                    .signInWithGoogle();
                                if (user != null) {
                                  AppNavigator.pushNamedAndClear(
                                      Routes.controllerPage);
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
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
                            // SvgPicture.asset('or'.svg),
                            const Gap(24),
                            const Gap(24),
                          ],
                          if (!(userInfo?.checkedIn ?? false))
                            Column(
                              children: [
                                const Gap(24),
                                DevFestButton(
                                  loading: signinVm.state == VmState.busy,
                                  text: 'Check in',
                                  onTap: () => signinVm.scanQrCode(user),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ScannerView extends StatelessWidget {
  const ScannerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;
              debugPrint('Barcode found! $code');
              Navigator.pop(context, code);
            }
          }),
    );
  }
}
