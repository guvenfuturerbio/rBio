import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/widgets/guven_alert.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import 'necessary_identity_vm.dart';

class NecessaryIdentityScreen extends StatefulWidget {
  const NecessaryIdentityScreen({Key key}) : super(key: key);

  @override
  _NecessaryIdentityScreenState createState() =>
      _NecessaryIdentityScreenState();
}

class _NecessaryIdentityScreenState extends State<NecessaryIdentityScreen> {
  TextEditingController _identityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NecessaryIdentityScreenVm>(
      create: (context) => NecessaryIdentityScreenVm(context: context),
      child: Consumer<NecessaryIdentityScreenVm>(
        builder: (BuildContext context, NecessaryIdentityScreenVm value,
            Widget child) {
          return GuvenAlert(
            backgroundColor: Colors.white,
            title: GuvenAlert.buildTitle(LocaleProvider.current.warning),
            actions: [
              GuvenAlert.buildMaterialAction(
                LocaleProvider.of(context).Ok,
                () {
                  value.updateIdentity(_identityController.text);
                },
              ),

              //
              GuvenAlert.buildMaterialAction(
                LocaleProvider.of(context).btn_cancel,
                () {
                  Navigator.pop(context, false);
                },
              ),
            ],
            content: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GuvenAlert.buildDescription(
                    LocaleProvider.current.necessary_identity_message,
                  ),

                  //
                  Container(
                    child: TextFormField(
                      controller: _identityController,
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      style: inputTextStyle(),
                      decoration: inputImageDecorationRed(
                        hintText: LocaleProvider.of(context).tc_or_passport,
                        image: R.image.ic_user,
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 10, top: 20),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
