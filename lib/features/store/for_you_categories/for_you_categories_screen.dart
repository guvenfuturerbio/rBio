import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
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
        builder: (context, value, child) {
          return Scaffold(
            appBar: MainAppBar(
              context: context,
              title: TitleAppBarWhite(
                title: LocaleProvider.of(context).for_you,
              ),
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

            //
            body: value.progress == LoadingProgress.LOADING
                ? Center(
                    child: progress(),
                  )
                : kIsWeb
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: 50,
                            left: MediaQuery.of(context).size.width < 800
                                ? MediaQuery.of(context).size.width * 0.03
                                : MediaQuery.of(context).size.width * 0.15,
                            right: MediaQuery.of(context).size.width < 800
                                ? MediaQuery.of(context).size.width * 0.03
                                : MediaQuery.of(context).size.width * 0.15),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width < 800
                                    ? MediaQuery.of(context).size.width * 0.45
                                    : MediaQuery.of(context).size.width * 0.33,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 25,
                          ),
                          itemCount: value.categories.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return categoryBox(
                              context: context,
                              title: value.categories[index].text,
                              id: value.categories[index].id,
                              icon: value.categories[index].icon != null
                                  ? Image.memory(base64Decode(
                                      value.categories[index].icon))
                                  : Image.asset(R.image.covid_cat_icon),
                              isSubCat: false,
                            );
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent:
                                  MediaQuery.of(context).size.width < 800
                                      ? MediaQuery.of(context).size.width * 0.45
                                      : MediaQuery.of(context).size.width *
                                          0.33,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 25,
                            ),
                            itemCount: value.categories.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return categoryBox(
                                context: context,
                                title: value.categories[index].text,
                                id: value.categories[index].id,
                                icon: value.categories[index].icon != null
                                    ? Image.memory(base64Decode(
                                        value.categories[index].icon))
                                    : Image.asset(R.image.covid_cat_icon),
                                isSubCat: false,
                              );
                            }),
                      ),
          );
        },
      ),
    );
  }
}
