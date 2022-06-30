import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/core.dart';

import '../model/model.dart';
import 'package:universal_html/html.dart' as html;

part 'visit_detail_state.dart';

class VisitDetailCubit extends Cubit<VisitDetailState> {
  VisitDetailCubit(this.repository,
      {required this.countOfLaboratoryResults,
      required this.countOfPathologyResults,
      required this.countOfRadiologyResults,
      required this.visitId,
      required this.patientId})
      : super(VisitDetailState()) {
    {
      visitDetailRequest = VisitDetailRequest(
        patientId: patientId,
        visitId: visitId,
      );
      final currentState = state;
      if (countOfLaboratoryResults > 0) {
        final currentState = state;
        toggleLaboratorySelected(currentState.laboratorySelected);
      } else if (countOfRadiologyResults > 0) {
        toggleRadiologySelected(currentState.radiologySelected);
      } else if (countOfPathologyResults > 0) {
        togglePathologySelected(currentState.pathologySelected);
      }
    }
  }
  late final int countOfLaboratoryResults;
  late final int countOfPathologyResults;
  late final int countOfRadiologyResults;
  late final int visitId;
  late final int patientId;
  late final Repository repository;

  late VisitDetailRequest visitDetailRequest;
  String? mobiletempDocumentPath;
  LaboratoryPdfResultRequest? laboratoryPdfResultRequest;
  static const String _documentPath = 'PDFs/Guide-v4.pdf';

  Future<void> toggleRadiologySelected(bool value) async {
    emit(
      state.copyWith(
        radiologySelected: !value,
        laboratorySelected: false,
        pathologySelected: false,
      ),
    );
    if (!value) {
      await fetchRadiologyResults();
    }
  }

  Future<void> toggleLaboratorySelected(bool value) async {
    emit(
      state.copyWith(
        laboratorySelected: !value,
        pathologySelected: false,
        radiologySelected: false,
      ),
    );
    if (!value) {
      await fetchLaboratoryResults();
      await getLaboratoryResultsAsPdf();
    } else {
      emit(
        state.copyWith(laboratoryFileBytes: null),
      );
    }
  }

  Future<void> togglePathologySelected(bool value) async {
    emit(
      state.copyWith(
        pathologySelected: !value,
        laboratorySelected: false,
        radiologySelected: false,
      ),
    );
    if (!value) {
      await fetchPathologyResults();
    }
  }

  Future<void> fetchPathologyResults() async {
    final currentState = state;
    emit(currentState.copyWith(status: RbioLoadingProgress.loadInProgress));

    try {
      final pathologyResults =
          await getIt<Repository>().getPathologyResults(visitDetailRequest);
      emit(currentState.copyWith(
          pathologyResults: pathologyResults,
          status: RbioLoadingProgress.success));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(currentState.copyWith(status: RbioLoadingProgress.failure));
    }
  }

  Future<void> fetchRadiologyResults() async {
    final currentState = state;
    emit(currentState.copyWith(status: RbioLoadingProgress.loadInProgress));
    try {
      final radiologyResults =
          await getIt<Repository>().getRadiologyResults(visitDetailRequest);
      emit(currentState.copyWith(
          radiologyResults: radiologyResults,
          status: RbioLoadingProgress.success));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(currentState.copyWith(status: RbioLoadingProgress.failure));
    }
  }

  Future<void> fetchLaboratoryResults() async {
    final currentState = state;
    emit(currentState.copyWith(status: RbioLoadingProgress.loadInProgress));

    try {
      final laboratoryResults =
          await getIt<Repository>().getLaboratoryResults(visitDetailRequest);
      setLaboratoryPdfResultRequest();
      emit(currentState.copyWith(
          laboratoryResults: laboratoryResults,
          status: RbioLoadingProgress.success));
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      emit(currentState.copyWith(status: RbioLoadingProgress.failure));
      LoggerUtils.instance.e(e);
    }
  }

  Future<void> downloadPdf(String pdfBytes, bool isLab) async {
    try {
      if (isLab) {
        final decodedBytes = base64Decode(pdfBytes);
        var name = state.laboratoryResults.first.patient;
        name = name?.replaceAll(' ', '_');
        var date = state.laboratoryResults.first.takenAt;
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
        var name = state.radiologyResults.first.patient;
        name = name?.replaceAll(' ', '_');

        var date = state.radiologyResults.first.takenAt;
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
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.e(e);
    }
  }

  Future<void> shareFile() async {
    if (kIsWeb) {
      if (state.laboratoryFileBytes != null) {
        downloadPdf(state.laboratoryFileBytes!, true);
      }
    } else {
      if (state.laboratoryFileBytes != null && mobiletempDocumentPath != null) {
        await FlutterShare.shareFile(
          title: LocaleProvider.current.share,
          text: LocaleProvider.current.detailed_report,
          filePath: mobiletempDocumentPath!,
        );
      }
    }
  }

  Future<void> getLaboratoryResultsAsPdf() async {
    final currentState = state;
    if (laboratoryPdfResultRequest == null) return;

    String pdfByte = await getIt<Repository>()
        .getLaboratoryPdfResult(laboratoryPdfResultRequest!);
    emit(currentState.copyWith(laboratoryFileBytes: pdfByte));
    if (!kIsWeb) {
      final decodedBytes = base64Decode(pdfByte);
      final tempDir = await getTemporaryDirectory();
      final tempDocumentPath = '${tempDir.path}/$_documentPath';
      final file = await File(tempDocumentPath).create(recursive: true);
      file.writeAsBytesSync(decodedBytes);
      mobiletempDocumentPath = tempDocumentPath;
    }
  }

  Future<void> getRadiologyResultsAsPdf(
    int processId,
  ) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
      String pdfByte = await getIt<Repository>().getRadiologyPdfResult(
        RadiologyPdfRequest(processId: processId),
      );
      emit(
        state.copyWith(
          status: RbioLoadingProgress.success,
          isLoading: false,
        ),
      );
      kIsWeb ? downloadPdf(pdfByte, false) : goPdfPage(pdfByte);
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.e(e);
      emit(
        state.copyWith(
          status: RbioLoadingProgress.failure,
          isLoading: false,
        ),
      );
    }
  }

  void showResult(
    String testName,
    String url,
  ) {
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
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.e(e);
    }
  }

  void setLaboratoryPdfResultRequest() {
    final currentState = state;
    List<int> processList = <int>[];
    for (var data in currentState.laboratoryResults) {
      final itemId = data.id;
      if (itemId != null) {
        processList.add(itemId);
      }
    }
    laboratoryPdfResultRequest = LaboratoryPdfResultRequest(
      visitId: visitDetailRequest.visitId,
      processes: processList,
    );
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
    } catch (e, stackTrace) {
      getIt<IAppConfig>()
          .platform
          .sentryManager
          .captureException(e, stackTrace: stackTrace);
      LoggerUtils.instance.e(e);
    }
  }
}
