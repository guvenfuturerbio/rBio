import 'package:flutter/material.dart';

import '../loading_page.dart';

enum PageState { LOADING, IDLE }

class LoadingIndicatorHandler with ChangeNotifier {
  static final LoadingIndicatorHandler _instance =
      LoadingIndicatorHandler._internal();

  factory LoadingIndicatorHandler() {
    return _instance;
  }

  LoadingIndicatorHandler._internal();

  PageState _pageState = PageState.IDLE;

  bool get isLoading => (_pageState == PageState.LOADING);
  PageState get pageState => _pageState;
  LoadingPage loadingPage;

  BuildContext showLoadingContext;

  showLoading(BuildContext context) {
    _pageState = PageState.LOADING;
    showLoadingContext = context;
    notifyListeners();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingPage = loadingPage ?? LoadingPage(""));
  }

  hideLoading() async {
    await Future.delayed(Duration(milliseconds: 500));
    _pageState = PageState.IDLE;
    notifyListeners();
    if (showLoadingContext != null) {
      if (loadingPage != null && loadingPage.isShowing()) {
        Navigator.of(showLoadingContext).pop();
      }
    }
  }
}
