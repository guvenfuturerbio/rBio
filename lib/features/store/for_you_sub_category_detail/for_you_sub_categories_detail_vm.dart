import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';
import 'for_you_information_dialog.dart';
import 'for_you_sub_categories_detail_screen.dart';

class ForYouSubCategoriesDetailScreenVm extends ChangeNotifier {
  ForYouSubCategoriesDetailScreenVm(BuildContext context, var id) {
    mContext = context;
    fetchSubCategoryDetail(id);
  }

  BuildContext? mContext;

  LoadingProgress? progress;

  bool showLoadingOverlay = false;

  List<ForYouSubCategoryDetailResponse> _subCategoryDetail =
      <ForYouSubCategoryDetailResponse>[];

  List<ForYouSubCategoryDetailResponse> get subCategoryDetail =>
      _subCategoryDetail;

  List? cardList;

  void setCardList() {
    progress = LoadingProgress.loading;
    notifyListeners();

    List list = [];
    for (var data in subCategoryDetail) {
      list.add(
        ListCard(
          image: data.image!,
          title: data.title!,
          text: data.text!,
        ),
      );
    }

    cardList = list;
    progress = LoadingProgress.done;
    notifyListeners();
  }

  Future<void> fetchSubCategoryDetail(var id) async {
    try {
      progress = LoadingProgress.loading;
      notifyListeners();
      List<ForYouSubCategoryDetailResponse> subCategoryDetail =
          await getIt<Repository>().getSubCategoryDetail(id);
      _subCategoryDetail = subCategoryDetail;
      progress = LoadingProgress.done;
      notifyListeners();
      setCardList();
    } catch (e) {
      progress = LoadingProgress.error;
      showGradientDialog(mContext!, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      notifyListeners();
    }
  }

  Future<void> addToCart(BuildContext context, String id) async {
    try {
      showLoadingOverlay = true;
      notifyListeners();
      // TODO: API'ye bilgiler gönderilecek.
      await Future.delayed(const Duration(seconds: 1));
      showLoadingOverlay = false;
      notifyListeners();

      showDialog(
        context: context,
        barrierColor: Colors.black26,
        builder: (BuildContext context) {
          return const ForYouInformationDialog();
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
        return RbioMessageDialog(
          description: text,
          buttonTitle: LocaleProvider.current.ok,
        );
      },
    );
  }
}
