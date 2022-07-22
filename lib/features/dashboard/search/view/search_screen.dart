import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../bloc/search_bloc.dart';
import '../model/filter_resources_response.dart';
import '../model/search_social_type.dart';
import '../utils/debouncer.dart';

class SearchScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState>? drawerKey;

  const SearchScreen({
    Key? key,
    this.drawerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (ctx) => SearchBloc(
        getIt<Repository>(),
      )..add(const SearchFetched()),
      child: SearchView(drawerKey: drawerKey),
    );
  }
}

class SearchView extends StatelessWidget {
  final GlobalKey<ScaffoldState>? drawerKey;

  SearchView({
    Key? key,
    this.drawerKey,
  }) : super(key: key);

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: RbioKeyboardActions(
        focusList: [
          focusNode,
        ],
        child: RbioScaffold(
          resizeToAvoidBottomInset: false,
          appbar: _buildAppBar(context),
          body: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) => _buildBody(context, state),
          ),
        ),
      ),
    );
  }

  IRbioAppBar _buildAppBar(BuildContext context) {
    // adds delay
    final _debouncer = Debouncer(milliseconds: 500);
    return RbioAppBar(
      context: context,
      leading: drawerKey != null
          ? RbioLeadingMenu(drawerKey: drawerKey)
          : const SizedBox(width: 0, height: 0),
      leadingWidth: drawerKey != null ? null : 0,
      title: SizedBox(
        width: double.infinity,
        child: RbioTextFormField(
          focusNode: focusNode,
          hintText: LocaleProvider.of(context).search_hint,
          onChanged: (text) {
            _debouncer.run(
                () => context.read<SearchBloc>().add(SearchTextFiltered(text)));
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SearchState state) {
    return state.when(
      initial: () => const SizedBox(),
      loadInProgress: (socialTypes) => Column(
        children: [
          if (socialTypes != null &&
              getIt<IAppConfig>().productType == ProductType.oneDose) ...[
            Wrap(spacing: 8, children: _chips(socialTypes)),
          ],
          const Expanded(child: RbioLoading()),
        ],
      ),
      success: (list, socialTypes) => Column(
        children: [
          if (getIt<IAppConfig>().productType == ProductType.oneDose) ...[
            Wrap(spacing: 8, children: _chips(socialTypes)),
          ],
          Expanded(child: SearchListView(list: list)),
        ],
      ),
      failure: () => const RbioBodyError(),
    );
  }

  List<RbioFilterChip> _chips(List<SearchSocialType> list) {
    return [
      RbioFilterChip(
        type: SearchSocialType.blog,
        isSelected: list.contains(SearchSocialType.blog),
      ),
      RbioFilterChip(
        type: SearchSocialType.spotify,
        isSelected: list.contains(SearchSocialType.spotify),
      ),
      RbioFilterChip(
        type: SearchSocialType.youtube,
        isSelected: list.contains(SearchSocialType.youtube),
      ),
    ];
  }
}

class RbioFilterChip extends StatelessWidget {
  final SearchSocialType type;
  final bool isSelected;

  const RbioFilterChip({
    Key? key,
    required this.type,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: isSelected,
      backgroundColor: context.xCardColor,
      checkmarkColor: getIt<IAppConfig>().theme.mainOverColor,
      selectedColor: context.xPrimaryColor,
      label: Text(
        type.xGetTitle,
        style: isSelected
            ? context.xHeadline3.copyWith(
                color: getIt<IAppConfig>().theme.white,
                fontWeight: FontWeight.bold,
              )
            : context.xHeadline3.copyWith(
                color: context.xTextInverseColor,
              ),
      ),
      onSelected: (val) {
        context.read<SearchBloc>().add(SearchEvent.platformFilter(type));
      },
    );
  }
}

class SearchListView extends StatelessWidget {
  final List<SearchModel> list;

  const SearchListView({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Center(
        child: Text(
          LocaleProvider.of(context).searchEmpty,
          style: context.xHeadline2,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(
        bottom: R.sizes.bottomNavigationBarHeight,
      ),
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        final item = list[index];
        if (item is SocialPostsResponse) {
          return _SocialCard(item: item);
        } else if (item is FilterResourcesResponse) {
          return _ResourceCard(item: item);
        }

        return const SizedBox();
      },
    );
  }
}

class _SocialCard extends StatelessWidget {
  final SocialPostsResponse item;

  const _SocialCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          width: kIsWeb
              ? MediaQuery.of(context).size.width < 1400
                  ? MediaQuery.of(context).size.width * 0.12
                  : MediaQuery.of(context).size.width * 0.03
              : MediaQuery.of(context).size.width * 0.12,
          child: SvgPicture.asset(
            item.imagePath ?? '',
          ),
        ),
        title: Text(
          item.title ?? '',
          style: context.xHeadline3.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          item.text ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.xHeadline5,
        ),
        onTap: () {
          final itemId = item.id;
          final itemUrl = item.url;
          if (itemId != null && itemUrl != null) {
            clickPost(itemId, itemUrl);
          }
        },
      ),
    );
  }

  Future<void> clickPost(int postId, String url) async {
    getIt<Repository>().clickPost(postId);
    await getIt<UrlLauncherManager>().launch(url);
  }
}

class _ResourceCard extends StatelessWidget {
  final FilterResourcesResponse item;

  const _ResourceCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterResourceTitle = item.title ?? '';
    final tenantsFirstId = item.tenants?.first.id;
    final departmentId = item.departments?.first.id;
    final departmentTitle = item.departments?.first.title ?? '';

    return Card(
        child: ListTile(
      title: Text(
        item.title ?? '',
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
              ? getIt<IAppConfig>().theme.appLogo
              : getIt<IAppConfig>().theme.appLogo,
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
            'resourceId': item.id.toString(),
            'doctorName': Uri.encodeFull(filterResourceTitle),
            'departmentName': Uri.encodeFull(departmentTitle),
            'doctorNameNoTitle': Uri.encodeFull(filterResourceTitle),
          },
        );
      },
    ));
  }
}
