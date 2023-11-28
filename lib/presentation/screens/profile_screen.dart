import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_image.dart';
import '../../utils/app_style.dart';
import '../../utils/app_text.dart';
import '../widgets/my_profile_widget.dart';
import '../widgets/timeline_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  void dispose() {
    selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppText.profile,
          style: TextStyle(
            color: AppColor.black,
            fontWeight: FontWeight.w500,
            fontSize: AppStyle.getSize(16),
          ),
        ),
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              // controller: controller.scrollController,
              slivers: [
                SliverAppBar(
                  snap: false,
                  pinned: true,
                  floating: true,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Stack(
                    fit: StackFit.expand,
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppStyle.getSize(15)),
                          child: Column(
                            children: [
                              SizedBox(height: AppStyle.getSize(15)),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      AppImage.appLogo,
                                      fit: BoxFit.cover,
                                      width: AppStyle.getSize(80),
                                      height: AppStyle.getSize(80),
                                    ),
                                  ),
                                  SizedBox(width: AppStyle.getSize(15)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Crazzy Skull",
                                          style: TextStyle(
                                            fontSize: AppStyle.getSize(16),
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "22 / Male",
                                          style: TextStyle(
                                            fontSize: AppStyle.getSize(12),
                                            color:
                                                AppColor.black.withOpacity(0.6),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppStyle.getSize(15)),
                              Row(
                                children: [
                                  SizedBox(
                                    width: AppStyle.getSize(80),
                                    child: Row(
                                      children: [
                                        Expanded(child: Container()),
                                        InkWell(
                                          onTap: () {},
                                          child: Text(
                                            AppText.editProfile,
                                            style: TextStyle(
                                              fontSize: AppStyle.getSize(12),
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.primary,
                                            ),
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                ],
                              ),
                              // SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Expanded(child: Container()),
                          Container(
                            color: AppColor.white,
                            child: Column(
                              children: [
                                ValueListenableBuilder<int>(
                                  valueListenable: selectedIndex,
                                  builder: (context, tabIndex, child) =>
                                      Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppStyle.getSize(15)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 40,
                                          padding: EdgeInsets.all(
                                              AppStyle.getSize(3)),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColor.devider
                                                .withOpacity(0.5),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    selectedIndex.value = 0;
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 37,
                                                    decoration: tabIndex == 0
                                                        ? BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color:
                                                                AppColor.white,
                                                          )
                                                        : null,
                                                    child: Center(
                                                      child: Text(
                                                        AppText.myProfile,
                                                        style: TextStyle(
                                                          fontSize:
                                                              AppStyle.getSize(
                                                                  14),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColor.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    selectedIndex.value = 1;
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 37,
                                                    decoration: tabIndex == 1
                                                        ? BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color:
                                                                AppColor.white,
                                                          )
                                                        : null,
                                                    child: Center(
                                                      child: Text(
                                                        AppText.timeline,
                                                        style: TextStyle(
                                                          fontSize:
                                                              AppStyle.getSize(
                                                                  14),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColor.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: AppStyle.getSize(5)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  expandedHeight: 16 +
                      AppStyle.getSize(80) +
                      10 +
                      AppStyle.getSize(16) +
                      16 +
                      50,
                  toolbarHeight: 50,
                  backgroundColor: AppColor.white,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ValueListenableBuilder(
                        valueListenable: selectedIndex,
                        builder: (context, tabIndex, child) => Container(
                          color: AppColor.white,
                          child: tabIndex == 0
                              ? const MyProfileWidget()
                              : const TimelineWidget(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
