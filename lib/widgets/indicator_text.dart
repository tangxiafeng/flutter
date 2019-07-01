import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/styles.dart';

class IndicatorText extends StatelessWidget {

    const IndicatorText(
        {
            this.text,
            this.color,
            Key key
        })
        : super(key: key);

    final String text;
    final Color color;

    @override
    Widget build(BuildContext context) {
        return Row(
            children: <Widget>[
                Icon(
                    Icons.fiber_manual_record,
                    color: color,
                    size: Dimens.gap_dp10,
                ),
                Text(
                    text,
                    style: TextStyle(
                        fontSize: Dimens.font_sp12,
                        color: color,
                    ),
                )
            ],
        );
    }
}