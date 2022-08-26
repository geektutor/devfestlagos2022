import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

extension CustomContext on BuildContext {
  double screenHeight([double percent = 1]) =>
      MediaQuery.of(this).size.height * percent;

  double screenWidth([double percent = 1]) =>
      MediaQuery.of(this).size.width * percent;
}

extension DurationExtensions on Duration {
  String timeFormat([bool hideMinutes = false]) {
    var seconds = inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final millisecondsPerSecond = seconds * Duration.millisecondsPerSecond;
    seconds -= minutes * Duration.secondsPerMinute;

    final tokens = <String>[];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('$minutes${hideMinutes ? '' : 'm'}');
    }

    if (seconds > 1) {
      tokens.add('${seconds}s');
    }

    if (hideMinutes == false && millisecondsPerSecond != 0) {
      tokens.add('${millisecondsPerSecond}ms');
    }

    return tokens.join(' ');
  }
}

extension IntExtensions on int {
  String readableTimestamp() {
    final formatter = DateFormat('HH:mm a');
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    return formatter.format(date);
  }

  String readableLastSeen() {
    final date = DateTime.fromMillisecondsSinceEpoch(this);
    final now = DateTime.now();
    const lastSeen = 'Last seen';

    if (now.year != date.year || now.month != date.month) {
      final formatter = DateFormat('MMM dd, yyyy');
      return '$lastSeen on ${formatter.format(date)}';
    } else if (now.day != date.day) {
      final diff = now.day - date.day.abs();
      return '$lastSeen${' $diff day'}${(diff > 1) ? 's' : ''} ago';
    } else if (now.hour != date.hour) {
      final diff = now.difference(date).inHours.abs();
      return '$lastSeen${' $diff hour'}${(diff > 1) ? 's' : ''} ago';
    } else if (now.minute != date.minute) {
      final diff = now.difference(date).inMinutes.abs();
      return '$lastSeen${' $diff minute'}${(diff > 1) ? 's' : ''} ago';
    } else if (now.second != date.second) {
      final diff = now.difference(date).inSeconds.abs();
      return '$lastSeen${' $diff second'}${(diff > 1) ? 's' : ''} ago';
    }
    return '';
  }
}

extension CapitalizeStringExtensions on String {
  String get capitalize => isNotEmpty && this[0].isNotEmpty
      ? '${this[0].toUpperCase()}${substring(1)}'
      : '';
}

extension StringExtensions on String {
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach =>
      length > 1 ? split(' ').map((str) => str.capitalize).join(' ') : this;

  String get svg => 'assets/images/svg/$this.svg';
  String get png => 'assets/images/png/$this.png';
  String get jpg => 'assets/images/png/$this.jpg';
}

extension WidgetUtilitiesX on Widget {
  /// Animated show/hide based on a test, with overrideable duration and curve.
  ///
  /// Applies [IgnorePointer] when hidden.
  Widget showIf(
    bool test, {
    Duration duration = const Duration(milliseconds: 350),
    Curve curve = Curves.easeInOut,
  }) =>
      AnimatedOpacity(
        opacity: test ? 1.0 : 0.0,
        duration: duration,
        curve: curve,
        child: IgnorePointer(
          ignoring: test == false,
          child: this,
        ),
      );

  /// Scale this widget by `scale` pixels.
  Widget scale([
    double scale = 0.0,
  ]) =>
      Transform.scale(
        scale: scale,
        child: this,
      );

  /// Transform this widget `x` or `y` pixels.
  Widget nudge({
    double x = 0.0,
    double y = 0.0,
  }) =>
      Transform.translate(
        offset: Offset(x, y),
        child: this,
      );

  /// Rotate this widget by `x` `turns`
  Widget rotate({
    int turns = 0,
  }) =>
      RotatedBox(
        quarterTurns: turns,
        child: this,
      );

  /// Wrap this widget in a [SliverToBoxAdapter]
  ///
  /// If you need access to `key`, do not use this extension method.
  Widget get asSliver => SliverToBoxAdapter(child: this);

  /// Return this widget with a given [Brightness] applied to [CupertinoTheme]
  Widget withBrightness(
    BuildContext context, [
    Brightness? _brightness = Brightness.dark,
  ]) =>
      CupertinoTheme(
        data: CupertinoTheme.of(context).copyWith(
          brightness: _brightness,
        ),
        child: this,
      );

  /// Wraps this widget in [Padding]
  /// that matches [MediaQueryData.viewInsets.bottom]
  ///
  /// This makes the widget avoid the software keyboard.
  Widget withKeyboardAvoidance(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: this,
      );
}
