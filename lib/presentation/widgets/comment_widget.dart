import 'package:flutter/material.dart';

import '../../data/model/feed_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_image.dart';
import '../../utils/app_method.dart';
import '../../utils/app_style.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel model;
  const CommentWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            AppImage.appLogo,
            width: AppStyle.getSize(40),
            height: AppStyle.getSize(40),
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: AppStyle.getSize(15)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  minWidth: AppStyle.getSize(100),
                  maxWidth: AppStyle.size.width - (AppStyle.getSize(85)),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: AppStyle.getSize(15),
                  vertical: AppStyle.getSize(8),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.commentBackground,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.userName,
                      style: TextStyle(
                        fontSize: AppStyle.getSize(14),
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppStyle.getSize(2)),
                    Text(
                      model.comment,
                      style: TextStyle(
                        fontSize: AppStyle.getSize(14),
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppStyle.getSize(5)),
              Padding(
                padding: EdgeInsets.only(left: AppStyle.getSize(15)),
                child: Text(
                  AppMethod.displayTime(
                    DateTime.fromMillisecondsSinceEpoch(model.timestemp),
                  ),
                  style: TextStyle(
                    fontSize: AppStyle.getSize(11),
                    color: AppColor.black.withOpacity(0.4),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: AppStyle.getSize(15)),
            ],
          ),
        ),
      ],
    );
  }
}
