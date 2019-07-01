import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/pages/splash/splash_bloc.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/utils/utils.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class SplashPage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

    @override
    void initState() {
        super.initState();
        Future.delayed(Duration(milliseconds: 500), () => 500)
            .then((value) {
                SplashBloc _bloc = BlocProvider.of<SplashBloc>(context);
                if (_bloc.isLogin()) {
                    MonstorNavigator.gotoProjectsList(context);
                } else {
                    MonstorNavigator.gotoWelcome(context);
                }
        });
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            // child: Image.asset(Utils.image('loading')),
        );
    }

}