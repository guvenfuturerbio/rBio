import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class ResourcesScreenVm extends ChangeNotifier {
  List<FilterResourcesResponse> _filterResources;
  LoadingProgress _progress;
  BuildContext mContext;

  ResourcesScreenVm({
    BuildContext context,
    int departmentId,
    int tenantId,
  }) {
    this.mContext = context;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchResources(
        FilterResourcesRequest(
          tenantId: tenantId,
          departmentId: departmentId,
          search: null,
        ),
      );

      if (_filterResources.length == 0) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return GuvenAlert(
              backgroundColor: Colors.white,
              title: GuvenAlert.buildTitle("Üzgünüz"),
              actions: [
                GuvenAlert.buildMaterialAction(
                  "Ok",
                  () {
                    Navigator.pop(context);
                  },
                ),
              ],

              //
              content: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GuvenAlert.buildDescription(
                      "Bu bölümünde şuanlık uygun doktor bulunmamaktadır. Lütfen bizimle iletişime geçiniz",
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

  List<FilterResourcesResponse> get filterResources => this._filterResources;

  LoadingProgress get progress => this._progress;

  Future<void> fetchResources(
      FilterResourcesRequest filterResourcesRequest) async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      this._filterResources =
          await getIt<Repository>().filterResources(filterResourcesRequest);
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      print("fetch Resources error " + e.toString());
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
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
}
