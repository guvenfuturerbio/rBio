import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class VisitDetailScreenVm extends ChangeNotifier {
  BuildContext mContext;

  LoadingDialog loadingDialog;
  static const String _documentPath = 'PDFs/Guide-v4.pdf';
  bool _pathologySelected;
  bool _radiologySelected;
  bool _laboratorySelected;
  VisitDetailRequest _visitDetailRequest;
  List<LaboratoryResponse> _laboratoryResults;
  List<PathologyResponse> _pathologyResults;
  List<RadiologyResponse> _radiologyResults;
  LaboratoryPdfResultRequest _laboratoryPdfResultRequest;
  LoadingProgress _progress;

  VisitDetailScreenVm({
    BuildContext context,
    int countOfLaboratoryResults,
    int countOfPathologyResults,
    int countOfRadiologyResults,
    int visitId,
    int patientId,
  }) {
    this.mContext = context;
    this._visitDetailRequest =
        VisitDetailRequest(patientId: patientId, visitId: visitId);
    if (countOfLaboratoryResults > 0) {
      toggleLaboratorySelected();
    } else if (countOfRadiologyResults > 0) {
      toggleRadiologySelected();
    } else if (countOfPathologyResults > 0) {
      togglePathologySelected();
    }
  }

  get progress => this._progress ?? LoadingProgress.LOADING;

  get pathologySelected => this._pathologySelected ?? false;

  get radiologySelected => this._radiologySelected ?? false;

  get laboratorySelected => this._laboratorySelected ?? false;

  VisitDetailRequest get visitDetailRequest => this._visitDetailRequest;

  togglePathologySelected() async {
    this._pathologySelected = !pathologySelected;
    if (pathologySelected) {
      this._laboratorySelected = false;
      this._radiologySelected = false;
      await fetchPathologyResults();
    }
    notifyListeners();
  }

  toggleRadiologySelected() async {
    this._radiologySelected = !radiologySelected;
    if (radiologySelected) {
      this._laboratorySelected = false;
      this._pathologySelected = false;
      await fetchRadiologyResults();
    }
    notifyListeners();
  }

  toggleLaboratorySelected() async {
    this._laboratorySelected = !laboratorySelected;
    if (laboratorySelected) {
      this._pathologySelected = false;
      this._radiologySelected = false;
      await fetchLaboratoryResults();
    }
    notifyListeners();
  }

  Future<void> fetchPathologyResults() async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      this._pathologyResults =
          await getIt<Repository>().getPathologyResults(visitDetailRequest);
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      print(e.toString());
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  List<PathologyResponse> get pathologyResults =>
      this._pathologyResults ?? [PathologyResponse()];

  Future<void> fetchRadiologyResults() async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      this._radiologyResults = await await getIt<Repository>()
          .getRadiologyResults(visitDetailRequest);
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      print(e.toString());
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  Future<void> downloadPdf(String pdfBytes, bool isLab) async {
    try {
      if (isLab) {
        final decodedBytes = base64Decode(pdfBytes);
        var name = _laboratoryResults.first.patient;
        name = name.replaceAll(' ', '_');
        var date = _laboratoryResults.first.takenAt;
        html.Blob blob = html.Blob([decodedBytes]);
        final url = await html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement()
          ..href = url
          ..style.display = 'none'
          ..download = 'guven_lab_' + name + date.toIso8601String() + '.pdf';
        html.document.body.children.add(anchor);
        anchor.click();
        html.document.body.children.remove(anchor);
        html.Url.revokeObjectUrl(url);
      } else {
        final decodedBytes = base64Decode(pdfBytes);
        var name = _radiologyResults.first.patient;
        name = name.replaceAll(' ', '_');

        var date = _radiologyResults.first.takenAt;
        html.Blob blob = html.Blob([decodedBytes]);
        final url = await html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement()
          ..href = url
          ..style.display = 'none'
          ..download = 'guven_radyoloji_' + name + date + '.pdf';
        html.document.body.children.add(anchor);
        anchor.click();
        html.document.body.children.remove(anchor);
        html.Url.revokeObjectUrl(url);
      }
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  List<RadiologyResponse> get radiologyResult =>
      this._radiologyResults ?? [RadiologyResponse()];

  Future<void> fetchLaboratoryResults() async {
    this._progress = LoadingProgress.LOADING;
    notifyListeners();
    try {
      this._laboratoryResults =
          await getIt<Repository>().getLaboratoryResults(visitDetailRequest);
      setLaboratoryPdfResultRequest();
      this._progress = LoadingProgress.DONE;
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      print(e.toString());
      this._progress = LoadingProgress.ERROR;
      notifyListeners();
    }
  }

  List<LaboratoryResponse> get laboratoryResults =>
      this._laboratoryResults ?? [LaboratoryResponse()];

  Future<void> getLaboratoryResultsAsPdf() async {
    showLoadingDialog(mContext);
    try {
      String pdfByte = await getIt<Repository>()
          .getLaboratoryPdfResult(laboratoryPdfResultRequest);
      hideDialog(mContext);
      kIsWeb ? downloadPdf(pdfByte, true) : goPdfPage(pdfByte);
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      hideDialog(mContext);
      print(e.toString());
      notifyListeners();
    }
  }

  Future<void> getRadiologyResultsAsPdf(int processId) async {
    showLoadingDialog(mContext);
    try {
      String pdfByte = await getIt<Repository>().getRadiologyPdfResult(
        RadiologyPdfRequest(processId: processId),
      );
      ;
      hideDialog(mContext);
      kIsWeb ? downloadPdf(pdfByte, false) : goPdfPage(pdfByte);
      notifyListeners();
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      hideDialog(mContext);
      print(e.toString());
      notifyListeners();
    }
  }

  void showResult(String testName, String url) {
    try {
      if (kIsWeb) {
        html.window.open(url, 'new tab');
      } else {
        Atom.to(
          PagePaths.WEBVIEW,
          queryParameters: {
            'url': Uri.encodeFull(url),
            'title': Uri.encodeFull(testName),
          },
        );
      }
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  setLaboratoryPdfResultRequest() {
    List<int> processList = List<int>();
    for (var data in laboratoryResults) {
      processList.add(data.id);
    }
    this._laboratoryPdfResultRequest = LaboratoryPdfResultRequest(
        visitId: visitDetailRequest.visitId, processes: processList);
    notifyListeners();
  }

  get laboratoryPdfResultRequest => this._laboratoryPdfResultRequest;

  Future<void> goPdfPage(String img64) async {
    try {
      final decodedBytes = base64Decode(img64);
      final tempDir = await getTemporaryDirectory();
      final tempDocumentPath = '${tempDir.path}/$_documentPath';
      final file = await File(tempDocumentPath).create(recursive: true);
      file.writeAsBytesSync(decodedBytes);
      Atom.to(
        PagePaths.FULLPDFVIEWER,
        queryParameters: {
          'title': Uri.encodeFull(LocaleProvider.current.detailed_report),
          'pdfPath': Uri.encodeFull(tempDocumentPath),
        },
      );
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  void showLoadingDialog(BuildContext context) async {
    await new Future.delayed(new Duration(milliseconds: 30));
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
  }

  hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }
}
