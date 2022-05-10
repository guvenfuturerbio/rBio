import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/core.dart';

class ServerFile {
  String? folder;
  String? file;
  String? fileType;

  ServerFile({
    this.folder,
    this.file,
    this.fileType,
  });
}

class AllFilesVm extends RbioVm {
  @override
  BuildContext mContext;

  bool _showProgressOverlay = false;
  bool get showProgressOverlay => _showProgressOverlay;
  set showProgressOverlay(bool value) {
    _showProgressOverlay = value;
    notifyListeners();
  }

  AllFilesVm(this.mContext) {
    final widgetsBinding = WidgetsBinding.instance;
    if (widgetsBinding != null) {
      widgetsBinding.addPostFrameCallback((_) {
        fetchAllFiles();
      });
    }
  }

  List<ServerFile> fileLists = [];

  Future<void> fetchAllFiles() async {
    try {
      progress = LoadingProgress.loading;
      final response = await getIt<Repository>().getAllFiles();
      final datum = response.datum;
      if (datum != null && datum is List<dynamic>) {
        for (var data in datum) {
          var folder = data.toString().split("/")[0];
          var file = data.toString().replaceFirst('$folder/', "");
          var fileType = getFileType(file);
          fileLists.add(
            ServerFile(
              folder: folder,
              file: file,
              fileType: fileType,
            ),
          );
        }
      }
      progress = LoadingProgress.done;
    } catch (e, stackTrace) {
      showDefaultErrorDialog(e, stackTrace);
      progress = LoadingProgress.error;
    }
  }

  String getFileType(String fileName) {
    File file = File(fileName);
    return file.path.split('.').last;
  }

  void onFileTapped(ServerFile serverFile) async {
    try {
      showProgressOverlay = true;
      final response = await getIt<Repository>().downloadAppointmentSingleFile(
        serverFile.folder ?? '',
        serverFile.file ?? '',
      );
      final bytes = base64.decode(response.datum);
      var file = File("");
      file =
          File('${getIt<GuvenSettings>().appDocDirectory}/${serverFile.file}');
      await file.writeAsBytes(bytes);
      final fileNameSplit = serverFile.file?.split(".");
      final mimeType = fileNameSplit?[fileNameSplit.length - 1];
      showProgressOverlay = false;
      if (mimeType == "pdf") {
        Atom.to(
          PagePaths.fullPdfViewer,
          queryParameters: {
            'title': Uri.encodeFull(serverFile.file ?? ''),
            'pdfPath': Uri.encodeFull(file.path),
          },
        );
      } else {
        Atom.show(
          RbioImagePreviewDialog(
            fileImage: file,
          ),
        );
      }
    } catch (e) {
      showProgressOverlay = false;
    }
  }
}
