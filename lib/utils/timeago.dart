String timeAgoSinceDate(DateTime date, {bool numericDates = true}) {
  final date2 = DateTime.now();
  final difference = date2.difference(date);

  if ((difference.inDays.abs() / 365).floor() >= 2) {
    return '${(difference.inDays.abs().abs() / 365).floor()} years ago';
  } else if ((difference.inDays.abs() / 365).floor() >= 1) {
    return (numericDates) ? '1 year ago' : 'Last year';
  } else if ((difference.inDays.abs() / 30).floor() >= 2) {
    return '${(difference.inDays.abs() / 30).floor()} months ago';
  } else if ((difference.inDays.abs() / 30).floor() >= 1) {
    return (numericDates) ? '1 month ago' : 'Last month';
  } else if ((difference.inDays.abs() / 7).floor() >= 2) {
    return '${(difference.inDays.abs() / 7).floor()} weeks ago';
  } else if ((difference.inDays.abs() / 7).floor() >= 1) {
    return (numericDates) ? '1 week ago' : 'Last week';
  } else if (difference.inDays.abs() >= 2) {
    return '${difference.inDays.abs()} days ago';
  } else if (difference.inDays.abs() >= 1) {
    return (numericDates) ? '1 day ago' : 'Yesterday';
  } else if (difference.inHours.abs() >= 2) {
    return '${difference.inHours.abs()} hours ago';
  } else if (difference.inHours.abs() >= 1) {
    return (numericDates) ? '1 hour ago' : 'An hour ago';
  } else if (difference.inMinutes.abs() >= 2) {
    return '${difference.inMinutes.abs()} minutes ago';
  } else if (difference.inMinutes.abs() >= 1) {
    return (numericDates) ? '1 minute ago' : 'A minute ago';
  } else if (difference.inSeconds.abs() >= 3) {
    return '${difference.inSeconds.abs()} seconds ago';
  } else {
    return 'Just now';
  }
}
