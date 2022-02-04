import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/core.dart';
import 'search_vm.dart';

class SearchScreen extends StatefulWidget {
  final bool fromBottomBar;

  const SearchScreen({
    Key? key,
    this.fromBottomBar = false,
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
        builder: (BuildContext context, SearchScreenVm value, Widget? child) {
          return RbioScaffold(
            resizeToAvoidBottomInset: false,
            appbar: _buildAppBar(value),
            body: Column(
              children: [
                Wrap(
                  spacing: 8,
                  children: _chips(value),
                ),
                Expanded(child: _buildBody(value)),
              ],
            ),
          );
        },
      ),
    );
  }

  PreferredSize _buildAppBar(SearchScreenVm value) {
    return RbioAppBar(
      leadingWidth: !widget.fromBottomBar ? null : 0,
      leading: !widget.fromBottomBar ? null : SizedBox(width: 0, height: 0),
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
                    child: SvgPicture.asset(
                        value.filterResources[index].tenants[0].id == 1
                            ? R.image.oneDoseHealth
                            : R.image.oneDoseHealth),
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
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
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
                    style: context.xHeadline3
                        .copyWith(fontWeight: FontWeight.bold),
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
          ),
        ),
      ],
    );
  }

  List<RbioFilterChip> _chips(SearchScreenVm value) {
    return [
      //RbioFilterChip('Doctor', value),
      RbioFilterChip('Blog', value),
      RbioFilterChip('Spotify', value),
      RbioFilterChip('Youtube', value),
      //RbioFilterChip('Bundle', value),
      /*   Chip(label: Text(LocaleProvider.current.doctor)),
      Chip(
        label: Text(LocaleProvider.current.youtube_stream),
      )*/
    ];
  }
}

class RbioFilterChip extends StatefulWidget {
  bool isSelected;
  String title;
  SearchScreenVm value;
  RbioFilterChip(
    this.title,
    this.value, {
    Key key,
  }) : super(key: key);

  @override
  State<RbioFilterChip> createState() => _RbioFilterChipState();
}

class _RbioFilterChipState extends State<RbioFilterChip> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      backgroundColor: getIt<ITheme>().cardBackgroundColor,
      selected: widget.value.filterTitleList.contains(widget.title),
      checkmarkColor: getIt<ITheme>().cardBackgroundColor,
      selectedColor: getIt<ITheme>().mainColor,
      label: Text(
        widget.title,
        style: widget.value.filterTitleList.contains(widget.title)
            ? context.xBodyText1
                .copyWith(color: getIt<ITheme>().cardBackgroundColor)
            : context.xBodyText1,
      ),
      onSelected: (val) {
        widget.value.toggleFilter(widget.title);
      },
    );
  }
}
