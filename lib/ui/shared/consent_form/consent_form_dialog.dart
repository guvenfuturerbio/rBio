import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/src/core/extended_context.dart';

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
    Widget okButton = FlatButton(
      child: Text(LocaleProvider.of(context).Ok),
      textColor: Colors.white,
      onPressed: () {
        widget.text == LocaleProvider.of(context).succefully_created_pass
            ? Atom.to(PagePaths.LOGIN, isReplacement: true)
            : Navigator.of(context).pop();
      },
    );

    return GuvenAlert(
      title: Text(
        widget.title,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      content: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => ConsentFormDialogVm(
              context: context, alwaysAsk: widget?.alwaysAsk ?? false),
          child:
              Consumer<ConsentFormDialogVm>(builder: (context, value, child) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              /*decoration: new BoxDecoration(
                  gradient: BlueGradient()),*/
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(widget.text,
                      style: new TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 20,
                  ),
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
                          activeColor: R.color.blue, //  <-- leading Checkbox
                        ),
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          value.toggleConsentFormState();
                        },
                        child: Text(
                            LocaleProvider.of(context)
                                .accept_application_consent_form,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: R.color.white,
                              decoration: TextDecoration.underline,
                            )),
                      ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: dialogFormButton(
                        text: LocaleProvider.current.Ok.toUpperCase(),
                        height: 12,
                        width: 50,
                        onPressed: () {
                          value.saveConsentFormState();
                        }),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Gradient BlueGradient() => LinearGradient(
      colors: [R.color.blue, R.color.light_blue],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
}
