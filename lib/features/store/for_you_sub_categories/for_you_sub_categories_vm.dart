import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import '../../../config/config.dart';

class ForUSubCategoriesScreenVm extends ChangeNotifier {
  BuildContext? mContext;

  ForUSubCategoriesScreenVm(BuildContext context, var id) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
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
      categories = await getIt<Repository>().getAllSubCategories(id);
      progress = LoadingProgress.done;
      notifyListeners();
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      progress = LoadingProgress.error;
      showGradientDialog(
        mContext!,
        LocaleProvider.current.warning,
        LocaleProvider.current.sorry_dont_transaction,
      );
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
          isAtom: false,
        );
      },
    );
  }
}
