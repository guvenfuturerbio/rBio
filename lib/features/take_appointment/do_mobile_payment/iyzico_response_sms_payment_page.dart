import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/core.dart';
import 'iyzico_response_vm.dart';

class IyzicoResponseSmsPaymentScreen extends StatefulWidget {
  final String html;
  final String uid;
  bool fromDeepLink;
  final String departmentName;
  final String doctorName;
  final String appointmentType;
  final String hospitalName;
  final String appointmentFee;
  final bool fromCovidPcr;

  IyzicoResponseSmsPaymentScreen({
    Key? key,
    required this.uid,
    required this.html,
    required this.departmentName,
    required this.doctorName,
    required this.appointmentType,
    required this.hospitalName,
    required this.appointmentFee,
     this.fromDeepLink = false,
     this.fromCovidPcr = false,
  }) : super(key: key);

  @override
  _IyzicoResponseSmsPaymentScreenState createState() =>
      _IyzicoResponseSmsPaymentScreenState(html);
}

@override
class _IyzicoResponseSmsPaymentScreenState
    extends State<IyzicoResponseSmsPaymentScreen> {

  final String html;

  _IyzicoResponseSmsPaymentScreenState(String formHtml)
      : html = """<html>
        <body onload="document.getElementsByTagName('form')[0].submit();">
          <center><p>Loading...</p></center>
          <div style="opacity: 0">$formHtml</div>
        </body>
        </html>""";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IyzicoResponseVm>(
      create: (context) => IyzicoResponseVm(widget.uid),
      child: Consumer<IyzicoResponseVm>(
        builder: (context, vm, child) {
          return RbioScaffold(
            appbar: RbioAppBar(),
            body: kIsWeb
                ? HtmlElementView(
                    viewType: "PayPalButtons",
                  )
                : WebView(
                    initialUrl: Uri.dataFromString(
                      html,
                      mimeType: 'text/html',
                    ).toString(),
                    javascriptMode: JavascriptMode.unrestricted,
                  ),
          );
        },
      ),
    );
  }
}
