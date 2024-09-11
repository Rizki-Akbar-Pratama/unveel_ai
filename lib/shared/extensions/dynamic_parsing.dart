import 'package:flutter/material.dart';

import '../../core/observers/logger.dart';

extension DynamicParsing on dynamic {
  TimeOfDay? get timeOfDay {
    try {
      TimeOfDay? result;

      if (this is String) {
        final String time = this as String;

        // ex data: "2023-12-16 01:01:01"
        if (time.contains(' ')) {
          final String timeWithoutDate = time.split(' ')[1];

          // ex data: "01:01:01"
          if (timeWithoutDate.contains(':')) {
            final List<String> timeSplit = timeWithoutDate.split(':');

            // ex data: ["01", "01", "01"]
            if (timeSplit.length == 3) {
              final int hour = int.parse(timeSplit[0]);
              final int minute = int.parse(timeSplit[1]);

              result = TimeOfDay(hour: hour, minute: minute);
            }
          }
        } else {
          // ex data: "01:01:01"
          if (time.contains(':')) {
            final List<String> timeSplit = time.split(':');

            // ex data: ["01", "01", "01"]
            if (timeSplit.length == 3) {
              final int hour = int.parse(timeSplit[0]);
              final int minute = int.parse(timeSplit[1]);

              result = TimeOfDay(hour: hour, minute: minute);
            }
          }
        }
      }
      Logger.success('timeOfDay result: $result');

      return result;
    } catch (error) {
      Logger.error('timeOfDay error: $error');

      rethrow;
    }
  }

  DateTime? get dateTime {
    try {
      DateTime? result;

      if (this is String) {
        final String time = this as String;

        // ex data: "2023-12-16 01:01:01"
        if (time.contains(' ')) {
          final String timeWithoutDate = time.split(' ')[0];

          // ex data: "2023-12-16"
          if (timeWithoutDate.contains('-')) {
            final List<String> timeSplit = timeWithoutDate.split('-');

            // ex data: ["2023", "12", "16"]
            if (timeSplit.length == 3) {
              final int year = int.parse(timeSplit[0]);
              final int month = int.parse(timeSplit[1]);
              final int day = int.parse(timeSplit[2]);

              result = DateTime(year, month, day);
            }
          }
        } else {
          // ex data: "2023-12-16"
          if (time.contains('-')) {
            final List<String> timeSplit = time.split('-');

            // ex data: ["2023", "12", "16"]
            if (timeSplit.length == 3) {
              final int year = int.parse(timeSplit[0]);
              final int month = int.parse(timeSplit[1]);
              final int day = int.parse(timeSplit[2]);

              result = DateTime(year, month, day);
            }
          }
        }
      }
      Logger.success('dateTime result: $result');

      return result;
    } catch (error) {
      Logger.error('dateTime error: $error');

      rethrow;
    }
  }

  /// Convert dynamic to double
  ///
  /// Example: "100"
  ///
  /// Return: 100.0
  double? get dynamicToDouble {
    try {
      Logger.info('dynamicToDouble $this type $runtimeType');

      double? result;

      if (this is String) {
        result = double.tryParse(this);
      } else if (this is int) {
        result = (this as int).toDouble();
      } else if (this is double) {
        result = this;
      }

      Logger.success('dynamicToDouble result $result');

      return result;
    } catch (e) {
      Logger.error('dynamicToDouble error $e');

      return null;
    }
  }
}
