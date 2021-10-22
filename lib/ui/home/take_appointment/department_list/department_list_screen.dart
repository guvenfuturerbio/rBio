import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import 'department_list_vm.dart';

class DepartmentListScreen extends StatefulWidget {
  int tenantId;
  bool fromOnlineSelection;

  DepartmentListScreen({
    Key key,
    this.tenantId,
    this.fromOnlineSelection,
  }) : super(key: key);

  @override
  _DepartmentListScreenState createState() => _DepartmentListScreenState();
}

class _DepartmentListScreenState extends State<DepartmentListScreen> {
  @override
  Widget build(BuildContext context) {
    try {
      widget.tenantId = int.parse(Atom.queryParameters['tenantId']);
      widget.fromOnlineSelection =
          Atom.queryParameters['fromOnlineSelection'] == 'true';
    } catch (_) {
      return QueryParametersError();
    }

    return ChangeNotifierProvider<DepartmentListScreenVm>(
      create: (context) => DepartmentListScreenVm(
        context: context,
        tenantId: widget.tenantId,
        fromOnlineSelection: widget.fromOnlineSelection,
      ),
      child: Consumer<DepartmentListScreenVm>(
        builder:
            (BuildContext context, DepartmentListScreenVm value, Widget child) {
          return Scaffold(
            appBar: MainAppBar(
                context: context,
                title: getTitleBar(context),
                leading: ButtonBackWhite(context),
                actions: getActions(context)),
            body: value.progress == LoadingProgress.DONE
                ? _webBuildPosts(context, value.filterDepartmentResponse)
                : value.progress == LoadingProgress.LOADING
                    ? loadingDialog()
                    : Container(),
          );
        },
      ),
    );
  }

  List<Widget> getActions(BuildContext context) {
    return [
      IconButton(
        icon: SvgPicture.asset(
          R.image.search_grey,
          color: R.color.white,
        ),
        onPressed: () {
          Atom.to(
            PagePaths.SEARCH,
            queryParameters: {
              'isFromHomePage': true.toString(),
            },
          );
        },
      ),
    ];
  }

  Widget _webBuildPosts(
      BuildContext context, List<FilterDepartmentsResponse> posts) {
    return Padding(
      padding: kIsWeb
          ? EdgeInsets.only(
              top: 50,
              left: Atom.size.width < 800
                  ? Atom.size.width * 0.03
                  : Atom.size.width * 0.10,
              right: Atom.size.width < 800
                  ? Atom.size.width * 0.03
                  : Atom.size.width * 0.10)
          : EdgeInsets.zero,
      child: ListView.builder(
        itemCount: posts.length,
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: ListTile(
              title: Text(
                posts[index].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              //subtitle: Text(posts[index].id.toString()),
              onTap: () {
                AnalyticsManager()
                    .sendEvent(OADepartmentSelectionEvent(posts[index].title));
                Atom.to(PagePaths.RESOURCES, queryParameters: {
                  'tenantId': widget.tenantId?.toString(),
                  'departmentId': posts[index].id?.toString(),
                  'departmentName': Uri.encodeFull(posts[index].title),
                  'fromOnlineAppo': widget.fromOnlineSelection.toString(),
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(
        title: widget.tenantId == 1
            ? LocaleProvider.current.guven_hospital_ayranci
            : LocaleProvider.current.guven_cayyolu_campus);
  }
}
