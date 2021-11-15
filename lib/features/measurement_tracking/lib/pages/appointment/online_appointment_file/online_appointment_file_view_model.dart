import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../generated/l10n.dart';
import '../../../helper/loading_dialog.dart';
import '../../../helper/resources.dart';
import '../../../notifiers/user_profiles_notifier.dart';
import '../../../services/appointment_service.dart';
import '../../../widgets/gradient_dialog.dart';
import '../../additional_info/additional_info_view_model.dart';

class OnlineAppointmentFileViewModel extends ChangeNotifier {
  StateProcess _stateProcess;
  List<String> _appointmentFiles;
  BuildContext context;
  String _selectedFile;
  var _webAppointmentId;
  LoadingDialog _loadingDialog;
  OnlineAppointmentFileViewModel({BuildContext context, var webAppointmentId}) {
    this.context = context;
    this._webAppointmentId = webAppointmentId;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchFiles(webAppointmentId);
    });
  }
  Future<void> fetchFiles(var webAppointmentId) async {
    this._stateProcess = StateProcess.LOADING;
    showLoadingDialog(context);
    notifyListeners();
    try {
      this._appointmentFiles = await AppointmentService().fetchAppointmentFiles(
          UserProfilesNotifier().selection.id, webAppointmentId);
      this._stateProcess = StateProcess.DONE;
      hideDialog(context);
      notifyListeners();
    } catch (e) {
      this._stateProcess = StateProcess.ERROR;
      hideDialog(context);
      notifyListeners();
    }
  }

  List<String> get appointmentFiles => this._appointmentFiles;

  StateProcess get stateProcess => this._stateProcess;

  selectFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['svg', 'pdf', 'png', 'jpg', 'bmp'],
        allowMultiple: false);
    if (result != null) {
      String selected = result?.files?.elementAt(0)?.path ?? " ";
      uploadFile(webAppointmentId, selected);
      notifyListeners();
    }
  }

  uploadFile(var webAppointmentId, var file) async {
    this._stateProcess = StateProcess.LOADING;
    showLoadingDialog(context);
    notifyListeners();
    try {
      var result = await AppointmentService().uploadFileToAppointment(
          UserProfilesNotifier().selection.id, webAppointmentId, file);
      this._stateProcess = StateProcess.DONE;
      hideDialog(context);
      notifyListeners();
      result
          ? fetchFiles(webAppointmentId)
          : showInformationDialog(
              LocaleProvider.current.sorry_dont_transaction);
    } catch (e) {
      this._stateProcess = StateProcess.ERROR;
      hideDialog(context);
      notifyListeners();
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
    }
  }

  downloadFile(var webAppointmentId, var file) async {
    showLoadingDialog(context);
    try {
      Uint8List result = await AppointmentService().downloadFile(
          UserProfilesNotifier().selection.id, webAppointmentId, file);
      String dir = (await getApplicationDocumentsDirectory()).path;
      file = new File('$dir/$file');
      await file.writeAsBytes(result);
      hideDialog(context);
      Navigator.of(context)
          .pushNamed(Routes.FILE_VIEWER, arguments: (file as File).path);
    } catch (e) {
      hideDialog(context);
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
    }
  }

  deleteFile(var webAppointmentId, var file) async {
    showLoadingDialog(context);
    try {
      bool result = await AppointmentService().deleteFile(
          UserProfilesNotifier().selection.id, webAppointmentId, file);
      hideDialog(context);
      result == true
          ? fetchFiles(webAppointmentId)
          : showInformationDialog(
              LocaleProvider.current.sorry_dont_transaction);
    } catch (e) {
      hideDialog(context);
      showInformationDialog(LocaleProvider.current.sorry_dont_transaction);
    }
  }

  showInformationDialog(String text) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return GradientDialog(LocaleProvider.current.warning, text);
        });
  }

  get webAppointmentId => this._webAppointmentId;

  LoadingDialog get loadingDialog => this._loadingDialog;

  void showLoadingDialog(BuildContext context) async {
    await new Future.delayed(new Duration(milliseconds: 30));
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            this._loadingDialog = loadingDialog ?? LoadingDialog());
    notifyListeners();
  }

  hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      this._loadingDialog = null;
      notifyListeners();
    }
  }

  String get selectedFile => this._selectedFile;
}
