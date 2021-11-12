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
          return Scaffold(
            appBar: MainAppBar(
              context: context,
              title: TitleAppBarWhite(title: title),
              leading: ButtonBackWhite(context),
              actions: [
                // IconButton(
                //   onPressed: () {
                //     Atom.to(PagePaths.SHOPPING_CART);
                //   },
                //   icon: Icon(
                //     Icons.shopping_cart,
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
            body: value.progress == LoadingProgress.LOADING
                ? RbioLoading()
                : kIsWeb
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: 50,
                            left: Atom.size.width < 800
                                ? Atom.size.width * 0.03
                                : Atom.size.width * 0.10,
                            right: Atom.size.width < 800
                                ? Atom.size.width * 0.03
                                : Atom.size.width * 0.10),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
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
                                    ? Image.memory(base64Decode(
                                        value.categories[index].icon))
                                    : Image.asset(R.image.covid_cat_icon),
                                isSubCat: true,
                              );
                            }),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
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
                                    ? Image.memory(base64Decode(
                                        value.categories[index].icon))
                                    : Image.asset(R.image.covid_cat_icon),
                                isSubCat: true,
                              );
                            }),
                      ),
          );
        },
      ),
    );
  }
}
