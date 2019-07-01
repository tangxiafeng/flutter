import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/models/page_view_title.dart';


class MyPageView extends StatefulWidget {
    MyPageView({
      Key key,
	  @required this.tabList,
	  @required this.sink,
    }): super(key: key);

    final List<TabTitle> tabList;
    final Sink<String> sink;
    @override
	State<StatefulWidget> createState() => PageViewState();

}

class PageViewState extends State<MyPageView> with SingleTickerProviderStateMixin {
	TabController mTabController;
	PageController mPageController = PageController(initialPage: 0);

	@override
	void initState() {
		super.initState();
		if (Platform.isAndroid) {
		    //  以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
            SystemUiOverlayStyle systemUiOverlayStyle =
            SystemUiOverlayStyle(statusBarColor: Colors.transparent);
            SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
        }
		mTabController = TabController(
			length: widget.tabList.length,
			vsync: this,
		);
		mTabController.addListener(() {//TabBar的监听
			if (mTabController.indexIsChanging) {//判断TabBar是否切换
				onPageChange(mTabController.index, p: mPageController);
			}
		});
	}

	onPageChange(int index, {PageController p, TabController t}) async {
	    widget.sink.add(widget.tabList[index].sinkStr);
	}

	@override
	void dispose() {
		super.dispose();
		mTabController.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Container(
			height: 38.0,
			child: TabBar(
				isScrollable: true,
				//是否可以滚动
				controller: mTabController,
				labelColor: MColor.button_normal,
				unselectedLabelColor: MColor.text_gray,
				labelStyle: TextStyle(fontSize: Dimens.font_sp20),
				tabs: widget.tabList.map((item) {
					return Tab(
						text: item.title,
					);
				}).toList(),
			),
		);
	}
}