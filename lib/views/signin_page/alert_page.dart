import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/button.dart';

enum AlertType { success, error, failure, almost }

class AlertParams {
  final AlertType type;
  final String title;
  final String description;
  final void Function()? primaryAction;
  final void Function()? secondaryAction;
  final String? primaryBtnText;
  final String? secondaryBtnText;

  AlertParams({
    required this.type,
    required this.title,
    required this.description,
    this.primaryAction,
    this.secondaryAction,
    this.primaryBtnText,
    this.secondaryBtnText,
  })  : assert((primaryAction != null && primaryBtnText != null) ||
            (primaryAction == null && primaryBtnText == null)),
        assert((secondaryAction != null && secondaryBtnText != null) ||
            (secondaryAction == null && secondaryBtnText == null));
}

class AlertPage extends StatelessWidget {
  const AlertPage({
    Key? key,
    required this.params,
  }) : super(key: key);

  final AlertParams params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const EmptyAppBar(color: AppColors.white),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/png/signin_bg.png'),
                  fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                24, 0, 24, params.secondaryAction != null ? 25 : 112),
            child: Column(
              children: [
                Gap(context.screenHeight(.15)),
                CircleAvatar(
                  backgroundColor: params.type.bordercolor,
                  maxRadius: 64,
                  child: CircleAvatar(
                    backgroundColor: params.type.bgcolor,
                    maxRadius: 61,
                    child: CircleAvatar(
                      backgroundColor: params.type.bordercolor,
                      maxRadius: 50,
                      child: CircleAvatar(
                        backgroundColor: params.type.bgcolor,
                        radius: 47,
                        child: Center(
                          child: Text(
                            params.type.icon,
                            style: const TextStyle(
                              color: AppColors.grey6,
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(24),
                Text(
                  params.title,
                  style: const TextStyle(
                    color: AppColors.grey0,
                    fontSize: 32,
                    height: 40 / 32,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(8),
                Text(
                  params.description,
                  style: const TextStyle(
                    color: AppColors.grey6,
                    fontSize: 16,
                    height: 22 / 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                if (params.primaryAction != null)
                  DevFestButton(
                    width: double.infinity,
                    text: params.primaryBtnText!,
                    onTap: params.primaryAction,
                  ),
                if (params.secondaryAction != null)
                  DevFestButton(
                      color: Colors.transparent,
                      textColor: AppColors.grey16,
                      width: double.infinity,
                      text: params.secondaryBtnText!,
                      onTap: params.secondaryAction)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
