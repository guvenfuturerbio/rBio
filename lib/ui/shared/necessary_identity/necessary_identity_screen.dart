import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onedosehealth/core/widgets/guven_alert.dart';
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
            backgroundColor: R.color.white,
            title: Text(
              LocaleProvider.current.warning,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: R.color.blue),
            ),
            actions: [
              FlatButton(
                child: Text(LocaleProvider.of(context).Ok),
                textColor: R.color.blue,
                onPressed: () {
                  value.updateIdentity(_identityController.text);
                },
              ),
              FlatButton(
                child: Text(LocaleProvider.of(context).btn_cancel),
                textColor: R.color.blue,
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )
            ],
            content: Container(
              padding: const EdgeInsets.all(16.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(LocaleProvider.current.necessary_identity_message,
                      style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: R.color.blue,
                      )),
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

  Gradient BlueGradient() => LinearGradient(
      colors: [R.color.blue, R.color.light_blue],
      begin: Alignment.bottomLeft,
      end: Alignment.centerRight);
}
