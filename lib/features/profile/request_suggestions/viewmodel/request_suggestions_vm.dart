import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class RequestSuggestionsScreenVm extends ChangeNotifier {
  BuildContext mContext;
  String _text;
  int _textLength;
  bool _showProgressOverLay;

  RequestSuggestionsScreenVm({BuildContext context}) {
    this.mContext = context;
  }

  setText(String text) {
    this._text = text;
    this._textLength = text.length;
    notifyListeners();
  }

  String get text => this._text ?? "";

  int get textLength => this._textLength ?? 0;

  bool get showProgressOverlay => this._showProgressOverLay ?? false;

  Future<void> sendSuggestion() async {
    this._showProgressOverLay = true;
    notifyListeners();
    try {
      await getIt<Repository>()
          .addSuggestion(SuggestionRequest(suggestionText: text));
      this._showProgressOverLay = false;
      notifyListeners();
      showGradientDialog(LocaleProvider.current.info,
          LocaleProvider.current.suggestion_thanks_message);
    } catch (e) {
      this._showProgressOverLay = false;
      notifyListeners();
      Navigator.pop(mContext);
    }
  }

  void showGradientDialog(String title, String text) {
    showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    ).then((value) {
      Atom.to(PagePaths.MAIN, isReplacement: true);
    });
  }
}
