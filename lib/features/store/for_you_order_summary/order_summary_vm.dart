import 'package:flutter/material.dart';
import 'package:vrouter/src/core/extended_context.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class OrderSummaryScreenVm extends ChangeNotifier {
  OrderSummaryScreenVm(BuildContext context, var id) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchSubCategoryItems(id);
      setSelectedItem(subCategoryItems[0]);
    });
  }
  int _index;

  BuildContext mContext;

  List<ForYouSubCategoryItemsResponse> _subCategoryItems;

  List<ForYouSubCategoryItemsResponse> get subCategoryItems =>
      this._subCategoryItems;

  LoadingProgress _progress;

  LoadingProgress get progress => this._progress ?? LoadingProgress.LOADING;

  ForYouSubCategoryItemsResponse _selectedItem;

  ForYouSubCategoryItemsResponse get selectedItem => this._selectedItem;

  int get selectedIndex => this._index ?? 0;

  void setSelectedIndex(int index) {
    this._index = index;
    notifyListeners();
  }

  void setSelectedItem(ForYouSubCategoryItemsResponse subCategoryItems) {
    this._selectedItem = subCategoryItems;
    notifyListeners();
  }

  fetchSubCategoryItems(String id) async {
    try {
      this._progress = LoadingProgress.LOADING;
      notifyListeners();
      this._subCategoryItems =
          await getIt<Repository>().getSubCategoryItems(id);
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

  void showWebViewPage() {
    Atom.to(
      PagePaths.WEBVIEW,
      queryParameters: {
        'url': Uri.encodeFull(selectedItem.url),
        'title': Uri.encodeFull(selectedItem.title),
      },
    );
  }
}
