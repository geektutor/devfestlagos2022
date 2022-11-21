import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';

class DevFestButton extends StatelessWidget {
  const DevFestButton({
    Key? key,
    this.onTap,
    this.width,
    this.height,
    this.padding,
    this.color,
    this.textColor,
    this.borderColor,
    this.fontSize,
    this.loading = false,
    this.enabled = true,
    required this.text,
  }) : super(key: key);

  final VoidCallback? onTap;
  final double? width, height, fontSize;
  final String text;
  final EdgeInsetsGeometry? padding;
  final bool enabled;
  final bool loading;
  final Color? color, textColor, borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: enabled ? 1.0 : 0.2,
      duration: const Duration(milliseconds: 250),
      child: SizedBox(
        width: width ?? context.screenWidth(.7),
        height: height,
        child: TouchableOpacity(
          onTap: (enabled && !loading) ? onTap : null,
          decoration: BoxDecoration(
            color: color ?? AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(32),
            border: borderColor != null
                ? Border.all(
                    color: borderColor!,
                  )
                : null,
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: loading
                  ? SizedBox(
                      height: fontSize ?? 17,
                      width: fontSize ?? 17,
                      child: const CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    )
                  : Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize ?? 17,
                        color: textColor ?? AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
