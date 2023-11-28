import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_image.dart';
import 'app_text.dart';

enum Reaction {
  like,
  love,
  care,
  haha,
  wow,
  sad,
  angry,
}

extension ReactionExtension on Reaction {
  String get imagePath {
    switch (this) {
      case Reaction.like:
        return AppImage.like;
      case Reaction.love:
        return AppImage.love;
      case Reaction.care:
        return AppImage.care;
      case Reaction.haha:
        return AppImage.haha;
      case Reaction.wow:
        return AppImage.wow;
      case Reaction.sad:
        return AppImage.sad;
      case Reaction.angry:
        return AppImage.angry;
    }
  }

  String get key {
    switch (this) {
      case Reaction.like:
        return AppText.like;
      case Reaction.love:
        return AppText.love;
      case Reaction.care:
        return AppText.care;
      case Reaction.haha:
        return AppText.haha;
      case Reaction.wow:
        return AppText.wow;
      case Reaction.sad:
        return AppText.sad;
      case Reaction.angry:
        return AppText.angry;
    }
  }

  Color get color {
    switch (this) {
      case Reaction.like:
        return AppColor.primary;
      case Reaction.love:
        return AppColor.error;
      case Reaction.care:
        return AppColor.error;
      case Reaction.haha:
        return AppColor.orange;
      case Reaction.wow:
        return AppColor.orange;
      case Reaction.sad:
        return AppColor.orange;
      case Reaction.angry:
        return AppColor.error;
    }
  }
}
