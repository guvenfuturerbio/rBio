import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import 'for_you_information_dialog.dart';
import 'for_you_sub_categories_detail_screen.dart';

class ForYouSubCategoriesDetailScreenVm extends ChangeNotifier {
  ForYouSubCategoriesDetailScreenVm(BuildContext context, var id) {
    this.mContext = context;
    fetchSubCategoryDetail(id);
  }

  BuildContext mContext;

  LoadingProgress _progress;

  bool showLoadingOverlay = false;

  List<ForYouSubCategoryDetailResponse> _subCategoryDetail = <ForYouSubCategoryDetailResponse>[];

  List<ForYouSubCategoryDetailResponse> get subCategoryDetail => this._subCategoryDetail;

  LoadingProgress get progress => this._progress;

  List _cardList;

  List get cardList => this._cardList;

  setCardList() {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    List list = [];
    for (var data in subCategoryDetail) {
      list.add(mopItem(data.image, data.title, data.text));
    }
    this._cardList = list;
    this._progress = LoadingProgress.DONE;
    notifyListeners();
  }

  Future<void> fetchSubCategoryDetail(var id) async {
    try {
      this._progress = LoadingProgress.LOADING;
      notifyListeners();
      List<ForYouSubCategoryDetailResponse> subCategoryDetail =
          await getIt<Repository>().getSubCategoryDetail(id);
      this._subCategoryDetail = subCategoryDetail;
      this._progress = LoadingProgress.DONE;
      notifyListeners();
      setCardList();
    } catch (e) {
      this._progress = LoadingProgress.ERROR;
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      notifyListeners();
    }
  }

  Future<void> addToCart(BuildContext context, String id) async {
    try {
      showLoadingOverlay = true;
      notifyListeners();
      // TODO: API'ye bilgiler gönderilecek.
      await Future.delayed(Duration(seconds: 1));
      showLoadingOverlay = false;
      notifyListeners();

      showDialog(
        context: context,
        barrierColor: Colors.black26,
        builder: (BuildContext context) {
          return ForYouInformationDialog();
        },
      );
      //
    } catch (e) {
      // TODO: Cart expired olduysa, yeni current sepet id'yi getir.
      // TODO: Recursive
    }
  }

  void showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GradientDialog(title, text);
      },
    );
  }
}
