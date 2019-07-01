import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/utils.dart';

class ProjectImage extends StatelessWidget {

    const ProjectImage(
        {
            this.url,
            Key key
        })
        : super(key: key);

    final String url;

    @override
    Widget build(BuildContext context) {
        return CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: url ?? '',
            placeholder: (context, url) => Image.asset(Utils.image('logo')),
            errorWidget: (context, url, error) => Image.asset(Utils.image('logo')),
        );
    }

}