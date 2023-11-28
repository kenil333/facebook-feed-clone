import 'package:flutter/material.dart';

import '../../utils/app_style.dart';

class FeedBtn extends StatelessWidget {
  final String title;
  final String imgPath;
  final Color? imgColor;
  final Color? titleColor;
  final Function onPress;
  final Alignment alignment;
  final Function? onLongPress;
  const FeedBtn({
    super.key,
    required this.title,
    required this.imgPath,
    this.imgColor,
    this.titleColor,
    required this.onPress,
    required this.alignment,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          if (alignment == Alignment.center ||
              alignment == Alignment.centerRight)
            Expanded(child: Container()),
          GestureDetector(
            onTap: () {
              onPress();
            },
            onLongPress: () {
              if (onLongPress != null) {
                onLongPress!();
              }
            },
            child: Row(
              children: [
                Image.asset(
                  imgPath,
                  width: AppStyle.getSize(20),
                  height: AppStyle.getSize(20),
                  fit: BoxFit.contain,
                  color: imgColor,
                ),
                SizedBox(width: AppStyle.getSize(8)),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppStyle.getSize(12),
                    color: titleColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (alignment == Alignment.center ||
              alignment == Alignment.centerLeft)
            Expanded(child: Container()),
        ],
      ),
    );
  }
}
