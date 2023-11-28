import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_style.dart';

class ErrorInImage extends StatelessWidget {
  final String? error;
  const ErrorInImage({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppStyle.getSize(15),
          vertical: AppStyle.getSize(15),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.error.withOpacity(0.2),
          ),
          color: AppColor.error.withOpacity(0.1),
        ),
        child: error != null
            ? Text(
                error!,
                style: TextStyle(
                  fontSize: AppStyle.getSize(14),
                  color: AppColor.error,
                ),
              )
            : Icon(
                Icons.error_outline,
                size: AppStyle.getSize(40),
                color: AppColor.error,
              ),
      ),
    );
  }
}
