import 'package:flutter/material.dart';
import 'package:onedosehealth/core/widgets/guven_alert.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import 'kvkk_form_vm.dart';

class KvkkFormScreen extends StatefulWidget {
  final String title;
  final String text;
  final alwaysAsk;

  KvkkFormScreen({
    Key key,
    this.title,
    this.text,
    this.alwaysAsk,
  }) : super(key: key);

  @override
  _KvkkFormScreenState createState() => _KvkkFormScreenState();
}

class _KvkkFormScreenState extends State<KvkkFormScreen> {
  @override
  Widget build(BuildContext context) {
    return GuvenAlert(
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      content: SingleChildScrollView(
        child: ChangeNotifierProvider<KvkkFormScreenVm>(
          create: (context) => KvkkFormScreenVm(
            context: context,
            alwaysAsk: widget?.alwaysAsk ?? false,
          ),
          child: Consumer<KvkkFormScreenVm>(
            builder: (context, value, child) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                /*decoration: new BoxDecoration(
                  gradient: BlueGradient()),*/
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              LocaleProvider.of(context).read_understood_kvkk,
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
                          value.saveFormState();
                        },
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

  Gradient BlueGradient() => LinearGradient(
      colors: [R.color.blue, R.color.light_blue],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
}
