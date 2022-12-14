import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return GuvenAlert(
      backgroundColor: Colors.white,
      title: GuvenAlert.buildTitle(widget.title),
      content: SingleChildScrollView(
        child: ChangeNotifierProvider<KvkkFormScreenVm>(
          create: (context) => KvkkFormScreenVm(
            context: context,
            alwaysAsk: widget.alwaysAsk,
          ),
          child: Consumer<KvkkFormScreenVm>(
            builder: (context, value, child) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //
                    GuvenAlert.buildSmallDescription(widget.text),

                    //
                    const SizedBox(
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
                              LocaleProvider.of(context).read_understood_kvkk,
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
                            value.saveFormState();
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
