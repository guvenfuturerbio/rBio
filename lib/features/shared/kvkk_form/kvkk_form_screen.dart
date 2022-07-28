import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import 'kvkk_form_vm.dart';

class KvkkFormScreen extends StatefulWidget {
  final String title;
  final String text;
  final bool alwaysAsk;

  const KvkkFormScreen({
    Key? key,
    required this.title,
    required this.text,
    required this.alwaysAsk,
  }) : super(key: key);

  @override
  _KvkkFormScreenState createState() => _KvkkFormScreenState();
}

class _KvkkFormScreenState extends State<KvkkFormScreen> {
  @override
  Widget build(BuildContext context) {
    return RbioBaseDialog(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            Center(
              child: Text(
                LocaleProvider.current.kvkk_title,
                style: context.xDialogTheme.titleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),

            //
            R.widgets.hSizer24,

            //
            SingleChildScrollView(
              child: ChangeNotifierProvider<KvkkFormScreenVm>(
                create: (context) => KvkkFormScreenVm(
                  context: context,
                  alwaysAsk: widget.alwaysAsk,
                ),
                child: Consumer<KvkkFormScreenVm>(
                  builder: (context, value, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Center(
                          child: Text(
                            getIt<IAppConfig>().constants.kvkkUrl(context),
                            style: context.xDialogTheme.descriptionTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //

                        //

                        //
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: RbioCheckbox(
                                value: value.clickedConsentForm,
                                onChanged: (newValue) {
                                  value.toggleConsentFormState();
                                },
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  value.toggleConsentFormState();
                                },
                                child: GuvenAlert.buildSmallDescription(
                                  context,
                                  LocaleProvider.of(context)
                                      .read_understood_kvkk,
                                  textAlign: TextAlign.start,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),

                        //
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Center(
                            child: GuvenAlert.buildBigMaterialAction(
                              context,
                              LocaleProvider.current.Ok.toUpperCase(),
                              () {
                                value.saveFormState();
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
