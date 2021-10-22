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
              title: Text(
                "Üzgünüz",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
              content: Container(
                padding: const EdgeInsets.all(16.0),
                /*decoration: new BoxDecoration(
            gradient: BlueGradient()),*/
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(
                        "Bu bölümünde şuanlık uygun doktor bulunmamaktadır. Lütfen bizimle iletişime geçiniz",
                        style: new TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Roboto',
                          color: Colors.white,
                        )),
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

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return GradientDialog(title, text);
      },
    );
  }
}
