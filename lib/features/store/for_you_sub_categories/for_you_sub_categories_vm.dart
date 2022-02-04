import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class ForUSubCategoriesScreenVm extends ChangeNotifier {
  BuildContext? mContext;

  ForUSubCategoriesScreenVm(BuildContext context, var id) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      mContext = context;
      await fetchCategories(id);
    });
  }

  LoadingProgress? progress;

  List<ForYouCategoryResponse> categories = <ForYouCategoryResponse>[];

  Future<void> fetchCategories(int id) async {
    try {
      progress = LoadingProgress.loading;
      notifyListeners();
      List<ForYouCategoryResponse> categories =
          await getIt<Repository>().getAllSubCategories(id);
      categories = categories;
      progress = LoadingProgress.done;
      notifyListeners();
    } catch (e) {
      progress = LoadingProgress.error;
      showGradientDialog(mContext!, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      notifyListeners();
    }
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    );
  }
}
