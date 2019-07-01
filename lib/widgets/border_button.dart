import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/styles.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class MBorderButton extends StatelessWidget {
    const MBorderButton(
        {
            this.isSelected,
            this.text,
            this.color,
            @required this.onPressed,
            Key key
        })
        : super(key: key);

    final bool isSelected;
    final String text;
    final Color color;
    final VoidCallback onPressed;

    @override
    Widget build(BuildContext context) {
        return Container(
            width: Dimens.width_border_button,
            height: Dimens.height_border_button,
            child: OutlineButton(
                child: Text(
                    text,
                    style: isSelected ? TextStyles.flatButtonContent : TextStyles.hintContent,
                ),
                color: color ?? MColor.app_main,
                splashColor: MColor.app_main,
                highlightColor: MColor.app_main,
                highlightElevation: 0,
                borderSide: BorderSide(
                    color: isSelected ? MColor.button_normal : MColor.text_gray,
                    width: 1,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                ),
                onPressed: onPressed,
            ),
        );
    }
}
