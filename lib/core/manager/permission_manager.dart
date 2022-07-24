import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../config/config.dart';
import '../core.dart';

abstract class PermissionManager {
  Future<bool> request({
    required RbioPermissionStrategy permission,
    required BuildContext context,
    String? message,
  });
}

class PermissionManagerImpl extends PermissionManager {
  @override
  Future<bool> request({
    required RbioPermissionStrategy permission,
    required BuildContext context,
    String? message,
  }) async {
    if (Platform.isIOS) {
      if (permission.iosResponse != null) {
        return permission.iosResponse!;
      }
    } else {
      if (permission.androidResponse != null) {
        return permission.androidResponse!;
      }
    }

    final permissionStatus = await permission.permission.status;
    late bool result;

    switch (permissionStatus) {
      case PermissionStatus.granted:
      case PermissionStatus.limited: // iOS
        result = true;
        break;

      case PermissionStatus.permanentlyDenied: // iOS
        {
          await _openSettingsDialog(
            context,
            message ?? permission.permanentlyDeniedMessage,
          );
          result = false;
          break;
        }

      default:
        {
          final permissionResult = await permission.permission.request();

          if (Platform.isAndroid) {
            final shouldShowRequestRationale =
                await permission.permission.shouldShowRequestRationale;
            if (!shouldShowRequestRationale &&
                permissionResult == PermissionStatus.permanentlyDenied) {
              await _openSettingsDialog(
                context,
                message ?? permission.permanentlyDeniedMessage,
              );
              result = false;
            } else {
              result = permissionResult == PermissionStatus.granted ||
                  permissionResult == PermissionStatus.limited;
            }
          } else {
            result = permissionResult == PermissionStatus.granted ||
                permissionResult == PermissionStatus.limited;
          }

          break;
        }
    }

    return result;

    // Android ve iOS'da uygulama ilk açıldığında -> PermissionStatus.denied
    //
    // Android
    // Açılan dialog'un dışarısında bir yere dokunursan false dönüyor. (PermissionStatus.permanentlyDenied)
    // 1-) While using the app (Allow only while using the app)  -> seçeneğine dokun 'true' dönüyor. Tekrardan metodu çalıştırırsan "PermissionStatus.granted" durumundadur.
    // 2-) Only this time      (Ask Every Time)                  -> seçeneğine dokun 'true' dönüyor. Tekrardan metodu çalıştırırsan "PermissionStatus.granted" durumundadur. Uygulama her kapatılıp - açıldığında tekrardan soruyor.
    // 3-) Deny                (Deny)                            -> seçeneğine dokun 'false' dönüyor. Tekrardan metodu çalıştırırsan "PermissionStatus.denied" durumundadur. Tekrardan metodu çalıştırırsan "PermissionStatus.permanentlyDenied" durumundadur. Tekrardan kullanıcıya alert çıkartmaz.
    //
    // iOS
    // Açılan dialog'da
    // 1-) Don't allow -> seçeneğine dokun 'false' dönüyor. Tekrardan metodu çalıştırırsan 'PermissionStatus.permanentlyDenied' case'ine düşüyor.
    // 2-) Ok          -> seçeneğine dokun 'true' dönüyor. Tekrardan metodu çalıştırırsan "PermissionStatus.granted" durumundadur.
  }

  Future<void> _openSettingsDialog(
    BuildContext context,
    String message, {
    AsyncCallback? callback,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return RbioBaseGreyDialog(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                Text(
                  LocaleProvider.current.warning,
                  style: getIt<IAppConfig>().theme.dialogTheme.title(context),
                ),

                //
                R.widgets.hSizer32,

                //
                Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: getIt<IAppConfig>()
                        .theme
                        .dialogTheme
                        .description(context),
                  ),
                ),

                //
                R.widgets.hSizer32,

                //
                Row(
                  children: [
                    //
                    R.widgets.wSizer12,

                    //
                    Expanded(
                      child: RbioSmallDialogButton.red(
                        context,
                        title: LocaleProvider.current.not_now,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),

                    //
                    R.widgets.wSizer8,

                    //
                    Expanded(
                      child: RbioSmallDialogButton.main(
                        context: context,
                        title: LocaleProvider.current.settings,
                        onPressed: () async {
                          Navigator.of(context).pop();

                          if (callback == null) {
                            await openAppSettings();
                          } else {
                            await callback();
                          }
                        },
                      ),
                    ),

                    //
                    R.widgets.wSizer12,
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

abstract class RbioPermissionStrategy {
  final Permission permission;
  final String permanentlyDeniedMessage;

  final bool? iosResponse;
  final bool? androidResponse;

  RbioPermissionStrategy(
    this.permission,
    this.permanentlyDeniedMessage, {
    this.iosResponse,
    this.androidResponse,
  });
}

class CameraPermissionStrategy extends RbioPermissionStrategy {
  CameraPermissionStrategy(LocaleProvider localeProvider, IAppConfig appConfig)
      : super(
          Permission.camera,
          Atom.isIOS
              ? localeProvider.permission_camera_message_ios(appConfig.title)
              : localeProvider
                  .permission_camera_message_android(appConfig.title),
        );
}

class MicrophonePermissionStrategy extends RbioPermissionStrategy {
  MicrophonePermissionStrategy(
      LocaleProvider localeProvider, IAppConfig appConfig)
      : super(
          Permission.microphone,
          Atom.isIOS
              ? localeProvider
                  .permission_microphone_message_ios(appConfig.title)
              : localeProvider
                  .permission_microphone_message_android(appConfig.title),
        );
}

class GalleryPermissionStrategy extends RbioPermissionStrategy {
  GalleryPermissionStrategy(LocaleProvider localeProvider, IAppConfig appConfig)
      : super(
          Atom.isAndroid ? Permission.storage : Permission.photos,
          Atom.isIOS
              ? localeProvider.permission_gallery_message_ios(appConfig.title)
              : localeProvider
                  .permission_gallery_message_android(appConfig.title),
        );
}
