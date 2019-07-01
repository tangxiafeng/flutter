import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_monster/blocs/application_bloc.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/pages/kit_connector/kit_connector_bloc.dart';
import 'package:flutter_monster/utils/log.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/utils/utils.dart';
import 'package:flutter_monster/widgets/bluetooth_button.dart';
import 'package:flutter_monster/widgets/button.dart';
import 'package:flutter_monster/widgets/close_button.dart';
import 'package:flutter_monster/widgets/flat_button.dart';
import 'package:flutter_monster/widgets/info_button.dart';
import 'package:flutter_monster/widgets/monster_scaffold.dart';

class KitConnectorPage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _KitConnectorPageState();
}

class _KitConnectorPageState extends State<KitConnectorPage>
    with TickerProviderStateMixin {

    ApplicationBloc _appBloc;
    KitConnectorBloc _bloc;

    AnimationController _controller;
    Animation _animation;

    bool _isDialogShowing = false;
    StreamSubscription _closeSubscription;
    StreamSubscription _bleSubscription;

    @override
    void initState() {
        super.initState();
        _appBloc = BlocProvider.of<ApplicationBloc>(context);
        _bloc = BlocProvider.of<KitConnectorBloc>(context);
        _bloc.setAppBloc(_appBloc);
        _closeSubscription = _appBloc.closeController.listen((value) {
            if (value) {
                MonstorNavigator.popPage(context, ret: true);
            }
        });
        _appBloc.checkIsOn();
        _bleSubscription = _appBloc.isBleOnController.listen((on) async {
            if (on) {
                if (_isDialogShowing) {
                    MonstorNavigator.popPage(context);
                }
                _bloc.startScan();
            } else {
                if (!_isDialogShowing) {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildNotOnAlert(context)
                    ).then((value) {
                        _isDialogShowing = false;
                    });
                }
            }
        });

        _controller =
            AnimationController(vsync: this, duration: Duration(seconds: 3));
        _animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.ease,
        ))..addStatusListener(handler);
    }

    @override
    Widget build(BuildContext context) {
        _controller.forward();

        return MonsterScaffold(
            leftButton: MInfoButton(),
            title: _bloc.kit,
            rightWidget: StreamBuilder<bool>(
                stream: _appBloc.outDisconnectState,
                initialData: _bloc.isDisconnected,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                            // snapshot.data ?
                            /*MBluetoothButton(
                                onPressed: () {
                                    _controller.stop();
                                    _bloc.dispose();
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) => _buildBleDevicesDialog(context),
                                    );
                                },
                            ), //: Container(),
                            Gaps.hGap10,*/
                            MCloseButton(ret: !snapshot.data),
                            Gaps.hGap30,
                        ],
                    );
                }),
            child: Column(
                children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Image.asset(
                            Utils.image(_bloc.kit.toLowerCase()),
                            width: Dimens.width_kit_item,
                            height: Dimens.height_kit_item,
                        ),
                    ),
                    Expanded(
                        flex: 0,
                        child: StreamBuilder<int>(
                            stream: _appBloc.outFlashProcess,
                            initialData: _bloc.isDisconnected ? -1 : 100,
                            builder:(BuildContext context, AsyncSnapshot<int> snapshot) {
                                if (snapshot.data == -1) {
                                    return _buildUnconnectedWidget();
                                } else {
                                    return _buildConnectedWidget(snapshot.data);
                                }
                            })
                    )],
                ),
            );
    }

    Widget _buildUnconnectedWidget() {
        return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
                AnimatedBuilder(
                    animation: _controller,
                    builder: (BuildContext context, Widget child) {
                        return Transform(
                            transform:
                            Matrix4.translationValues(0.0, _animation.value * 220, 0.0),
                            child: Image.asset(
                                Utils.image('animation'),
                                width: 344,
                                height: 220,
                            ),
                        );
                    }),
                Text(S.of(context).closer,
                    style: TextStyles.flatButtonContent),
            ],
        );
    }

    Widget _buildConnectedWidget(int process) {
        String text;
        if (process == 0) {
            text = S.of(context).start;
        } else if (process == 100) {
            text = S.of(context).program;
        } else {
            text = S.of(context).flashing(process.toString());
        }
        return Container(
            padding: EdgeInsets.fromLTRB(
                Dimens.gap_dp30, 0,
                Dimens.gap_dp30, Dimens.gap_dp100),
            child: Column(
                children: <Widget>[
                    MButton(
                        text: text,
                        onPressed: () {
                            if (process == 100) {
                                MonstorNavigator.popPage(context, ret: true);
                            }
                        },
                    ),
                    MFlatButton(
                        text: S.of(context).disconnect,
                        style: TextStyles.flatButtonContent,
                        onPressed: () {
                            _appBloc.handleDisconnect();
                            _bloc.handleDisconnect();
                        },
                    )],
            ));
    }

    void handler(status) {
        if (status == AnimationStatus.completed) {
            _animation.removeStatusListener(handler);
            _controller.reset();
            _animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.ease,
            ))..addStatusListener((status) {

            });
            _controller.repeat();
        }
    }

    Widget _buildNotOnAlert(BuildContext context) {
        _isDialogShowing = true;
        return AlertDialog(
            content: Text(
                S.of(context).bluetoothNotOn,
                style: TextStyles.mainBlackContent,
            ),
            actions: <Widget>[
                MFlatButton(
                    text: S.of(context).okay,
                    style: TextStyles.flatButtonContent,
                    onPressed: () {
                        MonstorNavigator.popPage(context);
                    },
                )],
        );
    }

    Widget _buildBleDevicesDialog(BuildContext context) {
        return AlertDialog(
            title: Row(
                children: <Widget> [
                    Expanded(
                        flex: 1,
                        child: Text(
                            S.of(context).chooseDevice,
                            style: TextStyles.mainBlackContent,
                        )
                    ),
                    Expanded(
                        flex: 0,
                        child: MCloseButton(),
                    ),
                ]
            ),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    // _buildInfoText(context),
                ],
            ),

            actions: <Widget>[
                MFlatButton(
                    text: S.of(context).okay,
                    style: TextStyles.flatButtonContent,
                    onPressed: () {
                        MonstorNavigator.popPage(context);
                    },
                )],
        );
    }

    @override
    void dispose() {
        _controller.dispose();
        _closeSubscription.cancel();
        _bleSubscription.cancel();
        super.dispose();
    }
}
