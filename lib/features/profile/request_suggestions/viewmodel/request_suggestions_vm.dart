import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class RequestSuggestionsScreenVm extends RbioVm {
  @override
  BuildContext mContext;
  RequestSuggestionsScreenVm(this.mContext);

  bool _progressOverlay = false;
  bool get progressOverlay => _progressOverlay;
  set progressOverlay(bool value) {
    _progressOverlay = value;
    notifyListeners();
  }

  String text = '';
  int textLength = 0;
  setText(String text) {
    this.text = text;
    textLength = text.length;
    notifyListeners();
  }

  Future<void> sendSuggestion() async {
    if (text == '') return;

    progressOverlay = true;

    try {
      await getIt<Repository>().addSuggestion(
        SuggestionRequest(suggestionText: text),
      );
      showWarningDialog(
        LocaleProvider.current.info,
        LocaleProvider.current.suggestion_thanks_message,
      );
    } catch (e) {
      notifyListeners();
    } finally {
      progressOverlay = false;
    }
  }

  void showWarningDialog(String title, String text) {
    showDialog(
      context: mContext,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WarningDialog(title, text);
      },
    ).then((value) {
      Atom.to(PagePaths.main, isReplacement: true);
    });
  }
}
