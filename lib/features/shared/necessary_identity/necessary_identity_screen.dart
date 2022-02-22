import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';
import 'necessary_identity_vm.dart';

class NecessaryIdentityScreen extends StatefulWidget {
  const NecessaryIdentityScreen({Key? key}) : super(key: key);

  @override
  _NecessaryIdentityScreenState createState() =>
      _NecessaryIdentityScreenState();
}

class _NecessaryIdentityScreenState extends State<NecessaryIdentityScreen> {
  late TextEditingController _identityController;

  @override
  void initState() {
    _identityController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _identityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NecessaryIdentityScreenVm>(
      create: (context) => NecessaryIdentityScreenVm(context),
      child: Consumer<NecessaryIdentityScreenVm>(
        builder: (
          BuildContext context,
          NecessaryIdentityScreenVm value,
          Widget? child,
        ) {
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
                  Atom.dismiss(false);
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
                    child: RbioTextFormField(
                      controller: _identityController,
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      hintText: LocaleProvider.of(context).tc_or_passport,
                      prefixIcon: SvgPicture.asset(
                        R.image.user,
                        fit: BoxFit.none,
                        color: getIt<ITheme>().mainColor,
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 10, top: 20),
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
