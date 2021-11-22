import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

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
        builder: (context, value, child) {
          return RbioScaffold(
              appbar: RbioAppBar(
                title: TitleAppBarWhite(title: title),
              ),
              body: _buildBody(value, context));
        },
      ),
    );
  }

  Widget _buildBody(ForUSubCategoriesScreenVm value, BuildContext context) {
    switch (value.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();
        break;
      case LoadingProgress.DONE:
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: Atom.size.width < 800
                    ? Atom.size.width * 0.45
                    : Atom.size.width * 0.33,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 25),
            itemCount: value.categories.length,
            itemBuilder: (BuildContext ctx, index) {
              return categoryBox(
                context: context,
                title: value.categories[index].text,
                id: value.categories[index].id,
                icon: (value?.categories[index]?.icon != null)
                    ? Image.memory(base64Decode(value.categories[index].icon))
                    : Image.asset(R.image.covid_cat_icon),
                isSubCat: true,
              );
            });
        break;
      case LoadingProgress.ERROR:
        return Center(
          child: Text("Error!"),
        );
        break;
      default:
        return SizedBox();
    }
  }
}
