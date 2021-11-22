import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import '../../../generated/l10n.dart';
import 'consent_form_dialog_vm.dart';

class ConsentFormDialog extends StatefulWidget {
  final String title;
  final String text;
  final alwaysAsk;

  ConsentFormDialog({
    Key key,
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
    return GuvenAlert(
      backgroundColor: Colors.white,
      title: GuvenAlert.buildTitle(widget.title),
      content: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => ConsentFormDialogVm(
            context: context,
            alwaysAsk: widget?.alwaysAsk ?? false,
          ),
          child: Consumer<ConsentFormDialogVm>(
            builder: (BuildContext context, ConsentFormDialogVm value,
                Widget child) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //
                    GuvenAlert.buildSmallDescription(widget.text),

                    //
                    SizedBox(
                      height: 20,
                    ),

                    //
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Checkbox(
                            value: value.clickedConsentForm,
                            checkColor: Colors.white,
                            onChanged: (newValue) {
                              value.toggleConsentFormState();
                            },
                            activeColor: getIt<ITheme>()
                                .mainColor, //  <-- leading Checkbox
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              value.toggleConsentFormState();
                            },
                            child: GuvenAlert.buildSmallDescription(
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
                          LocaleProvider.current.Ok.toUpperCase(),
                          () {
                            value.saveConsentFormState();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
