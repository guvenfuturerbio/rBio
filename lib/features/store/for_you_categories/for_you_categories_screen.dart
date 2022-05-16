import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'for_you_categories_vm.dart';

class ForYouCategoriesScreen extends StatefulWidget {
  const ForYouCategoriesScreen({Key? key}) : super(key: key);

  @override
  _ForYouCategoriesScreenState createState() => _ForYouCategoriesScreenState();
}

class _ForYouCategoriesScreenState extends State<ForYouCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForYouCategoriesPageVm>(
      create: (context) => ForYouCategoriesPageVm(context),
      child: Consumer<ForYouCategoriesPageVm>(
        builder: (
          BuildContext context,
          ForYouCategoriesPageVm vm,
          Widget? child,
        ) {
          return RbioStackedScaffold(
            appbar: _buildAppBar(context),
            body: _buildBody(vm),
          );
        },
      ),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).for_you,
      ),
    );
  }

  Widget _buildBody(ForYouCategoriesPageVm vm) {
    switch (vm.progress) {
      case LoadingProgress.loading:
        return const RbioLoading();

      case LoadingProgress.done:
        return GridView.builder(
          padding: EdgeInsets.only(
            top: R.sizes.stackedTopPaddingValue(context) + 8,
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width < 800
                ? MediaQuery.of(context).size.width * 0.45
                : MediaQuery.of(context).size.width * 0.33,
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
              icon: item.icon != null
                  ? Image.memory(base64Decode(item.icon ?? ''))
                  : Image.asset(R.image.covidCat),
              onTap: () {
                getIt<AdjustManager>().trackEvent(ForYouCategoryClickedEvent());
                getIt<FirebaseAnalyticsManager>().logEvent(
                  SizeOzelKategoriTiklandiEvent(
                    item.text ?? '',
                  ),
                );

                Atom.to(
                  PagePaths.forYouSubCategories,
                  queryParameters: {
                    'title': item.text != null
                        ? Uri.encodeFull(item.text!)
                        : "No title",
                    'categoryId': item.id.toString(),
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
