import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/extension/size_extension.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/strings.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';

import '../../generated/l10n.dart';
import '../../helper/resources.dart';
import '../../models/user_profiles/person.dart';
import '../../notifiers/user_profiles_notifier.dart';
import '../../widgets/utils.dart';
import '../../widgets/utils/base_provider_repository.dart';
import '../../widgets/utils/loading_indicator_handler.dart';

class ProfileImageViewerScreen extends StatefulWidget {
  final String title;
  final String imagePath;
  ProfileImageViewerScreen(this.imagePath, this.title);
  @override
  ProfileImageViewerScreenState createState() =>
      ProfileImageViewerScreenState();
}

class ProfileImageViewerScreenState extends State<ProfileImageViewerScreen> {
  File _imageFile = new File("");
  var _imageNetwork = '';
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.imagePath != "") {
      if (widget.imagePath.contains(RegExp(Strings.urlDetect))) {
        _imageNetwork = widget.imagePath;
      } else {
        _imageFile = new File(widget.imagePath);
      }
    }
  }

  fetchImages() async {
    for (Person p in UserProfilesNotifier().profiles.person) {
      File file =
          await BaseProviderRepository().getProfilePictureOfProfile(p.id);
      setState(() {
        p.profileImage = file ?? new File("");
        if (p.id == UserProfilesNotifier().selection.id) {
          UserProfilesNotifier().selection.profileImage = file;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        preferredSize: Size.fromHeight(context.HEIGHT * .18),
        title: TitleAppBarWhite(title: widget.title),
        leading: InkWell(
            child: SvgPicture.asset(R.image.back_icon),
            onTap: () => Navigator.of(context).pop()),
      ),
      body: Column(
        children: <Widget>[
          Container(height: 300, width: 300, child: getNoImageAvatar(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: button(
                    text: LocaleProvider.current.delete,
                    onPressed: () {
                      UtilityManager().showConfirmationAlertDialog(
                          context,
                          LocaleProvider.current.warning,
                          LocaleProvider.current.profile_picture_delete,
                          FlatButton(
                            child: Text(LocaleProvider.current.Ok),
                            textColor: Colors.white,
                            onPressed: () async {
                              await BaseProviderRepository()
                                  .deleteProfilePictureOfCurrentUser();
                              Navigator.of(context).pop();
                              setState(() {
                                _imageFile = new File("");
                              });
                            },
                          ));
                    }),
              )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: button(
                    text: LocaleProvider.current.save,
                    onPressed: () {
                      UtilityManager().showConfirmationAlertDialog(
                          context,
                          LocaleProvider.current.warning,
                          LocaleProvider.current.profile_picture_change,
                          FlatButton(
                            child: Text(LocaleProvider.current.Ok),
                            textColor: Colors.white,
                            onPressed: () async {
                              LoadingIndicatorHandler().showLoading(context);
                              if (_imageFile.path == "") {
                                LoadingIndicatorHandler().hideLoading();
                                Navigator.of(context).pop();
                              } else {
                                await BaseProviderRepository()
                                    .uploadProfilePicture(_imageFile.path);
                                await fetchImages();
                                LoadingIndicatorHandler().hideLoading();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }
                            },
                          ));
                    }),
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget getNoImageAvatar(BuildContext context) {
    return new Container(
      child: Center(
        child: CustomCircleAvatar(
            child: GestureDetector(
              onTap: () {
                getImage(context);
              },
              child: getImageFromWidget(),
            ),
            size: 250),
      ),
    );
  }

  Widget getImageFromWidget() {
    if (_imageFile.path != "") {
      return Image(
        image: FileImage(File(_imageFile.path)),
      );
    } else if (_imageNetwork != "") {
      return Image(
        image: NetworkImage(_imageNetwork),
      );
    } else {
      return SvgPicture.asset(
        R.image.profile_avatar,
        fit: BoxFit.fill,
      );
    }
  }

  Future getImage(BuildContext context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        String title = LocaleProvider.current.how_to_get_photo;
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(LocaleProvider.current.pick_a_photo_option),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      LocaleProvider.current.camera,
                    ),
                    isDefaultAction: true,
                    onPressed: () {
                      getPhotoFromSource(context, ImageSource.camera);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      LocaleProvider.current.gallery,
                    ),
                    isDefaultAction: true,
                    onPressed: () {
                      getPhotoFromSource(context, ImageSource.gallery);
                    },
                  ),
                ],
              )
            : new AlertDialog(
                title: Text(
                  title,
                  style: TextStyle(fontSize: 22),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(LocaleProvider.current.camera),
                    onPressed: () {
                      getPhotoFromSource(context, ImageSource.camera);
                    },
                  ),
                  FlatButton(
                    child: Text(LocaleProvider.current.gallery),
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
          LocaleProvider.current.warning,
          LocaleProvider.current.allow_permission_gallery,
          FlatButton(
            child: Text(LocaleProvider.current.confirm),
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
          LocaleProvider.current.warning,
          LocaleProvider.current.allow_permission_gallery,
          FlatButton(
            child: Text(LocaleProvider.current.confirm),
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
        _imageFile = new File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  void shareFile(BuildContext context, String path) async {
    if (path == "") {
      return;
    }

    Share.shareFiles(
      [path],
      subject: LocaleProvider.current.share,
      text: widget.title,
    ).then((value) => Navigator.of(context).pop());
  }
}

GradientButton button(
        {text: String,
        Function onPressed,
        double height = 16,
        double width = 200}) =>
    GradientButton(
      increaseHeightBy: height,
      increaseWidthBy: width,
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      callback: onPressed,
      gradient: BlueGradient(),
      shadowColor: Colors.black,
    );
