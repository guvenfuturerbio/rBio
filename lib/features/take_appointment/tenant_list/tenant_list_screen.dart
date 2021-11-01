import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import 'tenant_list_vm.dart';

class TenantsScreen extends StatefulWidget {
  const TenantsScreen({Key key}) : super(key: key);

  @override
  _TenantsScreenState createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TenantListPageVm(context: context),
      child: Consumer<TenantListPageVm>(
        builder: (context, value, child) {
          return Scaffold(
            appBar: MainAppBar(
              context: context,
              title: getTitleBar(context),
              leading: ButtonBackWhite(context),
            ),
            body: value.progress == LoadingProgress.DONE
                ? kIsWeb
                    ? _webBuildPosts(context, value.tenantsFilterResponse)
                    : _buildPosts(context, value.tenantsFilterResponse)
                : value.progress == LoadingProgress.LOADING
                    ? loadingDialog()
                    : Container(),
          );
        },
      ),
    );
  }

  Widget _buildPosts(
    BuildContext context,
    List<FilterTenantsResponse> tenantList,
  ) {
    return ListView.builder(
      itemCount: tenantList.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        print(tenantList.toString());
        return InkWell(
          child: _ItemHospitalList(
              title: tenantList[index].id == R.dynamicVar.tenantAyranciId
                  ? LocaleProvider.current.guven_hospital_ayranci
                  : tenantList[index].id == R.dynamicVar.tenantCayyoluId
                      ? LocaleProvider.current.guven_cayyolu_campus
                      : LocaleProvider.of(context).online_hospital,
              image: tenantList[index].id == R.dynamicVar.tenantAyranciId
                  ? R.image.guven_hospital_pic
                  : tenantList[index].id == R.dynamicVar.tenantCayyoluId
                      ? R.image.cayyolu_pic
                      : R.image.online_hospital,
              number: LocaleProvider.current.title_appointment,
              margin: EdgeInsets.only(top: 10, bottom: 20)),
          onTap: () {
            if (tenantList[index].id == R.dynamicVar.tenantAyranciId ||
                tenantList[index].id == R.dynamicVar.tenantCayyoluId) {
              AnalyticsManager().sendEvent(
                HospitalSelectionEvent(
                    tenantList[index].id == R.dynamicVar.tenantAyranciId
                        ? LocaleProvider.current.guven_hospital_ayranci
                        : LocaleProvider.current.guven_cayyolu_campus),
              );
              Atom.to(
                PagePaths.DEPARTMENTS,
                queryParameters: {
                  'tenantId': tenantList[index].id.toString(),
                  'fromOnlineSelection': 'false',
                },
              );
            } else {
              AnalyticsManager().sendEvent(new OnlineAppointmentClickEvent());
              Atom.to(
                PagePaths.DEPARTMENTS,
                queryParameters: {
                  'tenantId': R.dynamicVar.tenantAyranciId.toString(),
                  'fromOnlineSelection': 'true',
                },
              );
            }
          },
        );
      },
    );
  }

  Widget _webBuildPosts(
      BuildContext context, List<FilterTenantsResponse> tenantList) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 50,
            left: Atom.size.width < 800
                ? Atom.size.width * 0.03
                : Atom.size.width * 0.10,
            right: Atom.size.width < 800
                ? Atom.size.width * 0.03
                : Atom.size.width * 0.10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: Atom.size.width < 800
                  ? Atom.size.width * 0.45
                  : Atom.size.width * 0.2,
              crossAxisCount: Atom.size.width < 800 ? 1 : 2),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: tenantList.length,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                child: _ItemHospitalList(
                    title: tenantList[index].id == R.dynamicVar.tenantAyranciId
                        ? LocaleProvider.current.guven_hospital_ayranci
                        : tenantList[index].id == R.dynamicVar.tenantCayyoluId
                            ? LocaleProvider.current.guven_cayyolu_campus
                            : LocaleProvider.of(context).online_hospital,
                    image: tenantList[index].id == R.dynamicVar.tenantAyranciId
                        ? R.image.guven_hospital_pic
                        : tenantList[index].id == R.dynamicVar.tenantCayyoluId
                            ? R.image.cayyolu_pic
                            : R.image.online_hospital,
                    number: LocaleProvider.current.title_appointment,
                    margin: EdgeInsets.only(top: 10, bottom: 20)),
                onTap: () {
                  if (tenantList[index].id == R.dynamicVar.tenantAyranciId ||
                      tenantList[index].id == R.dynamicVar.tenantCayyoluId) {
                    AnalyticsManager().sendEvent(new HospitalSelectionEvent(
                        tenantList[index].id == R.dynamicVar.tenantAyranciId
                            ? LocaleProvider.current.guven_hospital_ayranci
                            : LocaleProvider.current.guven_cayyolu_campus));
                    Atom.to(PagePaths.DEPARTMENTS, queryParameters: {
                      'tenantId': tenantList[index].id.toString(),
                      'fromOnlineSelection': 'false',
                    });
                  } else {
                    AnalyticsManager()
                        .sendEvent(new OnlineAppointmentClickEvent());
                    Atom.to(PagePaths.DEPARTMENTS, queryParameters: {
                      'tenantId': R.dynamicVar.tenantAyranciId.toString(),
                      'fromOnlineSelection': 'true',
                    });
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _ItemHospitalList(
          {String title,
          String image,
          String number,
          bool isFocused = false,
          EdgeInsets margin}) =>
      Container(
        height: kIsWeb
            ? MediaQuery.of(context).size.height * 0.13
            : MediaQuery.of(context).size.height * 0.20,
        margin: margin,
        child: Stack(
          children: <Widget>[
            Positioned(
              width: MediaQuery.of(context).size.width * 0.8,
              bottom: 10,
              left: 15,
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.grey.withOpacity(0.0),
                        Colors.white.withOpacity(0.3),
                      ],
                      stops: [
                        0.0,
                        1.0
                      ])),
            ),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            image: new DecorationImage(
              image: new ExactAssetImage(image),
              fit: BoxFit.fill,
            ),
            gradient: LinearGradient(colors: [
              R.color.blue,
              R.color.light_blue,
            ], begin: Alignment.topLeft, end: Alignment.topRight),
            boxShadow: [
              BoxShadow(
                  color: R.color.dark_black.withAlpha(50),
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: Offset(5, 10))
            ]),
      );

  Widget getTitleBar(BuildContext context) {
    return TitleAppBarWhite(title: LocaleProvider.current.title_hospital);
  }
}
