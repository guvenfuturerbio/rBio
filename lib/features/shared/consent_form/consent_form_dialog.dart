import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/config.dart';
import '../../../core/core.dart';
import 'consent_form_dialog_vm.dart';

class ConsentFormDialog extends StatefulWidget {
  final String? title;
  final String? text;
  final bool? alwaysAsk;

  const ConsentFormDialog({
    Key? key,
    this.title,
    this.text,
    this.alwaysAsk,
  }) : super(key: key);

  @override
  _ConsentFormDialogState createState() => _ConsentFormDialogState();
}

class _ConsentFormDialogState extends State<ConsentFormDialog> {
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
                LocaleProvider.current.approve_consent_form,
                style: getIt<IAppConfig>().theme.dialogTheme.title(context),
                textAlign: TextAlign.center,
              ),
            ),

            //
            R.widgets.hSizer32,

            //
            SingleChildScrollView(
              child: ChangeNotifierProvider<ConsentFormDialogVm>(
                create: (context) => ConsentFormDialogVm(
                  context: context,
                  alwaysAsk: widget.alwaysAsk ?? false,
                ),
                child: Consumer<ConsentFormDialogVm>(
                  builder: (BuildContext context, ConsentFormDialogVm value,
                      Widget? child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Center(
                          child: Text(
                            LocaleProvider
                                .current.application_consent_form_text,
                            style: getIt<IAppConfig>()
                                .theme
                                .dialogTheme
                                .description(context),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        //
                        R.widgets.hSizer8,

                        //
                        Row(
                          children: [
                            //
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: RbioCheckbox(
                                value: value.clickedConsentForm,
                                onChanged: (newValue) {
                                  value.toggleConsentFormState();
                                },
                              ),
                            ),

                            //
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  value.toggleConsentFormState();
                                },
                                child: GuvenAlert.buildSmallDescription(
                                  context,
                                  LocaleProvider.of(context)
                                      .accept_application_consent_form,
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
                                value.saveConsentFormState();
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
