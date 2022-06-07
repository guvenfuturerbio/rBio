import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../app/bluetooth_v2/bluetooth_v2.dart';
import '../cubit/for_you_sub_categories_cubit.dart';

class ForYouSubCategoriesScreen extends StatelessWidget {
  int? categoryId;
  String? title;

  ForYouSubCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      categoryId = int.parse(Atom.queryParameters['categoryId'] as String);
      title = Uri.decodeFull(Atom.queryParameters['title'] as String);
    } catch (_) {
      return const RbioRouteError();
    }

    return BlocProvider(
      create: (context) =>
          ForYouSubCategoriesCubit(getIt())..fetchCategories(categoryId!),
      child: ForYouSubCategoriesView(title),
    );
  }
}

class ForYouSubCategoriesView extends StatelessWidget {
  String? title;

  ForYouSubCategoriesView(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        title: RbioAppBar.textTitle(context, title!),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ForYouSubCategoriesCubit, ForYouSubCategoriesState>(
      builder: ((context, state) {
        return state.when(
            initial: () => const SizedBox(),
            loadInProgress: () => const RbioLoading(),
            success: (list) => GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: Atom.size.width < 800
                        ? Atom.size.width * 0.45
                        : Atom.size.width * 0.33,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 25,
                  ),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = list[index];

                    return RbioForYouCategoryCard(
                      title: item.text,
                      id: item.id,
                      icon: (item.icon != null)
                          ? Image.memory(base64Decode(item.icon ?? ''))
                          : Image.asset(R.image.covidCat),
                      onTap: () {
                        getIt<IAppConfig>()
                            .platform
                            .adjustManager
                            ?.trackEvent(ForYouSubCategoryClickedEvent());
                        getIt<FirebaseAnalyticsManager>().logEvent(
                            SizeOzelAltKategoriTiklandiEvent(item.text ?? ''));
                        Atom.to(
                          PagePaths.forYouSubCategoriesDetail,
                          queryParameters: {
                            'title': title != null
                                ? Uri.encodeFull(title!)
                                : "No title",
                            'subCategoryId': item.id.toString()
                          },
                        );
                      },
                    );
                  },
                ),
            failure: () => const RbioBodyError());
      }),
    );
  }
}
