import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/blocs/application_bloc.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/models/project.dart';
import 'package:flutter_monster/pages/projects_list/projects_list_bloc.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/log.dart';
import 'package:flutter_monster/utils/monstor_navigator.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/utils/toast.dart';
import 'package:flutter_monster/utils/utils.dart';
import 'package:flutter_monster/widgets/avatar_image.dart';
import 'package:flutter_monster/widgets/flat_button.dart';
import 'package:flutter_monster/widgets/loading_view.dart';
import 'package:flutter_monster/widgets/monster_scaffold.dart';
import 'package:flutter_monster/widgets/project_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_monster/widgets/refresh_grid_view.dart';
import 'package:flutter_monster/widgets/text_field.dart';

class ProjectsListPage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _ProjectsListPageState();
}

class _ProjectsListPageState extends State<ProjectsListPage> {

    GlobalKey<RefreshHeaderState> _headerKey;
    GlobalKey<RefreshFooterState> _footerKey;

    ProjectsListBloc _bloc;

    @override
    void initState() {
        super.initState();
        _headerKey = GlobalKey<RefreshHeaderState>();
        _footerKey = GlobalKey<RefreshFooterState>();
        _bloc = BlocProvider.of<ProjectsListBloc>(context);
        _bloc.goNextController.listen((kitData) {
            if (kitData[1] == null || kitData[1] == Constants.CONNECT_STATE_DISCONNECT) {
                MonstorNavigator.gotoKitChoosePage(context, kitData[0])
                    .then((value) {
                        _bloc.showWebview();
                    });
            } else {
                MonstorNavigator.gotoKitConnect(context, kitData[0],
                    state: Constants.CONNECT_STATE_READY,
                    device: _bloc.getConnectedDevice())
                    .then((value) {
                        _bloc.showWebview();
                    });
            }
        });
        _bloc.alertController.listen((data) {
            if (data) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => _buildAlertDialog(context)
                );
            }
        });

    }

    @override
    Widget build(BuildContext context) {
        return MonsterScaffold(
            leftButton: IconButton(
                icon: AvatarImage(
                    width: Dimens.width_nav_button,
                    height: Dimens.height_nav_button),
                onPressed: () {
                    MonstorNavigator.gotoProfile(context);
                }),
            title: S.of(context).projects,
            rightButton: IconButton(
                icon: Image.asset(
                    Utils.image('settings'),
                    width: Dimens.width_nav_button,
                    height: Dimens.height_nav_button,
                ),
                onPressed: () {
                    MonstorNavigator.gotoSettings(context);
                }),
            child: StreamBuilder<List<Project>>(
                stream: _bloc.outLoadData,
                builder:(BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
                    if (snapshot.data != null) {
                        // bool _loadMore = snapshot.data.length == Constants.PAGE_LIMIT;
                        return RefreshGridView(
                            headerKey: _headerKey,
                            footerKey: _footerKey,
                            onRefresh: () {
                                _bloc.onRefresh();
                            },
                            loadMore: () {
                                _bloc.onLoadMore();
                            },
                            children: _bloc.projectsList.map((project) {
                                return ProjectItem(
                                    project: project,
                                    onTap: () {
                                        _bloc.loadProject(project.id, project.title);
                                    },
                                    onSelected: (value) {
                                        if (value == Constants.MENU_ITEM_EDIT) {
                                            _handleEdit(context, project.id);
                                        } else if (value == Constants.MENU_ITEM_DELETE) {
                                            _handleDelete(context, project.id);
                                        }
                                    },
                                );}).toList(),
                        );
                    } else {
                        return LoadingView();
                    }
                }
            )
        );
    }

    _handleEdit(BuildContext context, String id) {
        TextEditingController _controller = TextEditingController();
        showDialog(
            context: context,
            builder: (BuildContext context) {
                return AlertDialog(
                    content: MTextField(
                        controller: _controller,
                        hint: S.of(context).newProjectName,
                    ),
                    actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                                _bloc.renameProject(id, _controller.value.text)
                                    .then((value) {
                                        _bloc.onRefresh();
                                    })
                                    .catchError((error) {
                                        Toast.show(S.of(context).serverError);
                                    });
                                Navigator.of(context).pop();
                            },
                            child: Text(S.of(context).ok),
                        ),
                        FlatButton(
                            onPressed: () {Navigator.of(context).pop();},
                            child: Text(S.of(context).cancel),
                        ),
                    ],
                );
            }
        );
    }

    _handleDelete(BuildContext context, String id) {
        _bloc.deleteProject(id)
            .then((value) {
                _bloc.onRefresh();
            })
            .catchError((error) {
                Toast.show(S.of(context).serverError);
            });
    }

    Widget _buildAlertDialog(BuildContext context) {
        return AlertDialog(
            content: Text(
                S.of(context).notSupport,
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
}