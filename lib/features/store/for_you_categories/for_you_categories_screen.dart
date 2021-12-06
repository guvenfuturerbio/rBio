import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import 'for_you_categories_vm.dart';

class ForYouCategoriesScreen extends StatefulWidget {
  const ForYouCategoriesScreen({Key key}) : super(key: key);

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
          Widget child,
        ) {
          return RbioScaffold(
            appbar: RbioAppBar(
              title: RbioAppBar.textTitle(
                context,
                LocaleProvider.of(context).for_you,
              ),
            ),
            body: _buildBody(vm),
          );
        },
      ),
    );
  }

  Widget _buildBody(ForYouCategoriesPageVm vm) {
    switch (vm.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();

      case LoadingProgress.DONE:
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width < 800
                ? MediaQuery.of(context).size.width * 0.45
                : MediaQuery.of(context).size.width * 0.33,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 25,
          ),
          itemCount: vm.categories.length,
          itemBuilder: (BuildContext ctx, int index) {
            return Utils.instance.ForYouCategoryCard(
              context: context,
              title: vm.categories[index].text,
              id: vm.categories[index].id,
              icon: vm.categories[index].icon != null
                  ? Image.memory(base64Decode(vm.categories[index].icon))
                  : Image.asset(R.image.covid_cat_icon),
              isSubCat: false,
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
