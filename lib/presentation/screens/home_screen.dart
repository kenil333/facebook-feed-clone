import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/feed_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_image.dart';
import '../../utils/app_method.dart';
import '../../utils/app_style.dart';
import '../../utils/app_text.dart';
import '../../utils/route_text.dart';
import '../provider/app_provider.dart';
import '../widgets/exit_dialog.dart';
import '../widgets/feed_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppProvider provider =
        Provider.of<AppProvider>(context, listen: false);
    provider.addListnerToFeedScroll();
    return PopScope(
      canPop: false,
      onPopInvoked: (bool value) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const ExitDialog(),
        );
      },
      child: Scaffold(
        backgroundColor: AppColor.devider,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: AppStyle.topPadding + AppStyle.getSize(8),
                bottom: AppStyle.getSize(8),
                left: AppStyle.getSize(15),
                right: AppStyle.getSize(15),
              ),
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border(
                  bottom: BorderSide(color: AppColor.black.withOpacity(0.1)),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    AppText.appName,
                    style: TextStyle(
                      fontSize: AppStyle.getSize(28),
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      AppMethod.pushRoute(context, route: RouteText.createPost);
                    },
                    child: Icon(
                      Icons.add_circle_rounded,
                      color: AppColor.black,
                      size: AppStyle.getSize(26),
                    ),
                  ),
                  SizedBox(width: AppStyle.getSize(15)),
                  GestureDetector(
                    onTap: () {
                      AppMethod.pushRoute(context, route: RouteText.profile);
                    },
                    child: Icon(
                      Icons.person,
                      color: AppColor.black,
                      size: AppStyle.getSize(26),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Selector<AppProvider, List<FeedModel>>(
                builder: (context, feeds, child) => feeds.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: () async {
                          await provider.getFeeds();
                        },
                        color: AppColor.primary,
                        child: ListView.builder(
                          controller: provider.feedsScroll,
                          padding:
                              EdgeInsets.only(bottom: AppStyle.bottomPadding),
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: ClampingScrollPhysics(),
                          ),
                          itemCount: feeds.length,
                          itemBuilder: (context, i) => FeedItem(
                            model: feeds[i],
                            feedIndex: i,
                          ),
                        ),
                      )
                    : Container(
                        color: AppColor.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                        ),
                      ),
                selector: (context, cp) => cp.feeds,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
