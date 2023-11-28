import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_style.dart';
import '../../utils/app_text.dart';
import 'profile_detail_widget.dart';

class MyProfileWidget extends StatelessWidget {
  const MyProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppStyle.getSize(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppStyle.getSize(15)),
          Text(
            AppText.contactDetails,
            style: TextStyle(
              fontSize: AppStyle.getSize(14),
              color: AppColor.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: AppStyle.getSize(10)),
          const ProfileDetailWidget(
            title: AppText.phoneNo,
            value: "+1  |  9999999999",
          ),
          const ProfileDetailWidget(
            title: AppText.emailID,
            value: "abcd@gmail.com",
          ),
          const ProfileDetailWidget(
            title: AppText.dateOfBirth,
            value: "20-01-1998",
          ),
          const ProfileDetailWidget(
            title: AppText.gender,
            value: "22",
          ),
          Row(
            children: [
              const Expanded(
                child: ProfileDetailWidget(
                  title: AppText.height,
                  value: "0 ${AppText.cm}",
                ),
              ),
              SizedBox(width: AppStyle.getSize(15)),
              const Expanded(
                child: ProfileDetailWidget(
                  title: AppText.weight,
                  value: "0 ${AppText.kgs}",
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: AppStyle.getSize(12)),
            decoration: BoxDecoration(
              color: AppColor.boxBackground,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: AppStyle.getSize(16),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.primary.withOpacity(0.2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppText.langugaes,
                          style: TextStyle(
                            fontSize: AppStyle.getSize(14),
                            color: AppColor.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) => Row(
                    children: [
                      SizedBox(width: AppStyle.getSize(16)),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: AppStyle.getSize(15)),
                          decoration: BoxDecoration(
                            border: index != 2
                                ? const Border(
                                    bottom: BorderSide(
                                      color: AppColor.devider,
                                      width: 1,
                                    ),
                                  )
                                : null,
                          ),
                          child: Text(
                            "English",
                            style: TextStyle(
                              fontSize: AppStyle.getSize(14),
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height:
                MediaQuery.of(context).padding.bottom + AppStyle.getSize(100),
          ),
        ],
      ),
    );
  }
}
