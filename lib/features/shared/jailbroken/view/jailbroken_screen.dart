import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class JailbrokenScreen extends StatefulWidget {
  const JailbrokenScreen({Key? key}) : super(key: key);

  @override
  State<JailbrokenScreen> createState() => _JailbrokenScreenState();
}

class _JailbrokenScreenState extends State<JailbrokenScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return RbioMessageDialog(
            description:
                getIt<IAppConfig>().constants.jailbreakWarning(context),
            isAtom: false,
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        context: context,
        leading: const SizedBox(width: 0, height: 0),
        leadingWidth: 0,
      ),
      body: Container(),
    );
  }
}
