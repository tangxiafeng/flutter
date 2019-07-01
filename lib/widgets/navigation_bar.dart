import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/styles.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class NavigationBar extends StatelessWidget {
    const NavigationBar(
        {
            this.leftButton,
            this.title,
            this.titleWidget,
            this.rightButton,
            this.rightWidget,
            Key key
        }) : super(key: key);

    final Widget leftButton;
    final String title;
    final Widget titleWidget;
    final Widget rightButton;
    final Widget rightWidget;

    @override
    Widget build(BuildContext context) {
        return Container(
            color: Colors.white,
            height: Dimens.height_Navigation,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                                Gaps.hGap30,
                                leftButton ?? Container(),
                            ]
                        ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                title == null ? titleWidget :
                                Text(
                                    title,
                                    style: TextStyles.titleContent,
                                ),
                            ]
                        ),
                    ),
                    Expanded(
                        flex: 1,
                        child: rightWidget ?? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                                rightButton ?? Container(),
                                Gaps.hGap30,
                            ]
                        ),
                    ),
                ],
            ),
        );
    }
}
