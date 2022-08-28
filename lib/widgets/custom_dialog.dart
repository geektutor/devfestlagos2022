import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/colors.dart';
import 'button.dart';
import 'touchable_opacity.dart';

class CustomDialogWidget<T> extends StatelessWidget {
  const CustomDialogWidget({Key? key}) : super(key: key);

  Future<void> show(BuildContext context) async {
    await showDialog<T>(
      context: context,
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
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
              child: TouchableOpacity(
                onTap: () => Navigator.of(context).pop(),
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
  }
}
