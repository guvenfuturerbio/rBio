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
      create: (context) => SearchScreenVm(context),
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

  IRbioAppBar _buildAppBar(SearchScreenVm value) {
    return RbioAppBar(
      leadingWidth: !widget.fromBottomBar ? null : 0,
      leading:
          !widget.fromBottomBar ? null : const SizedBox(width: 0, height: 0),
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
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return vm.searchText.length > 3
            ? _buildFilterResources(vm)
            : _buildAllSocialResources(vm);

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
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
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final filterResource = value.filterResources[index];
              final filterResourceTitle = filterResource.title ?? '';
              final tenantsFirstId = filterResource.tenants?.first.id;
              final departmentId = filterResource.departments?.first.id;
              final departmentTitle =
                  filterResource.departments?.first.title ?? '';

              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: R.sizes.borderRadiusCircular,
                ),
                child: ListTile(
                  title: Text(
                    filterResource.title ?? '',
                    style: context.xHeadline3,
                  ),
                  leading: SizedBox(
                    width: kIsWeb
                        ? MediaQuery.of(context).size.width < 1000
                            ? MediaQuery.of(context).size.width * 0.10
                            : MediaQuery.of(context).size.width * 0.03
                        : MediaQuery.of(context).size.width * 0.12,
                    child: SvgPicture.asset(
                      tenantsFirstId == 1
                          ? R.image.oneDoseHealth
                          : R.image.oneDoseHealth,
                    ),
                  ),
                  subtitle: Text((tenantsFirstId == 1
                          ? LocaleProvider.current.guven_hospital_ayranci
                          : LocaleProvider.current.guven_cayyolu_campus) +
                      "\n" +
                      departmentTitle),
                  onTap: () {
                    Atom.to(
                      PagePaths.doctorCv,
                      queryParameters: {
                        'tenantId': tenantsFirstId.toString(),
                        'departmentId': departmentId.toString(),
                        'resourceId': filterResource.id.toString(),
                        'doctorName': Uri.encodeFull(filterResourceTitle),
                        'departmentName': Uri.encodeFull(departmentTitle),
                        'doctorNameNoTitle':
                            Uri.encodeFull(filterResourceTitle),
                      },
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
            physics: const BouncingScrollPhysics(),
            itemCount: value.allSocialResources.length,
            itemBuilder: (BuildContext context, int index) {
              final allSocialResource = value.allSocialResources[index];

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
                      allSocialResource.imagePath ?? '',
                    ),
                  ),
                  title: Text(
                    allSocialResource.title ?? '',
                    style: context.xHeadline3
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    allSocialResource.text ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.xHeadline5,
                  ),
                  onTap: () {
                    final itemId = allSocialResource.id;
                    final itemUrl = allSocialResource.url;
                    if (itemId != null && itemUrl != null) {
                      value.clickPost(itemId, itemUrl);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<RbioFilterChip> _chips(SearchScreenVm vm) {
    return [
      RbioFilterChip(title: 'Blog', vm: vm),
      RbioFilterChip(title: 'Spotify', vm: vm),
      RbioFilterChip(title: 'Youtube', vm: vm),
    ];
  }
}

class RbioFilterChip extends StatelessWidget {
  final String title;
  final SearchScreenVm vm;

  const RbioFilterChip({
    Key? key,
    required this.title,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      backgroundColor: getIt<ITheme>().cardBackgroundColor,
      selected: vm.filterTitleList.contains(title),
      checkmarkColor: getIt<ITheme>().cardBackgroundColor,
      selectedColor: getIt<ITheme>().mainColor,
      label: Text(
        title,
        style: vm.filterTitleList.contains(title)
            ? context.xBodyText1
                .copyWith(color: getIt<ITheme>().cardBackgroundColor)
            : context.xBodyText1,
      ),
      onSelected: (val) {
        vm.toggleFilter(title);
      },
    );
  }
}
