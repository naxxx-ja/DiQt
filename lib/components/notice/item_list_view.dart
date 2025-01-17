import 'package:booqs_mobile/data/remote/notifications.dart';
import 'package:booqs_mobile/models/achievement_map.dart';
import 'package:booqs_mobile/models/notice.dart';
import 'package:booqs_mobile/utils/dialogs.dart';
import 'package:booqs_mobile/components/notice/list_item.dart';
import 'package:booqs_mobile/components/notice/unreceived_achievement.dart';
import 'package:booqs_mobile/components/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:visibility_detector/visibility_detector.dart';

// infinite-scrollを利用した通知一覧 ref: https://pub.dev/packages/infinite_scroll_pagination
class NoticeItemListView extends StatefulWidget {
  const NoticeItemListView({Key? key}) : super(key: key);

  @override
  State<NoticeItemListView> createState() => _NoticeItemListViewState();
}

class _NoticeItemListViewState extends State<NoticeItemListView> {
  bool _isLoading = false;
  bool _isReached = true;

  int _nextPagekey = 0;
  // 一度に読み込むアイテム数
  static const _pageSize = 10;
  final PagingController<int, Notice> _pagingController =
      PagingController(firstPageKey: 0); // pageのパラメーターの初期値
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  // 未受領の実績メダルをモーダル表示
  void _displayUnreceivedAchievement(Map resMap) {
    final achievementMapJson = resMap['achievement_map'];
    if (achievementMapJson == null) return;
    final AchievementMap map = AchievementMap.fromJson(achievementMapJson);
    final screen = NoticeUnreceivedAchievement(achievementMap: map);
    Dialogs.reward(screen);
  }

  // ページに合わせてアイテムを読み込む
  Future<void> _fetchPage(int pageKey) async {
    if (_isLoading) return;
    if (_isReached == false) return;
    _isLoading = true;

    final Map? resMap = await RemoteNotifications.index(pageKey, _pageSize);
    // ref: https://github.com/EdsonBueno/infinite_scroll_pagination/issues/64
    if (!mounted) return;

    if (resMap == null) {
      return setState(() {
        _isLoading = false;
        _isReached = false;
      });
    }
    final List<Notice> notices = [];
    resMap['notifications'].forEach((e) => notices.add(Notice.fromJson(e)));
    // 未受領の実績メダルをモーダル表示
    _displayUnreceivedAchievement(resMap);
    final isLastPage = notices.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(notices);
    } else {
      _nextPagekey = pageKey + notices.length;
      //_pagingController.appendLastPage(notices);
      // pageKeyにnullを渡すことで、addPageRequestListener の発火を防ぎ、自動で次のアイテムを読み込まないようにする。
      _pagingController.appendPage(notices, _nextPagekey);
    }
    setState(() {
      _isReached = false;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    Widget loader() {
      // ref: https://qiita.com/kikuchy/items/07d10394a4f7aa2a3836
      return VisibilityDetector(
        key: const Key("for detect visibility"),
        onVisibilityChanged: (info) {
          // [visibleFraction] 0で非表示、１で完全表示。0.1は上部が少し表示されている状態 ref: https://pub.dev/documentation/visibility_detector/latest/visibility_detector/VisibilityInfo/visibleFraction.html
          if (info.visibleFraction > 0.1) {
            if (_isLoading) return;
            setState(() {
              _isReached = true;
            });
            // 最下部までスクロールしたら、次のアイテムを読み込む ref: https://pub.dev/documentation/infinite_scroll_pagination/latest/infinite_scroll_pagination/PagingController/notifyPageRequestListeners.html
            _pagingController.notifyPageRequestListeners(_nextPagekey);
          }
        },
        child: Container(
          padding: const EdgeInsets.only(bottom: 100),
          child: const LoadingSpinner(),
        ),
      );
    }

    return PagedListView<int, Notice>(
      pagingController: _pagingController,
      // Vertical viewport was given unbounded heightの解決 ref: https://qiita.com/code-cutlass/items/3a8b759056db1e8f7639
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      builderDelegate: PagedChildBuilderDelegate<Notice>(
        itemBuilder: (context, item, index) => NoticeListItem(
          notice: item,
        ),
        // 最下部のローディング ref: https://pub.dev/documentation/infinite_scroll_pagination/latest/infinite_scroll_pagination/PagedChildBuilderDelegate-class.html
        newPageProgressIndicatorBuilder: (_) => loader(),
      ),
    );
  }
}
