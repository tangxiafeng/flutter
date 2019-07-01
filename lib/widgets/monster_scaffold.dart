import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/widgets/navigation_bar.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class MonsterScaffold extends StatelessWidget {
    const MonsterScaffold(
        {
            this.leftButton,
            this.title,
            this.titleWidget,
            this.rightButton,
            this.rightWidget,
            this.child,
            Key key
        })
        : super(key: key);

    final Widget leftButton;
    final String title;
    final Widget titleWidget;
    final Widget rightButton;
    final Widget rightWidget;
    final Widget child;

    @override
    Widget build(BuildContext context) {
        return Material(
            child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Column(
                children: <Widget>[
                    NavigationBar(
                        leftButton: leftButton,
                        title: title,
                        titleWidget: titleWidget,
                        rightButton: rightButton,
                        rightWidget: rightWidget,
                    ),
                    Expanded(
                        flex: 1,
                        child: child,
                    ),
                ])
            )
        );
    }
}
