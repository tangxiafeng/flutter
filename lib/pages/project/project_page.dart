import 'package:flutter/material.dart';
import 'package:flutter_monster/widgets/loading_view.dart';
import 'package:flutter_monster/pages/project/project_bloc.dart';
import 'package:flutter_monster/blocs/bloc_provider.dart';

class ProjectPage extends StatelessWidget {
    const ProjectPage({
        this.title,
        Key key
    }) : super(key: key);

    final String title;

    @override
    Widget build(BuildContext context) {
        final ProjectBloc bloc = BlocProvider.of<ProjectBloc>(context);

        return Container(
            child: LoadingView(),
        );
    }

}
