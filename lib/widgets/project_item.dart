import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monster/generated/i18n.dart';
import 'package:flutter_monster/models/project.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/styles.dart';
import 'package:flutter_monster/widgets/project_image.dart';

/*
 * Created by gloria on 2018/1/9.
 */

class ProjectItem extends StatelessWidget {
    const ProjectItem({
        this.onTap,
        this.project,
        this.onSelected,
        Key key
    }) : super(key: key);

    final Project project;
    final GestureTapCallback onTap;
    final PopupMenuItemSelected<int> onSelected;

    @override
    Widget build(BuildContext context) {
        return project.id == '' ? _buildNewProject(context) : _buildProjects(context);
    }

    Widget _buildNewProject(BuildContext context) {

        return InkWell(
            onTap: onTap,
            child: Card(
                color: MColor.background,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                    Icons.add_circle,
                    size: Dimens.size_new_project_icon,
                    color: MColor.button_normal,
                ),
            )
        );
    }

    Widget _buildProjects(BuildContext context) {
        return InkWell(
            onTap: onTap,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                    children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: ProjectImage(url: project.image)),
                        Container(
                            height: Dimens.height_project_info,
                            padding: EdgeInsets.only(left: Dimens.gap_dp10),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                            project.title ?? '',
                                            style: TextStyles.hintContent,
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                    ),
                                    Expanded(
                                        flex: 0,
                                        child: PopupMenuButton(
                                            icon: Icon(Icons.more_horiz,
                                                color: MColor.text_gray),
                                            itemBuilder: (context) => [
                                                PopupMenuItem<int>(
                                                    value: Constants.MENU_ITEM_EDIT,
                                                    child: ListTile(
                                                        leading: Icon(Icons.edit),
                                                        title: Text(S.of(context).rename)),
                                                ),
                                                PopupMenuItem<int>(
                                                    value: Constants.MENU_ITEM_DELETE,
                                                    child: ListTile(
                                                        leading: Icon(Icons.cancel),
                                                        title: Text(S.of(context).delete)),
                                                ),
                                            ],
                                            onSelected: (value) {
                                                onSelected(value);
                                            },
                                        ))
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }

}
