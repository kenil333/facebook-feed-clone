import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_image.dart';
import '../../utils/app_style.dart';
import '../../utils/app_text.dart';

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppStyle.getSize(150)),
        Image.asset(
          AppImage.appLogo,
          width: AppStyle.getSize(100),
        ),
        SizedBox(height: AppStyle.getSize(25)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppStyle.getSize(32),
          ),
          child: Text(
            AppText.emptyNote,
            style: TextStyle(
              fontSize: AppStyle.getSize(16),
              color: AppColor.black.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
