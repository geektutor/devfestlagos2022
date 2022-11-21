import 'dart:math';

String get getSpeakerCardBg {
  const backgrounds = ['Rectangle_3', 'Rectangle_2', 'Rectangle_1'];
  final index = Random().nextInt(backgrounds.length);

  return backgrounds.elementAt(index);
}

String parseUrl(String url, {bool isMail = false}) {
  if (isMail) {
    return 'mailto:$url';
  }
  if (url.contains('https://')) {
    return url;
  }

  return 'https://$url';
}
