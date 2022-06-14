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

  final AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;
  AutovalidateMode? get autovalidateMode => _autovalidateMode;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState>? get formKey => _formKey;

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
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
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
        return RbioMessageDialog(
          description: text,
          buttonTitle: LocaleProvider.current.ok,
        );
      },
    ).then((value) {
      Atom.to(PagePaths.main, isReplacement: true);
    });
  }
}
