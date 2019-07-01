import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/local_storage.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/utils/utils.dart';

class KitImage extends StatelessWidget {

    const KitImage(
        {
            this.width,
            this.height,
            Key key
        })
        : super(key: key);

    final double width;
    final double height;

    @override
    Widget build(BuildContext context) {
        return ClipOval(
            child: CachedNetworkImage(
                width: width ?? Dimens.width_nav_button,
                height: height ?? Dimens.height_nav_button,
                imageUrl: LocalStorage.getString(Constants.KEY_AVATAR),
                placeholder: (context, url) => Image.asset(Utils.image('avatar')),
                errorWidget: (context, url, error) => Image.asset(Utils.image('avatar')),
            ));
    }

}