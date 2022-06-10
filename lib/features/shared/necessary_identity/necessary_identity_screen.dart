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
          return Dialog(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Text(
                      LocaleProvider.current.warning,
                      style:
                          getIt<IAppConfig>().theme.dialogTheme.title(context),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  R.sizes.hSizer32,

                  Center(
                    child: Text(
                      LocaleProvider.current.necessary_identity_message,
                      style: getIt<IAppConfig>()
                          .theme
                          .dialogTheme
                          .description(context),
                      textAlign: TextAlign.center,
                    ),
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
                        color: getIt<IAppConfig>().theme.mainColor,
                      ),
                    ),
                    margin: const EdgeInsets.only(bottom: 10, top: 20),
                  ),

                  R.sizes.hSizer8,

                  Row(
                    children: [
                      R.sizes.wSizer12,
                      Expanded(
                        child: RbioSmallDialogButton.red(
                          title: LocaleProvider.current.btn_cancel,
                          onPressed: () {
                            Atom.dismiss();
                          },
                        ),
                      ),
                      R.sizes.wSizer8,
                      Expanded(
                        child: RbioSmallDialogButton.green(
                            title: LocaleProvider.current.Ok,
                            onPressed: () {
                              Atom.dismiss();
                              Atom.to(PagePaths.healthInformation);
                            }),
                      ),
                      R.sizes.wSizer12,
                    ],
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
