import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import '../core.dart';

class RbioErrorScreenBody extends StatelessWidget {
  final String errorMsg;

  const RbioErrorScreenBody({
    Key? key,
    required this.errorMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Linkify(
          onOpen: (link) async {
            await getIt<UrlLauncherManager>().launch(link.url);
          },
          text: errorMsg,
          style: context.xHeadline2,
          textAlign: TextAlign.center,
        ),
        _buildGap(),
        RbioElevatedButton(
          onTap: () {
            Atom.historyBack();
          },
          title: LocaleProvider.current.turn_back,
        ),
      ],
    );
  }

  Widget _buildGap() => R.widgets.hSizer16;
}
