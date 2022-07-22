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
      backgroundColor: context.xCardColor,
      shape: R.sizes.defaultShape,
      title: GuvenAlert.buildTitle(
        context,
        LocaleProvider.current.warning,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          R.widgets.hSizer12,

          //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GuvenAlert.buildDescription(
              context,
              description,
            ),
          ),

          //
          R.widgets.hSizer16,

          //
          Row(
            children: [
              //
              R.widgets.wSizer12,

              //
              Expanded(
                child: GuvenAlert.buildMaterialRedAction(
                  context,
                  LocaleProvider.current.delete,
                  () {
                    Atom.dismiss();
                    deleteConfirm();
                  },
                ),
              ),

              //
              R.widgets.wSizer8,

              //
              Expanded(
                child: GuvenAlert.buildMaterialWhiteAction(
                  context,
                  LocaleProvider.current.btn_cancel,
                  () {
                    Atom.dismiss();
                  },
                ),
              ),
              R.widgets.wSizer12,
            ],
          ),
        ],
      ),
      actions: const [],
    );
  }
}
