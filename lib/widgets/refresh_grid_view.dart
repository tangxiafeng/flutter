import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/widgets/navigation_bar.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class RefreshGridView extends StatelessWidget {
    const RefreshGridView(
        {
            this.onRefresh,
            this.loadMore,
            this.headerKey,
            this.footerKey,
            this.children,
            Key key
        })
        : super(key: key);

    final OnRefresh onRefresh;
    final LoadMore loadMore;
    final GlobalKey<RefreshHeaderState> headerKey;
    final GlobalKey<RefreshFooterState> footerKey;
    final List<Widget> children;

    @override
    Widget build(BuildContext context) {
        return EasyRefresh(
            refreshHeader: ClassicsHeader(
                key: headerKey,
                refreshText: S.of(context).pullToRefresh,
                refreshReadyText: S.of(context).releaseToRefresh,
                refreshingText: S.of(context).refreshing,
                refreshedText: S.of(context).refreshed,
                moreInfo: S.of(context).updateAt,
                bgColor: Colors.transparent,
                textColor: MColor.text_gray,
                moreInfoColor: MColor.text_gray,
                showMore: true,
            ),
            refreshFooter: ClassicsFooter(
                key: footerKey,
                loadText: S.of(context).pushToLoad,
                loadReadyText: S.of(context).releaseToLoad,
                loadingText: S.of(context).loading,
                loadedText: S.of(context).loaded,
                noMoreText: S.of(context).noMore,
                moreInfo: S.of(context).updateAt,
                bgColor: Colors.transparent,
                textColor: MColor.text_gray,
                moreInfoColor: MColor.text_gray,
                showMore: true,
            ),
            onRefresh: this.onRefresh,
            loadMore: this.loadMore,
            child: GridView.count(
                crossAxisCount: Constants.GRID_AXIS_COUNT,
                crossAxisSpacing: Dimens.gap_dp40,
                mainAxisSpacing: Dimens.gap_dp40,
                padding: EdgeInsets.only(
                    left: Dimens.gap_dp30,
                    right: Dimens.gap_dp30,
                    top: Dimens.gap_dp10,
                ),
                children: this.children,
            ),
        );
    }
}
