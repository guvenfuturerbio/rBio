import 'package:flutter/material.dart';

import '../core.dart';

class RbioDeleteConfirmationDialog extends StatelessWidget {
  final String description;
  final void Function() deleteConfirm;

  const RbioDeleteConfirmationDialog({
    Key? key,
    required this.description,
    required this.deleteConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: getIt<IAppConfig>().theme.cardBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      title: GuvenAlert.buildTitle(
        LocaleProvider.current.warning,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          R.sizes.hSizer12,

          //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GuvenAlert.buildDescription(
              description,
            ),
          ),

          //
          R.sizes.hSizer16,

          //
          Row(
            children: [
              R.sizes.wSizer12,
              Expanded(
                child: GuvenAlert.buildMaterialRedAction(
                  LocaleProvider.current.delete,
                  () {
                    Atom.dismiss();
                    deleteConfirm();
                  },
                ),
              ),
              R.sizes.wSizer8,
              Expanded(
                child: GuvenAlert.buildMaterialWhiteAction(
                  LocaleProvider.current.btn_cancel,
                  () {
                    Atom.dismiss();
                  },
                ),
              ),
              R.sizes.wSizer12,
            ],
          ),
        ],
      ),
      actions: const [],
    );
  }
}
