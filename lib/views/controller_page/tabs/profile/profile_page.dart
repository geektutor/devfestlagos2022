import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/widgets/button.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox.shrink(),
      ),
      body: SafeArea(
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
                          border: Border.all(width: 3, color: AppColors.white),
                        ),
                        child: const Center(
                          child: Text(
                            'S',
                            style: TextStyle(
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
                ),
                const Gap(8),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 50),
                  child: Column(
                    children: [
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
                        onTap: () {},
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
                      const Gap(24),
                      DevFestButton(
                        text: 'Checkin',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
