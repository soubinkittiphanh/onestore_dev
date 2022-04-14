import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function showDate;
  final String dateFromOrTo;
  const AdaptiveButton(
      {Key? key,
      required this.text,
      required this.showDate,
      required this.dateFromOrTo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? IconButton(
            icon: const Icon(
              Icons.calendar_today,
              color: Colors.pink,
            ),
            onPressed: () {
              showDate(dateFromOrTo);
            },
          )
        : IconButton(
            icon: const Icon(
              Icons.calendar_today,
              color: Colors.pink,
            ),
            onPressed: () {
              log("Android");
              showDate(dateFromOrTo);
            },
          );
  }
}
