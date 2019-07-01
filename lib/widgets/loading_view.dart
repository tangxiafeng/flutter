import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/styles.dart';

class LoadingView extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return Center(
            child: SizedBox(
                width: Dimens.width_loading,
                height: Dimens.height_loading,
                child: new CircularProgressIndicator(
                    strokeWidth: 2.0,
                ),
            ),
        );
    }
}