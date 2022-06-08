import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class OrderSummaryScreenVm extends ChangeNotifier {
  OrderSummaryScreenVm(BuildContext context, var id) {
    mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchSubCategoryItems(id);
      setSelectedItem(subCategoryItems![0]);
    });
  }

  int? selectedIndex;

  BuildContext? mContext;

  List<ForYouSubCategoryItemsResponse>? subCategoryItems;

  LoadingProgress? progress;

  ForYouSubCategoryItemsResponse? selectedItem;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void setSelectedItem(ForYouSubCategoryItemsResponse subCategoryItems) {
    selectedItem = subCategoryItems;
    notifyListeners();
  }

  fetchSubCategoryItems(String id) async {
    try {
      progress = LoadingProgress.loading;
      notifyListeners();
      subCategoryItems = await getIt<Repository>().getSubCategoryItems(id);
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

  void showWebViewPage() {
    Atom.to(
      PagePaths.webView,
      queryParameters: {
        'url': Uri.encodeFull(selectedItem!.url!),
        'title': Uri.encodeFull(selectedItem!.title ?? "No title"),
      },
    );
  }
}
