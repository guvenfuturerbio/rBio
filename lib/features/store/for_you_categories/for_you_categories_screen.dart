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
          return RbioScaffold(
              appbar: RbioAppBar(
                title: TitleAppBarWhite(
                  title: LocaleProvider.of(context).for_you,
                ),
              ),

              //
              body: value.progress == LoadingProgress.LOADING
                  ? RbioLoading()
                  : _buildBody(context, value));
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ForYouCategoriesPageVm value) {
    switch (value.progress) {
      case LoadingProgress.LOADING:
        return RbioLoading();
        break;
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
          itemCount: value.categories.length,
          itemBuilder: (BuildContext ctx, index) {
            return categoryBox(
              context: context,
              title: value.categories[index].text,
              id: value.categories[index].id,
              icon: value.categories[index].icon != null
                  ? Image.memory(base64Decode(value.categories[index].icon))
                  : Image.asset(R.image.covid_cat_icon),
              isSubCat: false,
            );
          },
        );
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
