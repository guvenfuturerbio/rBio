import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;

import '../../../../core/core.dart';
import '../../../../model/model.dart';

class VisitDetailScreenVm extends RbioVm {
  @override
  BuildContext mContext;

  static const String _documentPath = 'PDFs/Guide-v4.pdf';

  late VisitDetailRequest visitDetailRequest;

  String? laboratoryFileBytes;
  String? mobiletempDocumentPath;

  bool pathologySelected = false;
  bool radiologySelected = false;
  bool laboratorySelected = false;

  List<LaboratoryResponse> laboratoryResults = [LaboratoryResponse()];
  List<PathologyResponse> pathologyResults = [PathologyResponse()];
  List<RadiologyResponse> radiologyResults = [RadiologyResponse()];
  LaboratoryPdfResultRequest? laboratoryPdfResultRequest;

  VisitDetailScreenVm(
    this.mContext, {
    required int countOfLaboratoryResults,
    required int countOfPathologyResults,
    required int countOfRadiologyResults,
    required int visitId,
    required int patientId,
  }) {
    visitDetailRequest = VisitDetailRequest(
      patientId: patientId,
      visitId: visitId,
    );
    if (countOfLaboratoryResults > 0) {
      toggleLaboratorySelected();
    } else if (countOfRadiologyResults > 0) {
      toggleRadiologySelected();
    } else if (countOfPathologyResults > 0) {
      togglePathologySelected();
    }
  }

  Future<void> togglePathologySelected() async {
    pathologySelected = !pathologySelected;
    if (pathologySelected) {
      laboratorySelected = false;
      radiologySelected = false;
      await fetchPathologyResults();
    }
    notifyListeners();
  }

  Future<void> toggleRadiologySelected() async {
    radiologySelected = !radiologySelected;
    if (radiologySelected) {
      laboratorySelected = false;
      pathologySelected = false;
      await fetchRadiologyResults();
    }

    notifyListeners();
  }

  Future<void> toggleLaboratorySelected() async {
    laboratorySelected = !laboratorySelected;
    if (laboratorySelected) {
      pathologySelected = false;
      radiologySelected = false;
      await fetchLaboratoryResults();
      await getLaboratoryResultsAsPdf();
    } else {
      laboratoryFileBytes = null;
    }

    notifyListeners();
  }

  Future<void> fetchPathologyResults() async {
    progress = LoadingProgress.loading;
    notifyListeners();

    try {
      pathologyResults =
          await getIt<Repository>().getPathologyResults(visitDetailRequest);
      progress = LoadingProgress.done;
    } catch (e) {
      progress = LoadingProgress.error;
    }
  }

  Future<void> fetchRadiologyResults() async {
    progress = LoadingProgress.loading;

    try {
      radiologyResults =
          await getIt<Repository>().getRadiologyResults(visitDetailRequest);
      progress = LoadingProgress.done;
    } catch (e) {
      progress = LoadingProgress.error;
    }
  }

  Future<void> downloadPdf(String pdfBytes, bool isLab) async {
    try {
      if (isLab) {
        final decodedBytes = base64Decode(pdfBytes);
        var name = laboratoryResults.first.patient;
        name = name?.replaceAll(' ', '_');
        var date = laboratoryResults.first.takenAt;
        html.Blob blob = html.Blob([decodedBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement()
          ..href = url
          ..style.display = 'none'
          ..download = 'guven_lab_' +
              (name ?? '') +
              (date?.toIso8601String() ?? '') +
              '.pdf';
        html.document.body?.children.add(anchor);
        anchor.click();
        html.document.body?.children.remove(anchor);
        html.Url.revokeObjectUrl(url);
      } else {
        final decodedBytes = base64Decode(pdfBytes);
        var name = radiologyResults.first.patient;
        name = name?.replaceAll(' ', '_');

        var date = radiologyResults.first.takenAt;
        html.Blob blob = html.Blob([decodedBytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement()
          ..href = url
          ..style.display = 'none'
          ..download =
              'guven_radyoloji_' + (name ?? '') + (date ?? '') + '.pdf';
        html.document.body?.children.add(anchor);
        anchor.click();
        html.document.body?.children.remove(anchor);
        html.Url.revokeObjectUrl(url);
      }
    } catch (e) {
      LoggerUtils.instance.e(e);
    }
  }

  Future<void> fetchLaboratoryResults() async {
    progress = LoadingProgress.loading;

    try {
      laboratoryResults =
          await getIt<Repository>().getLaboratoryResults(visitDetailRequest);
      setLaboratoryPdfResultRequest();
      progress = LoadingProgress.done;
    } catch (e) {
      progress = LoadingProgress.error;
      LoggerUtils.instance.e(e);
    }
  }

  Future<void> shareFile() async {
    if (laboratoryFileBytes != null && mobiletempDocumentPath != null) {
      if (kIsWeb) {
        downloadPdf(laboratoryFileBytes!, true);
      } else {
        await FlutterShare.shareFile(
          title: LocaleProvider.current.share,
          text: LocaleProvider.current.detailed_report,
          filePath: mobiletempDocumentPath!,
        );
      }
    }
  }

  Future<void> getLaboratoryResultsAsPdf() async {
    if (laboratoryPdfResultRequest == null) return;

    String pdfByte = await getIt<Repository>()
        .getLaboratoryPdfResult(laboratoryPdfResultRequest!);
    laboratoryFileBytes = pdfByte;
    if (!kIsWeb) {
      final decodedBytes = base64Decode(pdfByte);
      final tempDir = await getTemporaryDirectory();
      final tempDocumentPath = '${tempDir.path}/$_documentPath';
      final file = await File(tempDocumentPath).create(recursive: true);
      file.writeAsBytesSync(decodedBytes);
      mobiletempDocumentPath = tempDocumentPath;
    }
    notifyListeners();
  }

  Future<void> getRadiologyResultsAsPdf(int processId) async {
    try {
      String pdfByte = await getIt<Repository>().getRadiologyPdfResult(
        RadiologyPdfRequest(processId: processId),
      );

      kIsWeb ? downloadPdf(pdfByte, false) : goPdfPage(pdfByte);
      notifyListeners();
    } catch (e) {
      LoggerUtils.instance.e(e);
      notifyListeners();
    }
  }

  void showResult(String testName, String url) {
    try {
      if (kIsWeb) {
        html.window.open(url, 'new tab');
      } else {
        Atom.to(
          PagePaths.webView,
          queryParameters: {
            'url': Uri.encodeFull(url),
            'title': Uri.encodeFull(testName),
          },
        );
      }
    } catch (e) {
      LoggerUtils.instance.e(e);
    }
  }

  void setLaboratoryPdfResultRequest() {
    List<int> processList = <int>[];
    for (var data in laboratoryResults) {
      final itemId = data.id;
      if (itemId != null) {
        processList.add(itemId);
      }
    }
    laboratoryPdfResultRequest = LaboratoryPdfResultRequest(
      visitId: visitDetailRequest.visitId,
      processes: processList,
    );
    notifyListeners();
  }

  Future<void> goPdfPage(String img64) async {
    try {
      final decodedBytes = base64Decode(img64);
      final tempDir = await getTemporaryDirectory();
      final tempDocumentPath = '${tempDir.path}/$_documentPath';
      final file = await File(tempDocumentPath).create(recursive: true);
      file.writeAsBytesSync(decodedBytes);
      Atom.to(
        PagePaths.fullPdfViewer,
        queryParameters: {
          'title': Uri.encodeFull(LocaleProvider.current.detailed_report),
          'pdfPath': Uri.encodeFull(tempDocumentPath),
        },
      );
    } catch (e) {
      LoggerUtils.instance.e(e);
    }
  }
}
