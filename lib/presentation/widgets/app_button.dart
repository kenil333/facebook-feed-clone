import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_style.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final Color color;
  final double? verticalPadding;
  final TextStyle? textStyle;

  const AppButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.color = AppColor.primary,
    this.verticalPadding,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 0,
        backgroundColor: color,
        foregroundColor: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onPressed: () async {
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: AppStyle.getSize(
            verticalPadding ?? 15,
          ),
        ),
        alignment: Alignment.center,
        child: Center(
          child: Text(
            title,
            style: textStyle ??
                TextStyle(
                  fontSize: AppStyle.getSize(14),
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
          ),
        ),
      ),
    );
  }
}
