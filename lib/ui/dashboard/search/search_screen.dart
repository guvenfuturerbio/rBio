import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../../../core/core.dart';
import '../../../model/model.dart';
import 'search_vm.dart';

class SearchScreen extends StatefulWidget {
  bool isFromHomePage;

  SearchScreen({
    Key key,
    this.isFromHomePage,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isvRouterNavigation = true;

  @override
  void initState() {
    super.initState();
    if (widget.isFromHomePage != null) {
      isvRouterNavigation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isvRouterNavigation) {
      try {
        widget.isFromHomePage =
            Atom.queryParameters['isFromHomePage'] == 'true' ? true : false;
      } catch (_) {
        return QueryParametersError();
      }
    }

    return ChangeNotifierProvider<SearchScreenVm>(
      create: (context) => SearchScreenVm(context: context),
      child: Consumer<SearchScreenVm>(
        builder: (BuildContext context, SearchScreenVm value, Widget child) {
          return Scaffold(
            appBar: _buildAppBar(value),
            body: _buildBody(value),
          );
        },
      ),
    );
  }

  PreferredSize _buildAppBar(SearchScreenVm value) {
    return MainAppBar(
      context: context,
      title: Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
        padding: EdgeInsets.only(left: 10),
        width: double.infinity,
        child: TextFormField(
          cursorColor: R.color.blue,
          autofocus: true,
          onChanged: (text) {
            value.setSearchText(text);
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 10,
              top: 10,
              bottom: 10,
            ),
            border: InputBorder.none,
            hintText: LocaleProvider.of(context).search_hint,
            hintStyle: TextStyle(color: Color(0xFF969696), fontSize: 14),
            labelStyle: TextStyle(color: R.color.black, fontSize: 14),
            suffixIcon: Icon(
              Icons.search,
              color: Color(0xFF969696),
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(200)),
      ),
      leading: IconButton(
        icon: SvgPicture.asset(R.image.ic_back_white),
        onPressed: () {
          if (widget.isFromHomePage) {
            Navigator.of(context).pop();
          } else {
            AnalyticsManager().sendEvent(HomePageTabClickEvent());
            Atom.to(PagePaths.MAIN, isReplacement: true);
          }
        },
      ),
    );
  }

  Widget _buildBody(SearchScreenVm value) {
    return Padding(
      padding: kIsWeb
          ? EdgeInsets.symmetric(
              horizontal: Atom.size.width < 800
                  ? Atom.size.width * 0.03
                  : Atom.size.width * 0.10)
          : EdgeInsets.zero,
      child: Container(
        child: value.progress == LoadingProgress.DONE
            ? _buildPosts(context, value.filterResources, value)
            : Center(child: progress()),
      ),
    );
  }

  Widget _buildPosts(
    BuildContext context,
    List<FilterResourcesResponse> posts,
    SearchScreenVm value,
  ) {
    return value.searchText.length > 3
        ? SingleChildScrollView(
            child: Column(
              children: [
                //
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: posts.length,
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          posts[index].title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: SizedBox(
                          width: kIsWeb
                              ? MediaQuery.of(context).size.width < 1000
                                  ? MediaQuery.of(context).size.width * 0.10
                                  : MediaQuery.of(context).size.width * 0.03
                              : MediaQuery.of(context).size.width * 0.12,
                          child: SvgPicture.asset(
                              posts[index].tenants[0].id == 1
                                  ? R.image.uygulama_icon
                                  : R.image.uygulama_icon),
                        ),
                        subtitle: Text((posts[index].tenants[0].id == 1
                                ? LocaleProvider.current.guven_hospital_ayranci
                                : LocaleProvider.current.guven_cayyolu_campus) +
                            "\n" +
                            posts[index].departments[0].title),
                        onTap: () {
                          AnalyticsManager().sendEvent(
                              new OADoctorSelectionEvent(
                                  posts[index].departments[0].title,
                                  posts[index].title));
                          Atom.to(
                            PagePaths.DOCTOR_CV,
                            queryParameters: {
                              'tenantId': posts[index].tenants[0].id.toString(),
                              'departmentId':
                                  posts[index].departments[0].id.toString(),
                              'resourceId': posts[index].id.toString(),
                              'doctorName': Uri.encodeFull(posts[index].title),
                              'departmentName': Uri.encodeFull(
                                  posts[index].departments[0].title),
                              'fromOnlineSelect': false.toString(),
                              'doctorNameNoTitle':
                                  Uri.encodeFull(posts[index].title),
                            },
                          );
                        },
                      ),
                    );
                  },
                ),

                //
                value.socialPostProgress == LoadingProgress.LOADING
                    ? progress()
                    : value.socialPostProgress == LoadingProgress.ERROR
                        ? Container()
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.filteredSocialResources.length,
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 4,
                                child: ListTile(
                                  leading: SizedBox(
                                    width: kIsWeb
                                        ? MediaQuery.of(context).size.width <
                                                1000
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.10
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03
                                        : MediaQuery.of(context).size.width *
                                            0.12,
                                    child: SvgPicture.asset(value
                                        .filteredSocialResources[index]
                                        .imagePath),
                                  ),
                                  title: Text(
                                    value.filteredSocialResources[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            15),
                                  ),
                                  subtitle: Text(
                                      value.filteredSocialResources[index].text,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context)
                                                .textScaleFactor *
                                            10,
                                      )),
                                  onTap: () async {
                                    value.clickPost(
                                        value.filteredSocialResources[index].id,
                                        value.filteredSocialResources[index]
                                            .url);
                                  },
                                ),
                              );
                            },
                          )
              ],
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: value.allSocialResources.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                child: ListTile(
                  leading: SizedBox(
                    width: kIsWeb
                        ? MediaQuery.of(context).size.width < 1400
                            ? MediaQuery.of(context).size.width * 0.12
                            : MediaQuery.of(context).size.width * 0.03
                        : MediaQuery.of(context).size.width * 0.12,
                    child: SvgPicture.asset(
                        value.allSocialResources[index].imagePath),
                  ),
                  title: Text(
                    value.allSocialResources[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    value.allSocialResources[index].text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () async {
                    value.clickPost(value.allSocialResources[index].id,
                        value.allSocialResources[index].url);
                  },
                ),
              );
            },
          );
  }
}
