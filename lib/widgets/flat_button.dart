import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/styles.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class MFlatButton extends StatelessWidget {
    const MFlatButton(
        {
            this.text,
            this.style,
            @required this.onPressed,
            Key key
        })
        : super(key: key);

    final String text;
    final TextStyle style;
    final VoidCallback onPressed;

    @override
    Widget build(BuildContext context) {
        return FlatButton(
            child: Text(
                text,
                style: style?? TextStyles.blackContent,
            ),
            onPressed: onPressed,
        );
    }
}
