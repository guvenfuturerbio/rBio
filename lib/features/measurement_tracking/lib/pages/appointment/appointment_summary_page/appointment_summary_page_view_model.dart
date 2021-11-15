import 'package:flutter/cupertino.dart';

import '../../../notifiers/user_profiles_notifier.dart';
import '../../../services/user_service.dart';
import '../../additional_info/additional_info_view_model.dart';

class AppointmentSummaryPageViewModel with ChangeNotifier {
  BuildContext context;
  bool _hasIdentificationNumber;
  StateProcess _stateProcess;
  AppointmentSummaryPageViewModel({BuildContext context}) {
    this.context = context;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      checkUserHasIdentification();
    });
  }

  bool get hasIdentificationNumber => this._hasIdentificationNumber;

  Future<void> checkUserHasIdentification() async {
    this._hasIdentificationNumber = await UserService()
        .hasIdentificationNumber(UserProfilesNotifier().selection.id);
    notifyListeners();
  }

  StateProcess get stateProcess => this._stateProcess;
}
