import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class ForYouCategoriesPageVm extends ChangeNotifier {
  BuildContext? mContext;

  ForYouCategoriesPageVm(BuildContext context) {
    mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchCategories();
    });
  }

  LoadingProgress? progress;

  List<ForYouCategoryResponse> categories = <ForYouCategoryResponse>[];

  Future fetchCategories() async {
    try {
      progress = LoadingProgress.loading;
      notifyListeners();
      categories = await getIt<Repository>().getAllPackage();
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
        return RbioMessageDialog(
          description: text,
          buttonTitle: LocaleProvider.current.ok,
        );
      },
    );
  }
}
