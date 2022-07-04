import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../core.dart';

abstract class PermissionManager {
  Future<bool> request({
    required RbioPermissionStrategy permission,
    required BuildContext context,
    String? message,
  });

  Future<void> openSettingsDialog(
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
                R.sizes.hSizer32,

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
                R.sizes.hSizer32,

                //
                Row(
                  children: [
                    R.sizes.wSizer12,
                    Expanded(
                      child: RbioSmallDialogButton.red(
                        title: LocaleProvider.current.not_now,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    R.sizes.wSizer8,
                    Expanded(
                      child: RbioSmallDialogButton.green(
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
                    R.sizes.wSizer12,
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

class PermissionManagerImpl extends PermissionManager {
  @override
  Future<bool> request({
    required RbioPermissionStrategy permission,
    required BuildContext context,
    String? message,
  }) =>
      _request(
        context: context,
        item: permission,
        message: message,
      );

  Future<bool> _request({
    required BuildContext context,
    required RbioPermissionStrategy item,
    String? message,
  }) async {
    if (Platform.isIOS) {
      if (item.iosResponse != null) {
        return item.iosResponse!;
      }
    } else {
      if (item.androidResponse != null) {
        return item.androidResponse!;
      }
    }

    final permissionStatus = await item.permission.status;
    late bool result;

    switch (permissionStatus) {
      case PermissionStatus.granted:
      case PermissionStatus.limited: // iOS
        result = true;
        break;

      case PermissionStatus.permanentlyDenied: // iOS
        {
          await getIt<PermissionManager>().openSettingsDialog(
            context,
            message ?? item.permanentlyDeniedMessage,
          );
          result = false;
          break;
        }

      default:
        {
          final permissionResult = await item.permission.request();

          if (Platform.isAndroid) {
            final shouldShowRequestRationale =
                await item.permission.shouldShowRequestRationale;
            if (!shouldShowRequestRationale &&
                permissionResult == PermissionStatus.permanentlyDenied) {
              await getIt<PermissionManager>().openSettingsDialog(
                context,
                message ?? item.permanentlyDeniedMessage,
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
  CameraPermissionStrategy()
      : super(Permission.camera, _PermissionMessages.permissionCamera);
}

class MicrophonePermissionStrategy extends RbioPermissionStrategy {
  MicrophonePermissionStrategy()
      : super(Permission.microphone, _PermissionMessages.permissionMicrophone);
}

class GalleryPermissionStrategy extends RbioPermissionStrategy {
  GalleryPermissionStrategy()
      : super(Platform.isAndroid ? Permission.storage : Permission.photos,
            _PermissionMessages.permissionGallery);
}

class _PermissionMessages {
  _PermissionMessages._();

  static const String app = 'OneDoseHealth\'in';

  static String permissionCamera = Platform.isIOS
      ? '$app kameranıza erişimi yok. Erişime izin vermek için, Ayarlar\'a dokunun ve Kamera\'yı etkinleştirin.'
      : 'Fotoğraf ve video çekmek için $app kameranıza erişimine izin verin. Ayarlar > İzinler\'e dokunun ve Kamera\'yı açık konuma getirin.';

  static String permissionMicrophone = Platform.isIOS
      ? 'Sesli video kaydedebilmek için $app mikrofona erişmesi gerekiyor. Erişime izin vermek için, Ayarlar\'a dokunun ve Mikrofon\'u açın.'
      : 'Videoları sesli mi kaydetmek istiyorsunuz? $app mikrofununuza erişimine izin verin. Ayarlar > İzinler\'e giderek Mikrofon\'u açık konuma getirin.';

  static String permissionGallery = Platform.isIOS
      ? '$app fotoğraflarınıza veya videolarınıza erişimi yok. Erişime izin vermek için, Ayarlar\'a dokunun ve Fotoğraflar\'ı açın.'
      : '$app fotoğraf, medya ve dosyalara erişimi yok. Ayarlar > İzinler\'e dokunun ve Depolama\'yı açık konuma getirin.';
}
