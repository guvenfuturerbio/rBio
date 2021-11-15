import 'package:flutter/material.dart';
import 'package:path/path.dart';

enum FileType { PDF, IMAGE }

class FileViewerPageViewModel extends ChangeNotifier {
  String _filePath;
  FileType _fileType;
  String _title;
  FileViewerPageViewModel({String filePath}) {
    this._filePath = filePath;
    setFileType();
    setFileTitle();
  }

  FileType get fileType => this._fileType;

  String get title => this._title;

  String get filePath => this._filePath;

  setFileType() {
    List<String> fileNameSplit = filePath.split(".");
    String mimeType = fileNameSplit[fileNameSplit.length - 1].toLowerCase();
    mimeType == "pdf"
        ? this._fileType = FileType.PDF
        : this._fileType = FileType.IMAGE;
    notifyListeners();
  }

  setFileTitle() {
    this._title = basename(filePath);
    notifyListeners();
  }
}
