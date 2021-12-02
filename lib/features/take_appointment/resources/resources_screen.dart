import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import 'resources_vm.dart';

class ResourcesScreen extends StatefulWidget {
  int tenantId;
  int departmentId;
  bool fromOnlineAppo;
  String departmentName;

  ResourcesScreen({
    Key key,
    this.tenantId,
    this.departmentId,
    this.departmentName,
    this.fromOnlineAppo,
  }) : super(key: key);

  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    try {
      widget.tenantId = int.parse(Atom.queryParameters['tenantId']);
      widget.departmentId = int.parse(Atom.queryParameters['departmentId']);
      widget.departmentName =
          Uri.decodeFull(Atom.queryParameters['departmentName']);
      widget.fromOnlineAppo =
          Atom.queryParameters['fromOnlineAppo'] == "true" ? true : false;
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<ResourcesScreenVm>(
      create: (context) => ResourcesScreenVm(
        context: context,
        tenantId: widget.tenantId,
        departmentId: widget.departmentId,
      ),
      child: Consumer<ResourcesScreenVm>(
        builder: (
          BuildContext context,
          ResourcesScreenVm value,
          Widget child,
        ) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                widget.tenantId == 1
                    ? LocaleProvider.current.guven_hospital_ayranci
                    : widget.tenantId == 7
                        ? LocaleProvider.current.guven_cayyolu_campus
                        : LocaleProvider.current.online_hospital,
              ),
            ),
            body: _buildBody(context, value),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ResourcesScreenVm value) {
    switch (value.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return _buildSuccess(value.filterResources);

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }

  Widget _buildSuccess(List<FilterResourcesResponse> posts) {
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
          : EdgeInsets.all(8),
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
                AnalyticsManager().sendEvent(new OADoctorSelectionEvent(
                    posts[index].departments[0].title, posts[index].title));
                Atom.to(PagePaths.DOCTOR_CV, queryParameters: {
                  'tenantId': widget.tenantId.toString(),
                  'fromOnlineSelect': widget.fromOnlineAppo.toString(),
                  'doctorNameNoTitle': Uri.encodeFull(posts[index].title),
                  'departmentId': widget.departmentId.toString(),
                  'departmentName': Uri.encodeFull(widget.departmentName),
                  'doctorName': Uri.encodeFull(posts[index].title),
                  'resourceId': posts[index].id.toString(),
                });

                /*Get.rootDelegate.toNamed('EventListPage', parameters: {
                  ' doctorNameNoTitle': Uri.encodeFull(posts[index].title),
                  'fromOnlineSelect': widget.fromOnlineAppo.toString(),
                  'departmentId': widget.departmentId.toString(),
                  'departmentName': Uri.encodeFull(widget.departmentName),
                  'doctorName': Uri.encodeFull(posts[index].title),
                  'resourceId': posts[index].id.toString(),
                  'tenantId': widget.tenantId.toString(),
                });*/
              },
            ),
          );
        },
      ),
    );
  }
}
