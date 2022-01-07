import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:provider/provider.dart';

import '../../../model/model.dart';
import 'search_vm.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    Key key,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchScreenVm>(
      create: (context) => SearchScreenVm(context: context),
      child: Consumer<SearchScreenVm>(
        builder: (BuildContext context, SearchScreenVm value, Widget child) {
          return RbioScaffold(
            resizeToAvoidBottomInset: false,
            appbar: _buildAppBar(value),
            body: _buildBody(value),
          );
        },
      ),
    );
  }

  PreferredSize _buildAppBar(SearchScreenVm value) {
    return RbioAppBar(
      title: SizedBox(
        width: double.infinity,
        child: RbioTextFormField(
          hintText: LocaleProvider.of(context).search_hint,
          onChanged: (text) {
            value.setSearchText(text);
          },
        ),
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
      child: value.progress == LoadingProgress.DONE
          ? _buildPosts(context, value.filterResources, value)
          : Center(
              child: RbioLoading(),
            ),
    );
  }

  Widget _buildPosts(
    BuildContext context,
    List<FilterResourcesResponse> posts,
    SearchScreenVm value,
  ) {
    return value.searchText.length > 3
        ? _buildFilterResources(posts, value)
        : _buildAllSocialResources(value);
  }

  Widget _buildFilterResources(
    List<FilterResourcesResponse> posts,
    SearchScreenVm value,
  ) {
    if (posts.isEmpty && value.filteredSocialResources.isEmpty) {
      return Center(
        child: Text(LocaleProvider.of(context).searchEmpty,
            style: context.xHeadline2),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          //
          ListView.builder(
            shrinkWrap: true,
            itemCount: posts.length,
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 4,
                child: ListTile(
                  title: Text(
                    posts[index].title,
                    style: context.xHeadline3,
                  ),
                  leading: SizedBox(
                    width: kIsWeb
                        ? MediaQuery.of(context).size.width < 1000
                            ? MediaQuery.of(context).size.width * 0.10
                            : MediaQuery.of(context).size.width * 0.03
                        : MediaQuery.of(context).size.width * 0.12,
                    child: Image.asset(posts[index].tenants[0].id == 1
                        ? R.image.oneDoseHealthPng
                        : R.image.oneDoseHealthPng),
                  ),
                  subtitle: Text((posts[index].tenants[0].id == 1
                          ? LocaleProvider.current.guven_hospital_ayranci
                          : LocaleProvider.current.guven_cayyolu_campus) +
                      "\n" +
                      posts[index].departments[0].title),
                  onTap: () {
                    AnalyticsManager().sendEvent(new OADoctorSelectionEvent(
                        posts[index].departments[0].title, posts[index].title));
                    Atom.to(
                      PagePaths.DOCTOR_CV,
                      queryParameters: {
                        'tenantId': posts[index].tenants[0].id.toString(),
                        'departmentId':
                            posts[index].departments[0].id.toString(),
                        'resourceId': posts[index].id.toString(),
                        'doctorName': Uri.encodeFull(posts[index].title),
                        'departmentName':
                            Uri.encodeFull(posts[index].departments[0].title),
                        'doctorNameNoTitle': Uri.encodeFull(posts[index].title),
                      },
                    );
                  },
                ),
              );
            },
          ),

          //
          value.socialPostProgress == LoadingProgress.LOADING
              ? RbioLoading()
              : value.socialPostProgress == LoadingProgress.ERROR
                  ? Container()
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.filteredSocialResources.length,
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            leading: SizedBox(
                              width: kIsWeb
                                  ? MediaQuery.of(context).size.width < 1000
                                      ? MediaQuery.of(context).size.width * 0.10
                                      : MediaQuery.of(context).size.width * 0.03
                                  : MediaQuery.of(context).size.width * 0.12,
                              child: SvgPicture.asset(value
                                  .filteredSocialResources[index].imagePath),
                            ),
                            title: Text(
                                value.filteredSocialResources[index].title,
                                style: context.xHeadline2),
                            subtitle: Text(
                                value.filteredSocialResources[index].text,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.xHeadline3),
                            onTap: () async {
                              value.clickPost(
                                  value.filteredSocialResources[index].id,
                                  value.filteredSocialResources[index].url);
                            },
                          ),
                        );
                      },
                    ),
        ],
      ),
    );
  }

  Widget _buildAllSocialResources(SearchScreenVm value) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: value.allSocialResources.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 4,
          child: ListTile(
            leading: SizedBox(
              width: kIsWeb
                  ? MediaQuery.of(context).size.width < 1400
                      ? MediaQuery.of(context).size.width * 0.12
                      : MediaQuery.of(context).size.width * 0.03
                  : MediaQuery.of(context).size.width * 0.12,
              child:
                  SvgPicture.asset(value.allSocialResources[index].imagePath),
            ),
            title: Text(
              value.allSocialResources[index].title,
              style: context.xHeadline3.copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              value.allSocialResources[index].text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline5,
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
