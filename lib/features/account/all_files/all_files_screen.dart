import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/core.dart';
import '../../../model/model.dart';

class ServerFile {
  String folder;
  String file;

  ServerFile(this.folder, this.file);
}

class AllFilesScreen extends StatefulWidget {
  const AllFilesScreen({Key key}) : super(key: key);

  @override
  _AllFilesScreenState createState() => _AllFilesScreenState();
}

class _AllFilesScreenState extends State<AllFilesScreen> {
  Future<GuvenResponseModel> futureResponse;
  String filePath = "";
  LoadingDialog loadingDialog;

  @override
  void initState() {
    super.initState();
    futureResponse = getIt<Repository>().getAllFiles();
  }

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(),
      body: _builBody(context),
    );
  }

  RbioAppBar _buildAppBar() {
    return RbioAppBar(
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).all_appointment_file,
      ),
    );
  }

  Widget _builBody(BuildContext context) {
    return FutureBuilder<GuvenResponseModel>(
      future: futureResponse,
      builder: (
        BuildContext context,
        AsyncSnapshot<GuvenResponseModel> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString() == "network"
                    ? LocaleProvider.of(context).no_network_connection
                    : snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }

          final posts = snapshot.data;
          var datum = posts.datum;
          List<ServerFile> files = <ServerFile>[];
          for (var data in datum) {
            var folder = data.toString().split("/")[0];
            var file = data.toString().replaceFirst('$folder/', "");
            files.add(new ServerFile(folder, file));
          }

          if (files.isNotEmpty) {
            return buildFilesList(context, files);
          } else {
            return Center(
              child: Text(
                LocaleProvider.of(context).no_file_found,
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }
        } else {
          return RbioLoading();
        }
      },
    );
  }

  ListView buildFilesList(BuildContext context, List<ServerFile> files) {
    return ListView.builder(
      itemCount: files.length,
      padding: EdgeInsets.only(left: 5, right: 5, top: 5),
      itemBuilder: (context, index) {
        return _ItemFile(context, files[index].file,
            getFileType(files[index].file), files[index].folder);
      },
    );
  }

  String getFileType(String fileName) {
    File file = new File(fileName);
    return file.path.split('.').last;
  }

  String getFileName(String filePath) {
    File file = new File(filePath);
    return file.path.split('/').last;
  }

  Widget _ItemFile(
      BuildContext context, String fileName, String fileType, String folder) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        margin: EdgeInsets.only(top: 5),
        child: InkWell(
          onTap: () => {onFileTapped(context, fileName, fileType, folder)},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 3,
            child: Container(
              padding:
                  EdgeInsets.only(left: 25, right: 25, top: 16, bottom: 16),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(fileType.toLowerCase() == "pdf"
                      ? R.image.ic_file_icon
                      : R.image.ic_image_icon),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    width: 1,
                    height: 30,
                    color: R.color.dark_white,
                  ),
                  Expanded(
                      child: Text(
                    fileName,
                    style: TextStyle(color: R.color.black, fontSize: 18),
                  )),
                  Container(
                    child: SvgPicture.asset(R.image.ic_arrow_right),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onFileTapped(BuildContext context, String fileName, String fileType,
      String folder) async {
    showLoadingDialog(context);
    final response = await getIt<Repository>()
        .downloadAppointmentSingleFile(folder, fileName);

    final bytes = base64.decode(response.datum);
    var file = File("");

    file = new File('${getIt<GuvenSettings>().appDocDirectory}/$fileName');
    await file.writeAsBytes(bytes);

    List<String> fileNameSplit = fileName.split(".");
    String mimeType = fileNameSplit[fileNameSplit.length - 1];
    if (mimeType == "pdf") {
      hideDialog(context);
      Atom.to(
        PagePaths.FULLPDFVIEWER,
        queryParameters: {
          'title': Uri.encodeFull(fileName),
          'pdfPath': Uri.encodeFull(file.path),
        },
      );
    } else {
      hideDialog(context);
      Atom.to(
        PagePaths.FULLIMAGEVIEWER,
        queryParameters: {
          'title': Uri.encodeFull(fileName),
          'imagePath': Uri.encodeFull(file.path),
        },
      );
    }
  }

  void showLoadingDialog(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) =>
            loadingDialog = loadingDialog ?? LoadingDialog());
  }

  void hideDialog(BuildContext context) {
    if (loadingDialog != null && loadingDialog.isShowing()) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }
}
