import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_color.dart';
import '../../utils/app_style.dart';
import '../../utils/app_text.dart';
import 'app_button.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      insetPadding: EdgeInsets.symmetric(horizontal: AppStyle.getSize(45)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)), //this right here
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppStyle.getSize(20),
                vertical: AppStyle.getSize(15)),
            child: Center(
              child: Text(
                AppText.exit,
                style: TextStyle(
                  fontSize: AppStyle.getSize(18),
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColor.devider.withOpacity(0.5),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppStyle.getSize(20),
                vertical: AppStyle.getSize(15)),
            child: Center(
              child: Text(
                AppText.exitText,
                style: TextStyle(
                  fontSize: AppStyle.getSize(16),
                  color: AppColor.black.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppStyle.getSize(30),
              vertical: AppStyle.getSize(5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: AppText.cancel,
                    verticalPadding: AppStyle.getSize(10),
                    textStyle: TextStyle(
                      fontSize: AppStyle.getSize(14),
                      color: AppColor.white,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  width: AppStyle.getSize(20),
                ),
                Expanded(
                  child: AppButton(
                    title: AppText.yes,
                    color: AppColor.error,
                    textStyle: TextStyle(
                      fontSize: AppStyle.getSize(14),
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                    verticalPadding: AppStyle.getSize(10),
                    onTap: () {
                      Navigator.pop(context);
                      SystemNavigator.pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppStyle.getSize(15),
          ),
        ],
      ),
    );
  }
}
