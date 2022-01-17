import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'for_you_sub_categories_vm.dart';

class ForYouSubCategoriesScreen extends StatelessWidget {
  int categoryId;
  String title;

  ForYouSubCategoriesScreen({
    Key key,
    this.categoryId,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      categoryId = int.parse(Atom.queryParameters['categoryId']);
      title = Uri.decodeFull(Atom.queryParameters['title']);
    } catch (_) {
      return RbioRouteError();
    }

    return ChangeNotifierProvider<ForUSubCategoriesScreenVm>(
      create: (context) => ForUSubCategoriesScreenVm(context, categoryId),
      child: Consumer<ForUSubCategoriesScreenVm>(
        builder: (
          BuildContext context,
          ForUSubCategoriesScreenVm vm,
          Widget child,
        ) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                title,
              ),
            ),
            body: _buildBody(vm),
          );
        },
      ),
    );
  }

  Widget _buildBody(ForUSubCategoriesScreenVm vm) {
    switch (vm.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
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
            return Utils.instance.ForYouCategoryCard(
              context: context,
              title: vm.categories[index].text,
              id: vm.categories[index].id,
              icon: (vm?.categories[index]?.icon != null)
                  ? Image.memory(base64Decode(vm.categories[index].icon))
                  : Image.asset(R.image.covid_cat_icon),
              isSubCat: true,
            );
          },
        );

      case LoadingProgress.ERROR:
        return RbioBodyError();

      default:
        return SizedBox();
    }
  }
}
