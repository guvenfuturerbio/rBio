import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class ForUSubCategoriesScreenVm extends ChangeNotifier {
  BuildContext mContext;
  
  ForUSubCategoriesScreenVm(BuildContext context, var id) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      this.mContext = context;
      await fetchCategories(id);
    });
  }

  LoadingProgress _progress;

  List<ForYouCategoryResponse> _categories = <ForYouCategoryResponse>[];

  List<ForYouCategoryResponse> get categories => this._categories;

  LoadingProgress get progress => this._progress;

  Future<void> fetchCategories(int id) async {
    try {
      this._progress = LoadingProgress.LOADING;
      notifyListeners();
      List<ForYouCategoryResponse> categories =
          await getIt<Repository>().getAllSubCategories(id);
      this._categories = categories;
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e) {
      this._progress = LoadingProgress.ERROR;
      showGradientDialog(mContext, LocaleProvider.current.warning,
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
