import 'dart:async';

import 'package:flutter_monster/models/project.dart';
import 'package:flutter_monster/utils/constants.dart';
import 'package:flutter_monster/utils/http_client.dart';
import 'package:sprintf/sprintf.dart';

class ProjectsRepository {

    Future<List<Project>> getProjects(int page) async {
        int limit = page == 0 ? (Constants.PAGE_LIMIT - 1) : Constants.PAGE_LIMIT;
        int skip = page * limit;
        BaseResponse<List> response = await HttpUtil().request<List>(
            Constants.HTTP_METHOD_GET,
            sprintf(Constants.URL_PATH_PROJECTS, [limit, skip]),
        );

        List<Project> projectsList;
        if (response.data != null) {
            projectsList = response.data.map((value) {
                return Project.fromJson(value);
            }).toList();
        }

        return projectsList;
    }

    Future renameProject(String id, String name) async {
        await HttpUtil().request<Map>(
            Constants.HTTP_METHOD_PUT,
            sprintf(Constants.URL_PATH_UPDATE_PROJECT, [id]),
            data: {
                'title': name,
            }
        );
    }

    Future deleteProject(String id) async {
        await HttpUtil().request<Map>(
            Constants.HTTP_METHOD_DELETE,
            sprintf(Constants.URL_PATH_DELETE_PROJECT, [id]),
        );
    }

}