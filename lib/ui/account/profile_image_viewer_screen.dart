import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';

import '../../core/core.dart';
import '../../generated/l10n.dart';

class ProfileImageViewerScreen extends StatefulWidget {
  String title;
  String imagePath;

  ProfileImageViewerScreen({
    Key key,
    this.imagePath,
    this.title,
  }) : super(key: key);

  @override
  ProfileImageViewerScreenState createState() =>
      ProfileImageViewerScreenState();
}

class ProfileImageViewerScreenState extends State<ProfileImageViewerScreen> {
  bool firstBuild = false;

  File _image = File("");
  final picker = ImagePicker();
  LoadingDialog loadingDialog;

  @override
  Widget build(BuildContext context) {
    try {
      if (!firstBuild) {
        widget.title = Uri.decodeFull(Atom.queryParameters['title']);
        widget.imagePath = Uri.decodeFull(Atom.queryParameters['imagePath']);

        if (widget.imagePath != "") {
          _image = File(widget.imagePath);
        }

        firstBuild = true;
      }
    } catch (_) {
      return QueryParametersError();
    }

    return Scaffold(
      appBar: MainAppBar(
        context: context,
        title: TitleAppBarWhite(
          title: widget.title,
        ),
        leading: IconButton(
          onPressed: () => Atom.historyBack(),
          icon: SvgPicture.asset(R.image.ic_back_white),
        ),
      ),

      //
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: 300,
              child: getNoImageAvatar(context),
            ),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: button(
                      text: LocaleProvider.of(context).delete,
                      onPressed: () {
                        UtilityManager().showConfirmationAlertDialog(
                          context,
                          LocaleProvider.of(context).warning,
                          LocaleProvider.of(context).profile_picture_delete,
                          FlatButton(
                            child: Text(LocaleProvider.of(context).Ok),
                            textColor: Colors.white,
                            onPressed: () async {
                              AnalyticsManager()
                                  .sendEvent(new ProfilePictureDeleteEvent());
                              await getIt<Repository>().deleteProfilePicture();
                              Navigator.of(context).pop();
                              setState(() {
                                _image = new File("");
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),

                //
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: button(
                      text: LocaleProvider.of(context).save,
                      onPressed: () {
                        UtilityManager().showConfirmationAlertDialog(
                          context,
                          LocaleProvider.of(context).warning,
                          LocaleProvider.of(context).profile_picture_change,
                          FlatButton(
                            child: Text(LocaleProvider.of(context).Ok),
                            textColor: Colors.white,
                            onPressed: () async {
                              showLoadingDialog(context);
                              if (_image.path == "") {
                                hideDialog(context);
                                Navigator.of(context).pop();
                              } else {
                                await getIt<Repository>()
                                    .uploadProfilePicture(_image);
                                hideDialog(context);
                                AnalyticsManager()
                                    .sendEvent(new ProfilePictureUploadEvent());
                                Navigator.of(context).pop();
                                Atom.historyBack();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getNoImageAvatar(BuildContext context) {
    return Center(
      child: CustomCircleAvatar(
        child: GestureDetector(
          onTap: () {
            getImage(context);
          },
          child: getImageFromWidget(),
        ),
        size: 250,
      ),
    );
  }

  Widget getImageFromWidget() {
    if (widget.imagePath == "" && this._image.path == "") {
      // User has not uploaded any image so far!
      return SvgPicture.asset(
        R.image.profile_avatar,
        fit: BoxFit.fill,
      );
    } else {
      return _image.path == ""
          ? SvgPicture.asset(
              R.image.profile_avatar,
              fit: BoxFit.fill,
            )
          : PhotoView(
              imageProvider: FileImage(File(_image.path)),
            );
    }
  }

  Future<void> getImage(BuildContext context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String title = LocaleProvider.of(context).how_to_get_photo;
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(LocaleProvider.of(context).pick_a_photo_option),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      LocaleProvider.of(context).camera,
                    ),
                    isDefaultAction: true,
                    onPressed: () {
                      getPhotoFromSource(context, ImageSource.camera);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      LocaleProvider.of(context).gallery,
                    ),
                    isDefaultAction: true,
                    onPressed: () {
                      getPhotoFromSource(context, ImageSource.gallery);
                    },
                  ),
                ],
              )
            : new GuvenAlert(
                title: Text(
                  title,
                  style: TextStyle(fontSize: 22),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(LocaleProvider.of(context).camera),
                    onPressed: () {
                      getPhotoFromSource(context, ImageSource.camera);
                    },
                  ),
                  FlatButton(
                    child: Text(LocaleProvider.of(context).gallery),
                    onPressed: () {
                      getPhotoFromSource(context, ImageSource.gallery);
                    },
                  )
                ],
              );
      },
    );
  }

  void getPhotoFromSource(BuildContext context, ImageSource imageSource) async {
    var photoPerm, cameraPerm;
    if (imageSource == ImageSource.gallery) {
      photoPerm = await Permission.photos.request();
      if (Platform.isAndroid) {
        photoPerm = await Permission.storage.request();
      }
    } else {
      cameraPerm = await Permission.camera.request();
    }

    if (photoPerm == PermissionStatus.denied ||
        photoPerm == PermissionStatus.permanentlyDenied) {
      UtilityManager().showConfirmationAlertDialog(
          context,
          LocaleProvider.of(context).warning,
          LocaleProvider.of(context).allow_permission_gallery,
          FlatButton(
            child: Text(LocaleProvider.of(context).confirm),
            textColor: Colors.white,
            onPressed: () async {
              Navigator.of(context).pop();
              AppSettings.openAppSettings();
            },
          ));
      return;
    } else if (cameraPerm == PermissionStatus.denied ||
        cameraPerm == PermissionStatus.permanentlyDenied) {
      UtilityManager().showConfirmationAlertDialog(
          context,
          LocaleProvider.of(context).warning,
          LocaleProvider.of(context).allow_permission_gallery,
          FlatButton(
            child: Text(LocaleProvider.of(context).confirm),
            textColor: Colors.white,
            onPressed: () async {
              Navigator.of(context).pop();
              AppSettings.openAppSettings();
            },
          ));
      return;
    }

    final pickedFile = await picker.getImage(source: imageSource);
    Navigator.of(context).pop();

    if (pickedFile != null) {
      setState(() {
        print(pickedFile.path);
        _image = new File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  void shareFile(BuildContext context, String path) async {
    if (path == "") {
      return;
    }
    await FlutterShare.shareFile(
      title: LocaleProvider.of(context).share,
      text: widget.title,
      filePath: path,
    );
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
