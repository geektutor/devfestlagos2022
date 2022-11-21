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

import '../../../../core/state/viewmodels/signin_vm.dart';

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
                              child: Text(
                                user?.displayName?[0].toUpperCase() ?? '',
                                style: const TextStyle(
                                  color: AppColors.grey2,
                                  fontSize: 57,
                                  fontWeight: FontWeight.w700,
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
                    const Gap(8),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 50),
                      child: Column(
                        children: [
                          if (user == null) ...[
                            const Text(
                              'Fasttrack your checkin into the event',
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
                                  text: 'Checkin',
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
