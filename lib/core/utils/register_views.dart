import 'package:onedosehealth/core/platform/mobil_interface.dart'
    if (dart.library.html) 'package:onedosehealth/core/platform/web_interface.dart';

import 'package:onedosehealth/generated/l10n.dart';
import 'package:universal_html/html.dart';

class RegisterViews {
  RegisterViews._();

  static RegisterViews _instance;

  static RegisterViews get instance {
    _instance ??= RegisterViews._();
    return _instance;
  }

  void init() {
    MobileWebInterface.registerViewFactory(
      'kvkk',
      (int viewId) => IFrameElement()
        ..width = '640'
        ..height = '360'
        ..src = 'https://app.guven.com.tr/assets/static/kvkk_en.html'
        ..style.border = 'none',
    );

    MobileWebInterface.registerViewFactory(
      'tawkto',
      (int viewId) => IFrameElement()
        ..width = '640'
        ..height = '360'
        ..src = LocaleProvider.current.tawkto_url
        ..style.border = 'none',
    );

    MobileWebInterface.registerViewFactory(
      'cancellationRefund',
      (int viewId) => IFrameElement()
        ..width = '640'
        ..height = '360'
        ..src = '${LocaleProvider.current.iptal_url}'
        ..style.border = 'none',
    );
  }

  void doMobilePayment(String html) {
    final result = """<html>
        <body onload="document.getElementsByTagName('form')[0].submit();">
          <center><p>Loading...</p></center>
          <div style="opacity: 0">$html</div>
        </body>
        </html>""";

    MobileWebInterface.registerViewFactory(
      'PayPalButtons',
      (int viewId) => IFrameElement()
        ..width = '300px'
        ..height = '300px'
        ..srcdoc = result
        ..style.border = 'none',
    );
  }
}
