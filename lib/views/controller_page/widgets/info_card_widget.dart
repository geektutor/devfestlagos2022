import 'package:devfest/utils/colors.dart';
import 'package:devfest/utils/extensions/global_extensions.dart';
import 'package:devfest/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget({
    super.key,
    this.title = '',
    this.subtitle,
    this.bgImgUrl = 'google_banner',
    this.isSponsor = false,
    this.externalLinks = '',
    this.avatarUrl,
  });
  final String title;
  final String? subtitle;
  final String bgImgUrl;
  final bool isSponsor;
  final String externalLinks;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.greyWhite80,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: bgImgUrl != 'google_banner'
                  ? Image.network(
                      bgImgUrl,
                      height: 90,
                      fit: BoxFit.fill,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'google_banner'.png,
                        height: 90,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Image.asset(
                      bgImgUrl.png,
                      height: 90,
                      fit: BoxFit.fill,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    height: 116,
                    width: 116,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 3, color: AppColors.greyWhite80),
                    ),
                    alignment: Alignment.center,
                    child: isSponsor
                        ? avatarUrl != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AvatarImage(url: avatarUrl!),
                              )
                            : Image.asset('Sodiq'.png)
                        : ClipOval(
                            child: avatarUrl != null
                                ? AvatarImage(url: avatarUrl!)
                                : Image.asset('Sodiq'.png),
                          ),
                  ),
                  const Gap(13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.grey0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (subtitle != null) ...[
                            const Gap(5),
                            Text(
                              subtitle!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.grey12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                      Visibility(
                        visible: externalLinks.isNotEmpty,
                        child: GestureDetector(
                          onTap: () => launchUrl(
                              Uri.parse(parseUrl(externalLinks)),
                              mode: LaunchMode.externalApplication),
                          child: Icon(
                            isSponsor
                                ? PhosphorIcons.globe
                                : PhosphorIcons.twitter_logo,
                            size: isSponsor ? 24 : 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  const AvatarImage({super.key, required this.url, this.fit});
  final String url;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (url.contains('svg')) {
      return SvgPicture.network(
        url,
        fit: BoxFit.scaleDown,
      );
    }
    return Image.network(
      url,
      fit: fit ?? BoxFit.scaleDown,
    );
  }
}
