import 'package:flutter/material.dart';

extension TimeFormat on DateTime {
  String format(BuildContext context) {
    return TimeOfDay(hour: hour, minute: minute).format(context);
  }
}
