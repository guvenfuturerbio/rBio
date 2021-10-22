import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class TenantListPageVm extends ChangeNotifier {
  List<FilterTenantsResponse> _tenantsFilterResponse;
  BuildContext mContext;
  LoadingProgress _progress;

  TenantListPageVm({BuildContext context}) {
    this.mContext = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchTenants();
    });
  }

  LoadingProgress get progress => this._progress;

  Future<void> fetchTenants() async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      this._tenantsFilterResponse = await getIt<Repository>()
          .filterTenants(FilterTenantsRequest(departmanId: null));
      this._tenantsFilterResponse =
          removeOtherTenants(this._tenantsFilterResponse);
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      print("fetchTenants error " + e.toString());
      showGradientDialog(mContext, LocaleProvider.current.warning,
          LocaleProvider.current.sorry_dont_transaction);
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  List<FilterTenantsResponse> get tenantsFilterResponse =>
      this._tenantsFilterResponse;

  showGradientDialog(BuildContext context, String title, String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(title, text);
        });
  }

  List<FilterTenantsResponse> removeOtherTenants(
      List<FilterTenantsResponse> tenantsResponse) {
    try {
      final onlineAppoTenant = FilterTenantsResponse(enabled: true, id: -1);
      var removedTenants = <FilterTenantsResponse>[];
      for (var data in tenantsResponse) {
        if (data.id == 1 || data.id == 7) {
          removedTenants.add(data);
        }
      }
      removedTenants.add(onlineAppoTenant);
      return removedTenants;
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return null;
    }
  }
}
