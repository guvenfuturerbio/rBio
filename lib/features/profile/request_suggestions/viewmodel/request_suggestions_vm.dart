import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class RequestSuggestionsScreenVm extends ChangeNotifier {
  BuildContext mContext;

  bool _progressOverlay = false;
  bool get progressOverlay => _progressOverlay;
  set progressOverlay(bool value) {
    _progressOverlay = value;
    notifyListeners();
  }

  RequestSuggestionsScreenVm({BuildContext context}) {
    this.mContext = context;
  }

  String _text;
  int _textLength;

  int get textLength => this._textLength ?? 0;
  String get text => this._text ?? "";

  setText(String text) {
    this._text = text;
    this._textLength = text.length;
    notifyListeners();
  }

  Future<void> sendSuggestion() async {
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
      Atom.to(PagePaths.MAIN, isReplacement: true);
    });
  }
}
