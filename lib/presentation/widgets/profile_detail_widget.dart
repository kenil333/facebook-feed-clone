import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_color.dart';
import '../../utils/app_style.dart';

class ProfileDetailWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool showCopy;
  const ProfileDetailWidget({
    super.key,
    required this.title,
    required this.value,
    this.showCopy = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppStyle.getSize(16),
        vertical: 12,
      ),
      margin: EdgeInsets.only(bottom: AppStyle.getSize(12)),
      decoration: BoxDecoration(
        color: AppColor.boxBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppStyle.getSize(12),
                    color: AppColor.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: AppStyle.getSize(5)),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: AppStyle.getSize(14),
                    color: AppColor.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (showCopy)
            InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: value));
              },
              child: Icon(
                Icons.copy_rounded,
                size: AppStyle.getSize(24),
                color: AppColor.black,
              ),
            ),
        ],
      ),
    );
  }
}
