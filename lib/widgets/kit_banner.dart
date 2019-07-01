import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/utils/utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class KitBanner extends StatelessWidget {
    const KitBanner(
        {
            @required this.index,
            @required this.onIndexChanged,
            Key key
        })
        : super(key: key);

    final int index;
    final ValueChanged<int> onIndexChanged;

    @override
    Widget build(BuildContext context) {
        return Swiper(
            itemBuilder: _swiperBuilder,
            itemCount: Constants.LIST_SUPPORTED_KITS.length,
            pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    color: Colors.black54,
                    activeColor: MColor.button_normal,
                )),
            control: SwiperControl(),
            scrollDirection: Axis.horizontal,
            autoplay: false,
            index: index,
            onIndexChanged: onIndexChanged,
        );
    }

    Widget _swiperBuilder(BuildContext context, int index) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Image.asset(
                    Utils.image(Constants.LIST_SUPPORTED_KITS[index].toLowerCase()),
                    width: Dimens.width_kit_item,
                    height: Dimens.height_kit_item,
                )
            ],
        );
    }
}
