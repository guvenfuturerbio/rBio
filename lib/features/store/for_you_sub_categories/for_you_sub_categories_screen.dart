import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'for_you_sub_categories_vm.dart';

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

    return ChangeNotifierProvider<ForUSubCategoriesScreenVm>(
      create: (context) => ForUSubCategoriesScreenVm(context, categoryId),
      child: Consumer<ForUSubCategoriesScreenVm>(
        builder: (
          BuildContext context,
          ForUSubCategoriesScreenVm vm,
          Widget? child,
        ) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(context, title!),
            ),
            body: _buildBody(vm),
          );
        },
      ),
    );
  }

  Widget _buildBody(ForUSubCategoriesScreenVm vm) {
    switch (vm.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: Atom.size.width < 800
                ? Atom.size.width * 0.45
                : Atom.size.width * 0.33,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 25,
          ),
          itemCount: vm.categories.length,
          itemBuilder: (BuildContext context, int index) {
            final item = vm.categories[index];

            return RbioForYouCategoryCard(
              title: item.text,
              id: item.id,
              icon: (item.icon != null)
                  ? Image.memory(base64Decode(item.icon ?? ''))
                  : Image.asset(R.image.covidCat),
              onTap: () {
                getIt<AdjustManager>()
                    .trackEvent(ForYouSubCategoryClickedEvent());
                getIt<FirebaseAnalyticsManager>().logEvent(
                    SizeOzelAltKategoriTiklandiEvent(item.text ?? ''));
                Atom.to(
                  PagePaths.forYouSubCategoriesDetail,
                  queryParameters: {
                    'title':
                        title != null ? Uri.encodeFull(title!) : "No title",
                    'subCategoryId': item.id.toString()
                  },
                );
              },
            );
          },
        );

      case LoadingProgress.error:
        return const RbioBodyError();

      default:
        return const SizedBox();
    }
  }
}
