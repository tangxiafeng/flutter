import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/styles.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class MButton extends StatelessWidget {
    const MButton(
        {
            this.text,
            this.color,
            @required this.onPressed,
            Key key
        })
        : super(key: key);

    final String text;
    final Color color;
    final VoidCallback onPressed;

    @override
    Widget build(BuildContext context) {
        return Container(
            width: Dimens.width_button,
            height: Dimens.height_button,
            child: CupertinoButton(
                child: Text(
                    text,
                    style: TextStyles.mainContent,
                ),
                color: color ?? MColor.button_normal,
                disabledColor: MColor.button_disabled,
                pressedOpacity: 0.8,
                onPressed: onPressed,
            ),
        );
    }
}
