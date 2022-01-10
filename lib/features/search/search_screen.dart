import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onedosehealth/core/core.dart';
import 'package:provider/provider.dart';

import '../../../model/model.dart';
import 'search_vm.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

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

  Widget _buildBody(SearchScreenVm vm) {
    switch (vm.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return vm.searchText.length > 3
            ? _buildFilterResources(vm)
            : _buildAllSocialResources(vm);

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }

  Widget _buildFilterResources(SearchScreenVm value) {
    if (value.filterResources.isEmpty &&
        value.filteredSocialResources.isEmpty) {
      return Center(
        child: Text(
          LocaleProvider.of(context).searchEmpty,
          style: context.xHeadline2,
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          //
          ListView.builder(
            shrinkWrap: true,
            itemCount: value.filterResources.length,
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: R.sizes.borderRadiusCircular,
                ),
                child: ListTile(
                  title: Text(
                    value.filterResources[index].title,
                    style: context.xHeadline3,
                  ),
                  leading: SizedBox(
                    width: kIsWeb
                        ? MediaQuery.of(context).size.width < 1000
                            ? MediaQuery.of(context).size.width * 0.10
                            : MediaQuery.of(context).size.width * 0.03
                        : MediaQuery.of(context).size.width * 0.12,
                    child: Image.asset(
                        value.filterResources[index].tenants[0].id == 1
                            ? R.image.oneDoseHealthPng
                            : R.image.oneDoseHealthPng),
                  ),
                  subtitle: Text(
                      (value.filterResources[index].tenants[0].id == 1
                              ? LocaleProvider.current.guven_hospital_ayranci
                              : LocaleProvider.current.guven_cayyolu_campus) +
                          "\n" +
                          value.filterResources[index].departments[0].title),
                  onTap: () {
                    Atom.to(
                      PagePaths.DOCTOR_CV,
                      queryParameters: {
                        'tenantId': value.filterResources[index].tenants[0].id
                            .toString(),
                        'departmentId': value
                            .filterResources[index].departments[0].id
                            .toString(),
                        'resourceId':
                            value.filterResources[index].id.toString(),
                        'doctorName':
                            Uri.encodeFull(value.filterResources[index].title),
                        'departmentName': Uri.encodeFull(
                            value.filterResources[index].departments[0].title),
                        'doctorNameNoTitle':
                            Uri.encodeFull(value.filterResources[index].title),
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
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: R.sizes.borderRadiusCircular,
                          ),
                          child: ListTile(
                            leading: SizedBox(
                              width: kIsWeb
                                  ? MediaQuery.of(context).size.width < 1000
                                      ? MediaQuery.of(context).size.width * 0.10
                                      : MediaQuery.of(context).size.width * 0.03
                                  : MediaQuery.of(context).size.width * 0.12,
                              child: SvgPicture.asset(
                                value.filteredSocialResources[index].imagePath,
                              ),
                            ),
                            title: Text(
                              value.filteredSocialResources[index].title,
                              style: context.xHeadline2,
                            ),
                            subtitle: Text(
                              value.filteredSocialResources[index].text,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.xHeadline3,
                            ),
                            onTap: () {
                              value.clickPost(
                                value.filteredSocialResources[index].id,
                                value.filteredSocialResources[index].url,
                              );
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
      padding: EdgeInsets.only(
        bottom: R.sizes.defaultBottomValue,
      ),
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: value.allSocialResources.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: R.sizes.borderRadiusCircular,
          ),
          child: ListTile(
            leading: SizedBox(
              width: kIsWeb
                  ? MediaQuery.of(context).size.width < 1400
                      ? MediaQuery.of(context).size.width * 0.12
                      : MediaQuery.of(context).size.width * 0.03
                  : MediaQuery.of(context).size.width * 0.12,
              child: SvgPicture.asset(
                value.allSocialResources[index].imagePath,
              ),
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
            onTap: () {
              value.clickPost(
                value.allSocialResources[index].id,
                value.allSocialResources[index].url,
              );
            },
          ),
        );
      },
    );
  }
}
