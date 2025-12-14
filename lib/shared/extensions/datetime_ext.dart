import 'package:intl/intl.dart';

/// Extension methods for DateTime
extension DateTimeExt on DateTime {
  /// Format as "MMM dd, yyyy • hh:mm a"
  String get formatted {
    return DateFormat('MMM dd, yyyy • hh:mm a').format(this);
  }

  /// Format time only as "hh:mm a"
  String get timeFormatted {
    return DateFormat('hh:mm a').format(this);
  }

  /// Format date only as "MMM dd, yyyy"
  String get dateFormatted {
    return DateFormat('MMM dd, yyyy').format(this);
  }

  /// Get relative time string (e.g., "5 minutes ago")
  String get relative {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}
