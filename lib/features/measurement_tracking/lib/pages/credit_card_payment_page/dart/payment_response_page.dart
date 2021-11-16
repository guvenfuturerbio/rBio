import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/extension/size_extension.dart';
import 'package:onedosehealth/generated/l10n.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/helper/resources.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/pages/credit_card_payment_page/dart/payment_response_page_view_model.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:onedosehealth/features/measurement_tracking/lib/widgets/utils.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentResponsePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PaymentResponsePage> {
  @override
  Widget build(BuildContext context) {
    final url = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: CustomAppBar(
          preferredSize: Size.fromHeight(context.HEIGHT * .18),
          title: TitleAppBarWhite(title: LocaleProvider.current.payment),
          leading: InkWell(
              child: SvgPicture.asset(R.image.back_icon),
              onTap: () => Navigator.of(context).pop())),
      extendBodyBehindAppBar: true,
      backgroundColor: R.color.white,
      body: ChangeNotifierProvider(
        create: (context) =>
            PaymentResponsePageViewModel(context: context, url: url),
        child: Consumer<PaymentResponsePageViewModel>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: context.HEIGHT * .18,
                  ),
                  SizedBox(
                    height: context.HEIGHT * .82,
                    child: WebView(
                      initialUrl: Uri.dataFromString(
                        value.html,
                        mimeType: 'text/html',
                      ).toString(),
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
