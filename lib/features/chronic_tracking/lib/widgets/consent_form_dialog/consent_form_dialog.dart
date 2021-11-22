import 'package:flutter/material.dart';
import 'package:onedosehealth/core/locator.dart';
import 'package:onedosehealth/core/theme/main_theme.dart';

import 'package:onedosehealth/generated/l10n.dart';
import 'package:provider/provider.dart';

import 'consent_form_dialog_vm.dart';

class ConsentFormDialog extends StatefulWidget {
  ConsentFormDialog({this.title, this.text, this.alwaysAsk});
  final String title;
  final String text;
  final alwaysAsk;
  @override
  State<StatefulWidget> createState() {
    return new _ConsentFormDialogState();
  }
}

class _ConsentFormDialogState extends State<ConsentFormDialog> {
  @override
  Widget build(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text(LocaleProvider.current.Ok),
      textColor: Colors.white,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      backgroundColor: getIt<ITheme>().mainColor,
      title: Text(
        widget.title,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                        child: Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.white),
                          child: Checkbox(
                              value: value.clickedConsentForm,
                              checkColor: Colors.white,
                              onChanged: (newValue) {
                                value.toggleConsentFormState();
                              },
                              activeColor: getIt<ITheme>().mainColor),
                        ),
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          value.toggleConsentFormState();
                        },
                        child: Text(
                            LocaleProvider
                                .current.accept_application_consent_form,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: getIt<ITheme>().textColor,
                              decoration: TextDecoration.underline,
                            )),
                      ))
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
      contentPadding: EdgeInsets.all(0.0),
    );
  }

  Gradient BlueGradient() => LinearGradient(
      colors: [getIt<ITheme>().mainColor, getIt<ITheme>().mainColor],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
}
