import 'package:flutter/material.dart';
import 'package:onedosehealth/core/core.dart';

import '../../SIL_DELETE_DELETE_SIL/sil.dart';

class ECouncilInspectionUploadScreen extends StatelessWidget {
  const ECouncilInspectionUploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(
        context: context,
      ),
      body: const _BuildBody(),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _RequestedInseptionsCard(),
        R.widgets.hSizer12,
        const _BuildFilesCard(),
      ],
    );
  }
}

class _RequestedInseptionsCard extends StatefulWidget {
  const _RequestedInseptionsCard({Key? key}) : super(key: key);

  @override
  State<_RequestedInseptionsCard> createState() =>
      _RequestedInseptionsCardState();
}

class _RequestedInseptionsCardState extends State<_RequestedInseptionsCard> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleProvider.of(context).requested_inspections,
              style: context.xHeadline2.copyWith(fontWeight: FontWeight.bold),
            ),
            for (int i = 0; i < requestedInspections.length; i++)
              Column(
                children: [
                  Row(
                    children: [
                      Text('-${requestedInspections[i].inspectionName}',
                          style: context.xHeadline3),
                      const Spacer(),
                      requestedInspections[i].isUploaded
                          ? Icon(
                              Icons.done,
                              color: context.xPrimaryColor,
                            )
                          : RbioTextButton(
                              padding: EdgeInsets.zero,
                              child: Text(
                                LocaleProvider.of(context).upload,
                                style: context.xSubtitle1.copyWith(
                                  color: context.xPrimaryColor,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  requestedInspections[i] =
                                      requestedInspections[i].copyWith(
                                    isUploaded:
                                        !requestedInspections[i].isUploaded,
                                  );
                                });
                              },
                            ),
                      R.widgets.wSizer40,
                    ],
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

class _BuildFilesCard extends StatelessWidget {
  const _BuildFilesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleProvider.of(context).files,
              style: context.xHeadline2.copyWith(fontWeight: FontWeight.bold),
            ),
            for (int i = 0; i < requestedInspections.length; i++)
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        splashRadius: 14,
                        onPressed: () {},
                      ),
                      Text(
                        '${LocaleProvider.of(context).file_name} - ${requestedInspections[i].inspectionName}',
                        style: context.xSubtitle1,
                      ),
                    ],
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
