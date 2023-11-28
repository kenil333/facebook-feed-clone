import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_color.dart';
import 'app_enum.dart';
import 'app_text.dart';

class AppMethod {
  static final DateTime now = DateTime.now();
  static void pushRoute(
    BuildContext context, {
    required String route,
    dynamic argument,
  }) =>
      Navigator.of(context).pushNamed(route, arguments: argument);

  static void pushAndRemoveAllRoute(
    BuildContext context, {
    required String route,
    dynamic argument,
    String? untilRoute,
    bool first = false,
  }) =>
      Navigator.of(context).pushNamedAndRemoveUntil(
        route,
        untilRoute != null
            ? ModalRoute.withName(untilRoute)
            : (route) => first ? route.isFirst : false,
        arguments: argument,
      );

  static String displayTime(DateTime date) {
    if (date.month == now.month &&
        date.year == now.year &&
        date.day == now.day) {
      return "${AppText.todayAt} ${DateFormat("hh:mm a").format(date)}";
    } else if (date.month == now.month &&
        date.year == now.year &&
        date.day == (now.subtract(const Duration(days: 1))).day) {
      return "${AppText.yesterdayAt} ${DateFormat("hh:mm a").format(date)}";
    } else {
      return "${DateFormat("dd MMM, yyyy").format(date)} ${AppText.at} ${DateFormat("hh:mm a").format(date)}";
    }
  }

  static Reaction getTheReaction(String type) {
    if (type == Reaction.like.key) {
      return Reaction.like;
    } else if (type == Reaction.love.key) {
      return Reaction.love;
    } else if (type == Reaction.care.key) {
      return Reaction.care;
    } else if (type == Reaction.haha.key) {
      return Reaction.haha;
    } else if (type == Reaction.wow.key) {
      return Reaction.wow;
    } else if (type == Reaction.sad.key) {
      return Reaction.sad;
    } else {
      return Reaction.angry;
    }
  }

  static openBottomSheet(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      // isDismissible: false,
      // enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      backgroundColor: AppColor.white,
      builder: (context) => widget,
    );
  }
}
